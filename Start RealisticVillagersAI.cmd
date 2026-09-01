@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"
set "OLLAMA_EXE=%ROOT%ollama.exe"
for %%I in ("%ROOT%..\AI Storage Center") do set "MODEL_STORE=%%~fI"
set "MODEL_NAME=qwen3.5:9b"
set "OLLAMA_HOST=127.0.0.1:11434"
set "OLLAMA_MODELS=%MODEL_STORE%"
set "OLLAMA_MAX_LOADED_MODELS=1"
set "OLLAMA_NUM_PARALLEL=1"
set "OLLAMA_MAX_QUEUE=16"

if not exist "%OLLAMA_EXE%" (
  echo [ERROR] Ollama executable not found: %OLLAMA_EXE%
  echo Keep this script beside ollama.exe.
  pause
  exit /b 1
)
if not exist "%MODEL_STORE%\manifests" (
  echo AI Storage Center not found. Ollama's default model directory will be used.
  set "OLLAMA_MODELS="
)

set "TAGS=%TEMP%\rvai-ollama-tags-%RANDOM%.json"
curl.exe --silent --show-error --fail --max-time 3 "http://%OLLAMA_HOST%/api/tags" > "%TAGS%" 2>nul
if errorlevel 1 (
  echo Starting local Ollama on %OLLAMA_HOST% ...
  set "OLLAMA_EXE=%OLLAMA_EXE%"
  start "" /b powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%ROOT%watch-ollama.ps1"
  set "READY=0"
  for /l %%N in (1,1,30) do (
    timeout /t 1 /nobreak >nul
    curl.exe --silent --show-error --fail --max-time 2 "http://%OLLAMA_HOST%/api/tags" > "%TAGS%" 2>nul
    if not errorlevel 1 (
      set "READY=1"
      goto :ready
    )
  )
  if "!READY!"=="0" (
    echo [ERROR] Ollama did not respond within 30 seconds.
    del "%TAGS%" >nul 2>nul
    pause
    exit /b 2
  )
)

:ready
findstr /i /c:"%MODEL_NAME%" "%TAGS%" >nul 2>&1
if errorlevel 1 (
  echo Model %MODEL_NAME% is not installed locally.
  choice /c YN /n /m "Download it now with Ollama? [Y/N] "
  if errorlevel 2 (
    del "%TAGS%" >nul 2>nul
    echo Cancelled. Ollama remains running without the model.
    pause
    exit /b 3
  )
  "%OLLAMA_EXE%" pull "%MODEL_NAME%"
  if errorlevel 1 (
    echo [ERROR] Model download failed.
    del "%TAGS%" >nul 2>nul
    pause
    exit /b 4
  )
)

del "%TAGS%" >nul 2>nul
echo Ollama is ready at %OLLAMA_HOST%.
echo Model: %MODEL_NAME%
echo Start your Minecraft server and use RealisticVillagersAI.
echo Closing this window stops the Ollama service started by this launcher.
pause
exit /b 0

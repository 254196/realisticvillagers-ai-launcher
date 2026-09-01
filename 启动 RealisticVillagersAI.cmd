@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"
set "OLLAMA_EXE=%ROOT%ollama.exe"
for %%I in ("%ROOT%..\AI存储中心") do set "MODEL_STORE=%%~fI"
set "MODEL_NAME=qwen3.5:9b"
set "OLLAMA_HOST=127.0.0.1:11434"
set "OLLAMA_MODELS=%MODEL_STORE%"
set "OLLAMA_MAX_LOADED_MODELS=1"
set "OLLAMA_NUM_PARALLEL=1"
set "OLLAMA_MAX_QUEUE=16"

if not exist "%OLLAMA_EXE%" (
  echo [错误] 找不到 Ollama：%OLLAMA_EXE%
  echo 请把本脚本与 ollama.exe 放在同一目录。
  pause
  exit /b 1
)
if not exist "%MODEL_STORE%\manifests" (
  echo [错误] 找不到模型目录：%MODEL_STORE%
  echo 请将 AI启动器 与 AI存储中心 一起移动。
  pause
  exit /b 1
)

set "TAGS=%TEMP%\rvai-ollama-tags-%RANDOM%.json"
curl.exe --silent --show-error --fail --max-time 3 "http://%OLLAMA_HOST%/api/tags" > "%TAGS%" 2>nul
if errorlevel 1 (
  echo 正在启动本机 Ollama（仅监听 %OLLAMA_HOST%）...
  set "OLLAMA_EXE=%OLLAMA_EXE%"
  start "" /b powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%ROOT%监视 Ollama.ps1"
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
    echo [错误] Ollama 在 30 秒内没有响应。
    del "%TAGS%" >nul 2>nul
    pause
    exit /b 2
  )
)

:ready
findstr /i /c:"%MODEL_NAME%" "%TAGS%" >nul 2>&1
if errorlevel 1 (
  echo 本地未发现模型 %MODEL_NAME%。
  choice /c YN /n /m "现在下载该模型吗？[Y/N] "
  if errorlevel 2 (
    del "%TAGS%" >nul 2>nul
    echo 已取消。Ollama 仍在运行，但插件暂时无法进行 AI 对话。
    pause
    exit /b 3
  )
  "%OLLAMA_EXE%" pull "%MODEL_NAME%"
  if errorlevel 1 (
    echo [错误] 模型下载失败。
    del "%TAGS%" >nul 2>nul
    pause
    exit /b 4
  )
)

del "%TAGS%" >nul 2>nul
echo Ollama 已就绪：%OLLAMA_HOST%
echo 模型：%MODEL_NAME%
echo 现在可以启动 Minecraft 服务器并使用 RealisticVillagersAI。
echo 关闭此窗口会停止本启动器启动的 Ollama；其他 Ollama 进程不会受影响。
pause
exit /b 0

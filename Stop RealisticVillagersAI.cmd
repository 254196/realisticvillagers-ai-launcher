@echo off
chcp 65001 >nul
set "RVAI_OLLAMA_EXE=%~dp0ollama.exe"
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$exe=[IO.Path]::GetFullPath($env:RVAI_OLLAMA_EXE); $p=Get-Process ollama -ErrorAction SilentlyContinue | Where-Object { $_.Path -eq $exe }; if ($p) { $p | Stop-Process -Force; Write-Host 'Ollama stopped for this launcher.' } else { Write-Host 'No Ollama process from this launcher is running.' }"
pause

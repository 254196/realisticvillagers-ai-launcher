$ErrorActionPreference = 'SilentlyContinue'
$self = Get-CimInstance Win32_Process -Filter "ProcessId=$PID"
$parentPid = if ($self) { $self.ParentProcessId } else { 0 }
$ollama = Start-Process -FilePath $env:OLLAMA_EXE -ArgumentList 'serve' -PassThru
try {
    while ($parentPid -and (Get-Process -Id $parentPid -ErrorAction SilentlyContinue)) {
        Start-Sleep -Milliseconds 500
    }
}
finally {
    if ($ollama -and -not $ollama.HasExited) {
        Stop-Process -Id $ollama.Id -Force -ErrorAction SilentlyContinue
    }
}

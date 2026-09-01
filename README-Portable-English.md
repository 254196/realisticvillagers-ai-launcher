# RealisticVillagersAI portable launcher

Run `Start RealisticVillagersAI.cmd` or `Enable AI Model Listener.cmd` to start Ollama and listen on the local AI endpoint. Use `Stop RealisticVillagersAI.cmd` to close only the Ollama process belonging to this launcher.

The launcher does not contain a drive letter. Move the complete release folder to any drive or directory and keep this relative layout:

```text
any-folder/
|-- AI Launcher/
|   |-- Start RealisticVillagersAI.cmd
|   |-- Enable AI Model Listener.cmd
|   |-- Stop RealisticVillagersAI.cmd
|   |-- Disable AI Model Listener.cmd
|   |-- watch-ollama.ps1
|   `-- ollama.exe and lib/
`-- AI Storage Center/
    |-- blobs/
    `-- manifests/
```

Ollama is bound to `127.0.0.1:11434` only. If the model is missing, the launcher asks before downloading `qwen3.5:9b`. Closing the launcher window stops only the Ollama process it started.

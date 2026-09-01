# RealisticVillagersAI model and launcher

This repository publishes the one-click launcher and configuration guidance for RealisticVillagersAI. It does not redistribute model weights unless the model license explicitly permits it.

## Download and start

1. Install [Ollama for Windows](https://ollama.com/download/windows).
2. Run `ollama pull qwen3.5:9b`, or place a lawfully obtained model in the local model store.
3. Double-click `AI启动器/启动 RealisticVillagersAI.cmd`.
4. Keep the plugin endpoint at `http://127.0.0.1:11434/v1/chat/completions`.

The launcher binds Ollama to loopback only. It never prints or requests an API key and does not expose the service to the LAN or Internet.

## Bug reports

Use the repository's **Bug report** issue form. Include the plugin version, Minecraft/server build, relevant `RVAIDxxx` event codes and reproduction steps. Do not attach API keys, bearer tokens, player data, conversation archives or private server logs.

The `AI启动器` directory is the distributable launcher payload. Large model weights are intentionally excluded from Git history and should be obtained through the model provider's licensed download flow.

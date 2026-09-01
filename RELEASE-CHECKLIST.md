# GitHub release checklist

- Create a public repository for the launcher and issue form.
- Upload `AI启动器/` without model weights or private data.
- Enable the Bug report issue form under `.github/ISSUE_TEMPLATE/`.
- Link the release to the official [Ollama Windows download](https://ollama.com/download/windows) and model license.
- Verify the launcher keeps `OLLAMA_HOST=127.0.0.1:11434`.
- Never commit API keys, bearer tokens, server worlds, conversation archives or credentials.

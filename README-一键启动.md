# RealisticVillagersAI 一键启动器

双击 `启动 RealisticVillagersAI.cmd` 即可启动本机 Ollama，并检查 `qwen3.5:9b`；英文用户使用同目录的 `Start RealisticVillagersAI.cmd`。

启动器是可移动的，不写死 G 盘。请始终保持以下相对结构：

```text
任意目录/
├─ AI启动器/
│  ├─ 启动 RealisticVillagersAI.cmd
│  ├─ Start RealisticVillagersAI.cmd
│  ├─ 监视 Ollama.ps1
│  └─ ollama.exe 与 lib/
└─ AI存储中心/
   ├─ blobs/
   └─ manifests/
```

整个 `AI模型` 文件夹可以移动到任意盘符或目录；不要只移动单个脚本。

- Ollama 只监听 `127.0.0.1:11434`，不会向局域网或公网开放。
- 模型目录固定使用上一级的 `AI存储中心`，不会复制或删除模型文件。
- 找不到模型时会先询问，选择“否”只保留 Ollama 运行，不会偷偷联网下载。
- 服务器配置中的 `endpoint` 应保持为 `http://127.0.0.1:11434/v1/chat/completions`。
- 关闭启动器窗口会停止本启动器启动的 Ollama；其他 Ollama 进程不会受影响。也可以双击 `关闭 RealisticVillagersAI.cmd`。

模型约 6.6 GB，首次加载可能需要较长时间。玩家不需要安装账号、API 密钥或客户端 AI 软件；Ollama 应运行在服务器主机上。

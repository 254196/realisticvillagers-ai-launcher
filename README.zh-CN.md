# RealisticVillagersAI 模型与启动器

本仓库分发一键启动器和配置说明。除非模型许可证明确允许，不直接再分发模型权重。

## 下载与启动

1. 安装 [Ollama Windows 版](https://ollama.com/download/windows)。
2. 执行 `ollama pull qwen3.5:9b`，或把合法取得的模型放入本地模型目录。
3. 双击 `AI启动器/启动 RealisticVillagersAI.cmd`。
4. 插件接口保持为 `http://127.0.0.1:11434/v1/chat/completions`。

启动器只让 Ollama 监听本机回环地址，不向局域网或公网开放，也不会索取或输出 API 密钥。

## Bug 反馈

请使用仓库中的 **Bug report** Issue 表单，填写插件版本、Minecraft/服务端构建号、相关 `RVAIDxxx` 事件码和复现步骤。不要上传 API 密钥、Bearer token、玩家数据、对话记录或私人服务器日志。

# iTerm/iTerm2 ZModem 脚本

[中文](README.md) | [English](README.en.md)

用于在 `iTerm`/`iTerm2` 中通过 `rz/sz`（ZModem）快速上传和下载文件的脚本。

## 功能说明

- `iterm2-send-zmodem.sh`：本地选择文件并发送到远端（配合远端执行 `rz`）。
- `iterm2-recv-zmodem.sh`：本地选择目录并接收远端文件（配合远端执行 `sz`）。
- 自动兼容 `iTerm` 与 `iTerm2`。
- 自动检测 `rz/sz` 是否已安装。

## 环境要求

- macOS
- `iTerm` 或 `iTerm2`
- `lrzsz`（提供 `rz`/`sz` 命令）

安装 `lrzsz`：

```bash
brew install lrzsz
```

## 安装

1. 将脚本放在固定目录，例如：

```bash
mkdir -p ~/.iterm2-zmodem
cp iterm2-send-zmodem.sh ~/.iterm2-zmodem/
cp iterm2-recv-zmodem.sh ~/.iterm2-zmodem/
chmod +x ~/.iterm2-zmodem/iterm2-*.sh
```

2. 在 iTerm2 中添加 Trigger：

路径：`iTerm2 -> Settings -> Profiles -> Advanced -> Triggers -> Edit`

添加两条规则（Action 均选 `Run Silent Coprocess`）：

| Regular Expression | Parameters |
| --- | --- |
| `\*\*B0100` | `~/.iterm2-zmodem/iterm2-send-zmodem.sh` |
| `\*\*B00000000000000` | `~/.iterm2-zmodem/iterm2-recv-zmodem.sh` |

> 如果你的脚本路径不同，请替换为实际绝对路径。

## 使用方法

### 上传（本地 -> 远端）

1. 在远端终端执行：

```bash
rz
```

2. 本地会弹出文件选择框，选择要上传的文件。

### 下载（远端 -> 本地）

1. 在远端终端执行：

```bash
sz <文件名>
```

例如：

```bash
sz app.log
```

2. 本地会弹出目录选择框，选择保存目录。

## 常见问题

- 提示 `rz not found` / `sz not found`：
  - 确认已安装 `lrzsz`。
  - 脚本已包含 `PATH`：`/opt/homebrew/bin:/usr/local/bin:$PATH`，通常可覆盖 Intel 与 Apple Silicon 的 Homebrew 路径。

- 触发器不生效：
  - 确认 Trigger 配置在当前使用的 Profile 下。
  - 确认脚本有执行权限：`chmod +x ~/.iterm2-zmodem/iterm2-*.sh`。
  - 尝试使用脚本绝对路径而非 `~`。

## 备注

脚本通过 AppleScript 调用 iTerm/iTerm2 弹窗选择文件/目录，取消选择时会发送 ZModem 取消信号，避免会话卡住。

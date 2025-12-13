---
abbrlink: 1389132829
categories:
- 往昔
date: "2025-06-21 14:19:36"
tags:
- Linux
title: Tmux配置记录
---
TMux 是终端复用神器，让你在一个终端窗口管理多个会话、窗口和窗格。

基础操作：启动Tmux
```shell
tmux
```

所以我选择在`~/.bashrc`里加上这句，每次打开终端都会自动进入tmux。

**需要掌握的概念**：
- 会话（Session）：长期运行的终端环境。
- 窗口（Window）：会话中的标签页。
- 窗格（Pane）：窗口中的分屏。

**默认快捷键：**

| 操作       | 快捷键          | 说明        |
| -------- | ------------ | --------- |
| **会话管理** |              |           |
| 脱离会话     | `Ctrl+b d`   | 后台运行会话    |
| 查看会话列表   | `Ctrl+b s`   | 方向键选择并进入  |
| 重命名当前会话  | `Ctrl+b $`   |           |
| **窗口管理** |              |           |
| 新建窗口     | `Ctrl+b c`   |           |
| 关闭当前窗口   | `Ctrl+b &`   |           |
| 切换窗口     | `Ctrl+b 0~9` | 切换到指定编号窗口 |
| 窗口列表     | `Ctrl+b w`   | 可视化选择窗口   |
| **窗格管理** |              |           |
| 水平分割窗格   | `Ctrl+b "`   |           |
| 垂直分割窗格   | `Ctrl+b %`   |           |
| 切换窗格     | `Ctrl+b 方向键` |           |
| 关闭当前窗格   | `Ctrl+b x`   |           |
| 最大化/恢复窗格 | `Ctrl+b z`   | 临时全屏当前窗格  |

**配置自定义（~/.tmux.conf）**：
```conf
set-option -g default-shell /bin/bash   # 强制使用 Bash
set-option -g default-command /bin/bash # 确保新会话/Pane 也使用 Bash

unbind H   # 移除 H 的绑定
unbind L   # 移除 L 的绑定
# 启用鼠标支持
set -g mouse on

# 键
set -g prefix C-w
unbind C-b

bind -r Left previous-window     # 前缀键+←：左移窗口
bind -r Right next-window        # 前缀键+→：右移窗口
# 屏幕分割
bind v split-window -h # 前缀键+v垂直分割
bind -n C-Left resize-pane -L 5   # Ctrl+←：向左扩大窗格 5 单位
bind -n C-Right resize-pane -R 5  # Ctrl+→：向右扩大窗格 5 单位
```

```
 ________________
< fuck you tmux! >
 ----------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```










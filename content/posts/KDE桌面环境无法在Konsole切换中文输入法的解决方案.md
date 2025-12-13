---
abbrlink: 3134572074
categories:
- 往昔
date: "2025-03-08 22:07:58"
tags:
- Linux
title: KDE桌面环境无法在Konsole切换中文输入法的解决方案
---

### 原因

KDE默认使用Wayland会话，而fcitx4不支持Wayland，需升级到fcitx5。若无法升级到fcitx5或升级后仍然无法切换中文输入法，**安装fcitx-qt6**

```bash
sudo pacman -S fcitx-qt6
```

安装后执行`sudo reboot now`进行重启，问题解决。

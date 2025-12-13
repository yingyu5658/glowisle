---
abbrlink: 570074617
categories:
- 往昔
date: "2025-04-29 10:31:26"
description: 乱码是由于没有安装字体造成的，安装字体即可
tags:
- Linux
title: WSL Arch Linux ZSH输入中文输入法乱码解决方法
---

没有进行配置的情况下输入中文，一般会显示<0xffffffff>，这是由于没有安装字体造成的。

```bash
sudo pacman -S noto-fonts-cjk  # 安装中文字体
sudo vi /etc/locale.gen        # 取消注释 zh_CN.UTF-8
sudo locale-gen                # 生成语言环境
echo "export LANG=zh_CN.UTF-8" >> ~/.zshrc  # 设置默认中文环境
source ~/.zshrc
```

source后，再次尝试输入中文，无异常。

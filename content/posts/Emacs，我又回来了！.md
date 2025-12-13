---
date: '2025-11-01T12:01:12+08:00'
draft: false
title: 'Emacs，我又回来了！'
slug: 'emacs-i-am-back'
categories:
  - 往昔
tags:
  - Emacs
  - GNU/Linux
---
## 前言

这大概已经是我第四次尝试入门 Emacs 了。

前几次尝试过自己重新配置 Emacs、Spacemacs。自己配置简直是在堆屎山， Spacemacs 的机制搞不明白而且很卡，听说[Doom Emacs](https://github.com/doomemacs/doomemacs) 对 Vi/Vim 用户很友好，那就尝试一下吧！

虽然我不能算是个老 Vimer，但是也深受 Vim 操作模式的荼毒，只想用 HJKL 走天下。之前也想玩 Obsidian 。但是**它的 Vim mode 实在是太简陋了！！！** C-d不是向下翻页，而是把整行都删掉！

不过手机上的 Ob 还是可以一用，比如 Banyan 插件，用来随时随地写一些碎碎念很方便。至于其他的功能，还是配 Emacs 更好玩吧。

## 安装

根据官方仓库的文档，使用以下命令安装：

```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

速度比我想象中的要快得多，而且是交互式操作，感觉比 Spacemacs 友好一点？~~这个脚本的输出有一股 Cargo 味……~~

安装结束后给了一点提示：

```
But before you doom yourself, here are some things you should know:

1. Don't forget to run 'doom sync' and restart Emacs after modifying init.el or
   packages.el in ~/.config/doom. This is never necessary for config.el.

2. If something goes wrong, run `doom doctor` to diagnose common issues with
   your environment, setup, and config.

3. Use 'doom upgrade' to update Doom. Doing it any other way will require
   additional steps (see 'doom help upgrade').

4. Access Doom's documentation from within Emacs via 'SPC h d h' or 'C-h d h'
   (or 'M-x doom/help').

Have fun!
```

其中提到了一个叫**doom**的命令，这是一个在`~/.emacs.d/bin/`下的二进制文件，可以做个链接到`/usr/bin`以便在任何地方使用。

```bash
sudo ln -s ~/.emacs.d/bin/doom /usr/bin/doom
```

## 配置

启动时全屏：

```elisp
(add-hook 'window-setup-hook #'toggle-frame-maximized)
```

安装 [Eaf](https://github.com/emacs-eaf/emacs-application-framework) 插件：

```
git clone --depth=1 -b master https://github.com/emacs-eaf/emacs-application-framework.git ~/.emacs.d/site-lisp/emacs-application-framework/

cd emacs-application-framework
chmod +x ./install-eaf.py
./install-eaf.py
```

用用看吧，后续有什么需求再折腾。

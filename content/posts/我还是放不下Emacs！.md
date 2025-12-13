---
abbrlink: 393175956
categories:
- 往昔
date: "2025-06-03 20:07:15"
tags:
- Emacs
- GNU
- Linux
title: 我还是放不下Emacs！
---
## 前言

难受，真难受呀。作为一个痴迷Vim的人，总是被Emacs的强大勾引，看见别人配的酷炫全能的Emacs就走不动路，脑子里想着“没事没事，我Vim轻量启动极快，Emacs这种重量级是比不上的”，自我安慰。实际上多想玩Emacs只有我自己知道......

我之前也试过[配Emacs](https://www.yingyu5658.me/post/2193909713/)，但是Windows搞出来的不伦不类还很卡的东西太难受，用WSL尝试了一下Spacemacs，搞不明白那个层机制，也对ELisp这个语言不熟悉（说实话到现在Lua的一些东西我都不明白），而且之前的配置也一直想一口吃个大胖子，一天内就配到IDE的强大程度，经过几次失败和Vim配置经验后，我深知这是不可能的，除非在我使用Emacs后N周年的第N周目重新删干净再配，也许能做到。

定个小目标吧，每天配一点点，成果起码要达到以下程度：
- 能胜任前端、Nodejs的开发
- 能胜任CPP/C的开发
- 能使用EAF浏览网页
- 有一点花里胡哨的小功能

其实我也挺想把博客迁移到Emacs，完全用org-mode来写，Hexo越来越慢。其实Hugo也不是不行，就是不太熟悉也不喜欢Go。看了[刘家财大佬的博客](https://liujiacai.net/)后感觉这个也太酷了，主题我也很喜欢，但是评论功能可能有点折腾，我对评论系统也有点不太在意。最难割舍的是现在用的这个主题......

刘家财老师是这样说的
> 只不过遗憾的是，即使写了近 10 年的博客，有价值的评论少之又少，可能中文互联网内没多少人认真写技术评论吧。

这点我确实认同，观察了一些博客的评论，真正讨论技术内容的没几个，大多都是在围观、附和。但是我的博客类型也不能算是纯技术博客，保持与读者的互动还是很有意思的。

言归正传，我现在的Emacs在WSL里，装的是Spacemacs，能正常用eaf，但是写代码很难受，也没有补全，可以说现在它只能当一个浏览器用，我准备推翻重新配。

那么，从现在开始，来配Emacs！！！

![各个编辑器学习曲线图](https://pavinberg.github.io/emacs-book/images/emacs-book/intro/learningCurve.jpg "../../images/emacs-book/intro/learningCurve.jpg")

## 与过去挥手

在`rm -rf ~/.emacs.d`后，那个不伦不类、上不去下不来的Emacs彻底成为了历史。重新输入Emacs，又看到熟悉又陌生的丑陋开屏页。

## 小插曲

WSLg间歇性抽风，打不开GUI
```
Display 10.255.255.254:0 unavailable, simulating -nw
```

打开管理员Powershell，运行`wsl --update`
![[public/images/我还是放不下Emacs！/Pasted image 20250603210050.png]]
~~我草，怎么这么慢？？~~

## MELPA配置

```lisp
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
```

切换中国镜像源
```lisp
(require 'package)
(setq package-archives '(("gnu"  . "http://mirrors.cloud.tencent.com/elpa/gnu/")
             ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))
(package-initialize)
```
重启Emacs，输入`package-list-packages`就可以查看所有插件。`package-install`，回车输入插件名就可以安装对应插件。
默认情况下，插件会被安装到 `~/.emacs.d/elpa/` 目录下。

## use-package

输入`package-install`，输入`use-package`，回车安装，然后在init.el中写
```lisp
(eval-when-compile
 (require 'use-package))
```

## ivy

```lisp
(use-package ivy
 :ensure t
 :init
 (ivy-mode 1)
 (counsel-mode 1)
 :config
 (setq ivy-use-virtual-buffers t)
 (setq search-default-mode #'char-fold-to-regexp)
 (setq ivy-count-format "(%d/%d) ")
 :bind
 (("C-s" . 'swiper)
  ("C-x b" . 'ivy-switch-buffer)
  ("C-c v" . 'ivy-push-view)
  ("C-c s" . 'ivy-switch-view)
  ("C-c V" . 'ivy-pop-view)
  ("C-x C-@" . 'counsel-mark-ring); 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
  ("C-x C-SPC" . 'counsel-mark-ring)
  :map minibuffer-local-map
  ("C-r" . counsel-minibuffer-history)))
```

## amx

```lisp
(use-package amx
 :ensure t
 :init (amx-mode))
```

## ace-window

```
(use-package ace-window
 :ensure t
 :bind (("C-x o" . 'ace-window)))
```

## mwim

```lisp
(use-package mwim
 :ensure t
 :bind
 ("C-a" . mwim-beginning-of-code-or-line)
 ("C-e" . mwim-end-of-code-or-line))
```

## undo-tree

```lisp
(use-package undo-tree
 :ensure t
 :init (global-undo-tree-mode)
 :custom
 (undo-tree-auto-save-history nil))
```

## smart-mode-line

```lisp
(use-package smart-mode-line
 :ensure t
 :init (sml/setup))
```

## good-scroll

```lisp
(use-package good-scroll
 :ensure t
 :if window-system     ; 在图形化界面时才使用这个插件
 :init (good-scroll-mode))
```

今天就先到这里吧。

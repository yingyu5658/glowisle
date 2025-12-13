---
abbrlink: 2193909713
categories:
- 往昔
date: "2025-04-13 12:15:33"
tags:
- Emacs
title: 初折腾Emacs记录
---

## 基础配置

Windows下需要在软件顶部Toolbar的Options中随便更改一个选项，然后再点Save Options，这样就会再`C:\Users\Username\appdata\Roaming\`下生成.emacs和.emacs.d/

在emacs.d中新建一个文件`init.el`，填写如下配置

```lisp
;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

(let ((minver "25.1"))
 (when (version< emacs-version minver)
  (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "26.1")
 (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ; 设定源码加载路径
;; (require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;; Adjust garbage collection thresholds during startup, and thereafter

(let ((normal-gc-cons-threshold (* 20 1024 1024))
   (init-gc-cons-threshold (* 128 1024 1024)))
 (setq gc-cons-threshold init-gc-cons-threshold)
 (add-hook 'emacs-startup-hook
      (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))




;; ==========================================================================================================
;; ===========================================日常使用配置===================================================
;; ==========================================================================================================
(setq confirm-kill-emacs #'yes-or-no-p)   ; 在关闭 Emacs 前询问是否确认关闭，防止误触
(electric-pair-mode t)            ; 自动补全括号
(add-hook 'prog-mode-hook #'show-paren-mode) ; 编程模式下，光标在括号上时高亮另一个括号
(column-number-mode t)            ; 在 Mode line 上显示列号
(global-auto-revert-mode t)         ; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(delete-selection-mode t)          ; 选中文本后输入文本会替换文本（更符合我们习惯了的其它编辑器的逻辑）
(setq inhibit-startup-message t)       ; 关闭启动 Emacs 时的欢迎界面
(setq make-backup-files nil)         ; 关闭文件自动备份
(add-hook 'prog-mode-hook #'hs-minor-mode)  ; 编程模式下，可以折叠代码块
(global-display-line-numbers-mode 1)     ; 在 Window 显示行号
(tool-bar-mode -1)              ; （熟练后可选）关闭 Tool bar
(when (display-graphic-p) (toggle-scroll-bar -1)) ; 图形界面时关闭滚动条

(savehist-mode 1)              ; （可选）打开 Buffer 历史记录保存
(setq display-line-numbers-type 'relative)  ; （可选）显示相对行号
(add-to-list 'default-frame-alist '(width . 90)) ; （可选）设定启动图形界面时的初始 Frame 宽度（字符数）
(add-to-list 'default-frame-alist '(height . 55)) ; （可选）设定启动图形界面时的初始 Frame 高度（字符数）


;; ==========================================================================================================
;; ===========================================插件镜像配置===================================================
;; ==========================================================================================================
; 腾讯镜像
(require 'package)
(setq package-archives '(("gnu"  . "http://mirrors.cloud.tencent.com/elpa/gnu/")
             ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))
(package-initialize)


;;; init.el ends here
```

基础的设置和插件镜像源就配置好了，此配置可完全复制照抄。

重启Emacs，按下`M-x`输入`package-list-packages`即可查看仓库中的所有插件

>  在此列表界面下还可按下h显示帮助，按U检查所有已安装插件是否需要更新，如有就标注更新，按i标记想要安装，最后按下x就可更新。

插件默认会被安装到`~/.emacs.d/elpa`下，Windows同理。

删除插件输入`package-delete`，然后输入想删除的插件名即可。



## use-package

### 安装

输入命令`package-install`回车后输入use-package回车，然后在init.el的最上面写

```lisp
(eval-when-compile
 (require 'use-package))
```

每次启动Emacs优先加载此插件

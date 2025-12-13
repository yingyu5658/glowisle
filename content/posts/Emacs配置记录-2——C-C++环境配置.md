---
abbrlink: 24667834
categories:
- 往昔
date: "2025-06-04 18:58:37"
tags:
- Emacs
- Linux
title: Emacs配置记录 2——C/C++环境配置
---
## 前言

经过[上一篇]()的简单调教，Emacs已经勉强变成了一个温顺的文本编辑器，但是离写代码这个宏大的目标还是有一段距离的，今天来解决主要问题：代码补全。由于我要写一点简单的C代码，那么重点就先放到C/CPP环境搭建中。

站在巨人的肩膀上，在Emacs中的代码补全使用巨硬的LSP协议。

## Spacemacs

经过考虑，我还是决定使用Spacemacs，比起原版Emacs，它更适合新手，也更能快速投入开发。避免配置陷阱，过多把时间花在刀把上。唉，也就是说，昨天大部分都白干了。算了，生命的意义就在于折腾，怕折腾我也不会玩Emacs了。来吧！

先来安装一下Spacemacs。
`git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`

重启Emacs，让他下载一下自带的包。

上次没清理干净Spacemacs，不知道存在哪的备份还在，算是免去了一些折腾吧。来看看现在的Emacs都配置了什么。
```lisp
   dotspacemacs-configuration-layers
   '(yaml
     markdown
     javascript
     (auto-completion :variables
                      auto-completion-idle-delay 0.01    ; 降低补全延迟
                      auto-completion-minimum-prefix-length 1)
     (prettier :variables
               prettier-always-enable t)  ; 保存时自动格式化
     (javascript :variables
                 javascript-backend 'lsp        ; 启用LSP后端
                 javascript-fmt-tool 'prettier) ; 格式化工具选Prettier
     (c-c++ :variables
            c-c++-backend 'lsp-clangd)         ; C/C++使用Clangd后端
     (vue :variables
          vue-backend 'lsp)                    ; Vue使用LSP后端
     (html)                                    ; HTML/CSS支持
     (lsp)                                     ; 必须的LSP核心支持层
     (auto-completion)                         ; 自动补全
     (syntax-checking)                         ; 语法检查
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     treemacs
     ;; git
     helm
     lsp
     ;; markdown
     multiple-cursors
     ;; org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     treemacs)
```
emmm，还是有点有用的。比如C/C++这里，就启用了LSP。还有一些之前搞的前端配置。就是不知道为啥，JavaScript的补全不太好使。

## 语法检查

语法检查，选择当前比较成熟的flycheck，在Spacemacs中对应`syntax-checking`，在.spacemacs中的`dotspacemacs-configuration-layers`写入`(configuration-layer/declare-layer 'syntax-checking)`
 该层会自动集成Flycheck及其常见语言的后端支持。

C/C++要安装`clang-tidy`或`cppcheck`。

### 进阶配置

```lisp
  (with-eval-after-load 'flycheck
    (setq flycheck-check-syntax-automatically '(save mode-enabled) ;; 保存时检查
          flycheck-display-errors-delay 0.5                        ;; 错误显示延迟
          flycheck-indication-mode 'right-fringe))                 ;; 错误标记位置
```


## [.spacemacs 文件基本介绍](https://liuzhijun-source.github.io/spacemacs-14-days/#/Week01/Day05/day05_spacemacs%E7%9A%84%E8%BF%9B%E9%98%B6%E9%85%8D%E7%BD%AE_%E4%B8%8A?id=spacemacs-%e6%96%87%e4%bb%b6%e5%9f%ba%e6%9c%ac%e4%bb%8b%e7%bb%8d)

.spacemacs 文件一般会自动生成在主目录下，这个文件是配置 Spacemacs 的入口，有关于 Spacemacs 本身的配置基本都能在里面进行修改，用户设置同样在这个文件中修改。

.spacemacs 中，内容一般被分为以下几个部分，每个部分都封装在一个函数中：

- `dotspacemacs/layers`

在这里可以声明一些 layer，以及删除、增添一些包，在这里还可以调整 Spacemacs 加载时的一些行为

- `dotspacemacs/init`

Spacemacs 绝大部分的配置都位于此，你可以在此修改配置中可选的选项，但绝对不能将自己的用户配置代码添加在这里

- `dotspacemacs/user-init`

这里的内容会在 Emacs 启动前开始加载，一般在这里设置你需要使用的 elpa 源，你应该尽量把用户配置放在 `dotspacemacs/user-config` 中

- `dotspacemacs/user-config`

在这里可以添加你的用户配置代码，你自己的定义的大部分配置一般都在这里完成

- `dotspacemacs/emacs-custom-settings`

Spacemacs 自己生成的配置，同样不建议自己去修改

> 摘自[Spacemaccs 14 Days](https://liuzhijun-source.github.io/spacemacs-14-days/#/Week01/Day05/day05_spacemacs%E7%9A%84%E8%BF%9B%E9%98%B6%E9%85%8D%E7%BD%AE_%E4%B8%8A)

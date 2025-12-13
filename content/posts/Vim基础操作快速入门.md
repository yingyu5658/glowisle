---
abbrlink: 2074174141
author: yingyu5658
categories:
- 往昔
cid: 147
cover: ../../images/2024/12/4041053621.jpg
customSummary: null
date: "2024-12-13 16:13:36"
layout: post
mathjax: auto
noThumbInfoEmoji: null
noThumbInfoStyle: default
outdatedNotice: "no"
parseWay: auto
reprint: standard
slug: 147
status: publish
tags:
- Vim
thumb: null
thumbChoice: default
thumbDesc: null
thumbSmall: null
thumbStyle: default
title: Vim基础操作快速入门
updated: 2024/12/13 16:15:07
---

# 前言

各种鼠标操作让我有点抓狂，vim或许是一个很适合我的东西，全键盘操作听起来就很方便快捷，除了上手难度有点高以外，vim看起来似乎没有任何的缺点。在下载安装好了vim后，我开始学习了快捷键。~~然后我们就可以直接把鼠标扔了。~~


**记住要先把输入法切换成英文模式**

# 普通模式

## 退出

很多人第一次用vim，最难受的事情绝对是不知道怎么退出。
退出：`:q!`

## 移动光标

`h` `j` `k` `l` 这四个按键分别对应左 下 上 右

> 这个比较难适应，不过也比把手移动到右下方用箭头键舒服了

### 大范围移动

行数 + `h`/ `j`/ `k`/ `l`
比如，想要向下移动三行，就是3`j`，向左移动四格，就是3`h`
`gg` 跳转到文档的最上方
`G` 跳转到文档的最下方

### 按照单词跳转

`w`，也就是“word”的首字母。就可以跳转到下一个单词的开头。
`b` beginning就跳转到前一个单词的开头
`f` find 查找单词。比如要把光标移动到离你最近的b，就可以输入`fb`

### 翻页

`Ctrl + u`向上翻页。u理解为up首字母。
`Ctrl + d`向下翻页。d理解为down首字母。

## 复制粘贴

在普通模式下，输入`y` （yank），复制整个单词：`yaw` “aw'“为~~阿伟~~ all word
`p` 即paste，粘贴。

## 删除

普通模式下，`d` 也就是delete，直接删除当前行和下一行的内容
还可以跟上文的`hjkl`结合起来，比如d8j就是向下删除八行

## 撤销

`u` 也就是undo。

> 这些快捷键很灵活，都可以互相结合使用

# 输入模式

## 进入输入模式

在普通模式下，输入`i` 也就是insert，就可以进入输入模式了。

1. `i`是在当前光标的前一个字母开始输入。
2. 使用`a`也就是append，就可以在当前光标之后输入。
3. 使用`I`就会从这一行的开头进入输入模式。
4. 使用`A`就会从这一行的末尾进入输入模式。
   完成编辑后，使用`ESC` 就可以退出编辑模式，回到普通模式了。

# 命令模式

在普通模式下输入`：`就可以进入命令模式，按下`ESC`就会退出命令模式。
在下方的命令行中，可以输入命令
`q`也就是quit就可以退出
保存`w`
保存并退出`wq`

# 可视模式

普通模式下按下`v`就可以进入可视模式。

# 配置文件

vim中修改键位，安装主题全都是用一个配置文件来完成的。
原版vim的配置文件叫做.vimrc
关于修改键位，我的看法是不要改，因为你适应之后上服务器就会很难受，什么都不适应。

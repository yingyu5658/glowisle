---
abbrlink: 2218331126
categories:
- 往昔
date: "2025-03-09 12:41:10"
tags:
- Linux
title: Kitty终端美化记录
---

Kitty这个终端可谓是兼顾了性能与美观，虽然默认设置很简陋，但是经过一番折腾后也能变得很漂亮。

## 选择配色

运行`kitty + kitten themes`后会弹出一个选择配色的界面
![](https://images.glowisle.me/Pasted%20image%2020250309124346.webp)
令我感到非常高兴的是，这个界面支持vim的hjkl键位，也可以用/来搜索。
选好后，回车按m，command + ^ + ,重载配置文件。

## 配置字体

打开kitty的配置文件`nvim ~/.config/kitty/kitty.conf`，把字号改到12
`font_size 12`
输入`kitty list-fonts --psnames`来列出系统安装好的所有等宽字体。

## 设置窗口风格

进入配置文件

```
#window
# 不显示窗口标题栏 保留窗口圆角
hide_window_decorations titlebar-only
# 边距
window_padding_width 5
# 不透明度
background_opacity   0.8
# 毛玻璃效果
background_blur      30
```

## 设置标签栏风格

```
#tab bar
tab_bar_edge          top
tab_bar_style         powerline
tab_powerline_style   slanted
```

## 安装终端文件管理器

`yay -S yazi`
推荐yazi的原因，就是能用vim快捷键啊！hjkl好文明！
而且它还能直接在终端预览图片
![](https://images.glowisle.me/Pasted%20image%2020250309131507.webp)

## 最终效果预览

![](https://images.glowisle.me/Pasted%20image%2020250309131145.webp)

![](https://images.glowisle.me/Pasted%20image%2020250309131221.webp)

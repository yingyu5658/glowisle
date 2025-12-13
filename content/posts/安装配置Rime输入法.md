---
abbrlink: 2682509886
categories:
- 往昔
date: "2025-03-24 20:37:38"
tags:
- Linux
title: 安装配置Rime输入法
---
# 前言
其实我有能用的fcitx5+搜狗输入法的方案，但奈何kitty终端有对这个输入法的兼容性问题，无法启用中文，又奈何kitty的界面多美观舒服，和Konsole比起来简直就不是一个时代的产物。

# 安装Ibus框架和Rime输入法引擎
**安装 IBus 和 Rime 组件**：
`sudo pacman -S ibus ibus-rime`

**安装 Rime 双拼方案：**
`sudo pacman -S rime-double-pinyin`

## 配置 IBus 和 Rime

**设置环境变量**
在`~/.xprofile`添加以下内容 
```bash
export GTK_IM_MODULE=ibus export QT_IM_MODULE=ibus export XMODIFIERS=@im=ibus
```
重启系统或执行 `source ~/.xprofile` 使配置生效

**启动 IBus 并添加 Rime 输入源**
```bash
ibus-daemon -drx
```
右键点击系统托盘中的 IBus 图标，选择 **Preferences** → **Input Method** → **Add**，选择 **Chinese (Rime)**。

**配置双拼方案**
编辑 Rime 的配置文件 `~/.config/ibus/rime/default.custom.yaml`：
```bash
patch:
schema_list:
	- schema: double_pinyin # 自然码双拼
	- schema: luna_pinyin # 全拼备用
```

## 优化 Rime 的智能联想与词库
**启用雾凇拼音方案（推荐）**
```bash
cd ~/.config/ibus/rime
git clone https://github.com/iDvel/rime-ice.git
cp -r rime-ice/* .
```

## 安装小鹤双拼方案
```bash
# 安装 plum 工具
curl -fsSL https://git.io/rime-install | bash -s -- double-pinyin flypy
```




---
CopyRight: true
NoCover: false
ShowReward: false
ShowToc: show
abbrlink: 1177643335
author: yingyu5658
categories:
- 往昔
cid: 184
cover: images/1203260069.jpg
date: "2025-01-08 17:26:00"
desc: null
keywords: null
layout: post
showTimeWarning: true
slug: 184
status: publish
summaryContent: null
tags:
- Java
- 服务器
- Minecraft
- Geyser
thumb: null
title: 修复Geyser下基岩版玩家无法在地狱基岩层放置方块
updated: 2025/01/08 17:26:41
---


在`plugins\Geyser-Spigot\config.yml`中把第160行的`above-bedrock-nether-building: false`改为`true`，重启服务器，问题解决~
原理：geyser把下界翻译成了末地，会导致下界天空变成末地的样式，不过可以解决基岩版玩家在地狱基岩层的问题。

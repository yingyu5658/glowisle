---
CopyRight: true
NoCover: true
ShowReward: false
ShowToc: show
abbrlink: 4161445720
author: yingyu5658
categories:
- 往昔
cid: 181
cover: images\2024\12\2743265221.jpg
date: "2025-01-04 08:35:00"
desc: null
keywords: null
layout: post
showTimeWarning: true
slug: 181
status: publish
summaryContent: null
tags:
- Java
- 服务器
- Minecraft
thumb: null
title: Spigot服务端控制台中文乱码解决方案
updated: 2025/01/04 08:35:54
---
1. 把``-Dfile.encoding=UTF-8``加在开服脚本文件的``-jar``前即可。
2. 在启动脚本第一行加上`chcp 65001`
我的启动脚本如下：
```bash
chcp 65001
java -Dfile.encoding=UTF-8 -jar spigot-1.21.jar
```

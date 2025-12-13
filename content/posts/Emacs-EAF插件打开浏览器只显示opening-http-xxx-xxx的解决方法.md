---
abbrlink: 717508352
categories:
- 往昔
date: "2025-04-29 10:02:49"
tags:
- Emacs
- Linux
title: Emacs EAF插件打开浏览器只显示opening http://xxx.xxx的解决方法
---
检查是否安装全部依赖，如yay、pip等。我这里是由于没有安装pip导致的。

`sudo pacman -S python-pip`

安装好后，进入eaf安装目录

`cd ~/.emacs.d/site-lisp/emacs-application-framework && ./install-eaf.py`

重新安装eaf。等待脚本运行完成，打开emacs，输入`M-x eaf-install-and-update`，等待执行完成。

重新输入`M-x eaf-open-browser`，输入网址，即可正常访问网页。

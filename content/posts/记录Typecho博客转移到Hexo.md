---
abbrlink: 64728457
categories:
- 往昔
cid: 4
date: "2025-03-03T15:40:00+08:00"
layout: post
slug: 4
status: publish
tags:
- 博客
title: 记录Typecho博客转移到Hexo
---


# 前言
折腾来折腾去，最后发现归宿还是静态博客，安全性高、性能开销小，用Github直接省去服务器费用还差不多永生。每年把域名钱交了就得了，图片的问题再想想办法，总能解决的。
~~突然有一种为了躲避战乱带着一家人四处奔波的悲凉感~~

# 分析
博客网站的内容，都可以拆分为以下几个点：
- 文章
- 评论
- 文章插图
- 网站贴图资源

先从最主要的文章开始，想想有没有什么可以用的。
gitee上有一个[插件](https://gitcode.com/gh_mirrors/ty/Typecho-Plugin-Tp2MD)，看起来好像有点用，折腾安装一下试试先。
# Tp2MD插件迁移文章
 远程登录服务器，把本地下号的zip传到服务器上并解压。
 cd到插件目录
 `/usr/share/nginx/html/usr/plugins`

 解压压缩包
 `unzip Typecho-Plugin-Tp2MD-master.zip`

 重命名为插件的自述文件要求的名称
 `mv Typecho-Plugin-Tp2MD-master Tp2MD`

登录网站后台，启用插件。点击插件的设置，保存后按照教程访问。
这里提示`不能写入文件，请检查 cache 文件夹权限！`，我们在插件目录设置一下权限
 `sudo chmod -R 777 cache`a
注意是这个插件目录下的cache！！

提示导出成功，cd到这个目录，把文件压缩下载下来查看
可能是因为我有的文章点了多篇分类，导出文件夹有点问题，无所谓，后期再调，拿到了就行。至此，文章部分搞定！

# 评论

评论这里，我折腾了两天，尝试尽了各种方案（Disqus Valine Waline Utterances Twikoo Atalk），最后还是选择了Giscus。我也知道这样读者没有github就没办法发评论，但是其他几种方案都会出现各种奇奇怪怪且无法解决的问题比如Cloudflare拦截、CORS出毛病、服务器被墙以及莫名其妙404、403。我真的尽力了。
# 文章插图
## 转移图片文件
进入`/usr/uploads/`，压缩下载图片

重组Hexo图片目录：复制所有图片到Hexo的`source/images/`目录。

手动替换图片路径 ，注意，静态资源解析默认以source为根目录，所以直接写以source为根目录的绝对路径就行。

# 部署到vercel加速访问
1. 注册vercel账号
2. 创建项目，关联仓库
3. 域名解析

2025.3.3，博客全部迁移完毕，粗略累计用时六天，一直没什么时间搞，耗时最长的还是在评论系统上的试错。

---
abbrlink: 3093271062
author: yingyu5658
categories:
  - 往昔
cid: 130
customSummary:
date: 2024-12-07 23:40:00
layout: post
mathjax: auto
noThumbInfoEmoji:
noThumbInfoStyle: default
outdatedNotice: true
parseWay: auto
reprint: standard
slug: 130
status: publish
tags:
  - Hexo
  - 博客
thumb:
thumbChoice: default
thumbDesc:
thumbSmall:
thumbStyle: default
title: 记录Hexo搭建博客
updated: 2024/12/07 23:45:33
draft: true
---


# 前言

我今天在写网页的时候突然发现我居然忘了一些标签的使用格式，只好打开搜索引擎一顿复习。我正在寻找一种更高效的复习方式。

我现在的网站风格发布大量的技术文章有点突兀。

于是，搭建一个专门用于整理技术的网站的想法浮现在我的脑海中。

思想挣扎了一段时间，我考虑了一下他的意义：

1.如果我再搭建一个网站，那我现在这个站点还有什么意义？

   如果不新建一个站点，那就只能把网站整个改版，换主题、改名到适合的风格，浪费时间。

  2.新建站点有什么实现方法？

# 实现方法

我一下子想到了几种方法。

1. 再购买服务器和域名，还是使用typecho或者WordPress搭建一个网站。
2. 更换typecho主题
3. 把hexo部署到Github Page上。
4. 使用Gemeek
5. 自己编写静态站

先说结果，由于第一种方法的资金成本和时间成本过高了，直接pass不用考虑。

方法二，现在使用的handsome主题还是深得我心的，自定义程度可以很高，而且花了老夫八十八大洋，不用也亏了。再者typecho的主题，我喜欢的并不多

方法四是我曾经尝试过的，但因为页面有点单调，所以换到了typecho。

但是我这次的需求仅仅是整理知识点，太花哨也会搭建速度和复习效率的。所以hexo大概也要pass掉。

方法五，不太现实，我的前端知识远没有那么牢固，我自己也写过几个网页，pc端很完美，可到了手机端排版很丑，还是要在学习沉淀一段时间啊。

最后剩下来的方案有：

3. 把hexo部署到Github Page上

4. 使用Gmeek

   

gmeek原版的布局我不是很喜欢，但这个方案是零成本很快捷的。可以尝试自己修改css文件来达到想要的效果。

虽然我自己写网页效果一般般，但是增删改查还行，于是我开始尝试：



我有两个github账号，一个是本站下方挂的大号，另一个是昨天晚上刚创建的小号。

大号的page我部署了一个我自己写的个人主页，但是现在来看并没有什么用处，所以我把那个仓库删除了。

重新创建了一个仓库，部署好了gmeek，我把里面所有的文件都下载了下来。、

看到了几百行压根没有注释的代码，头瞬间炸了，于是修改gmeek的方案也pass

。。。。。

好吧，看来只能用hexo了

# 搭建记录


## 部署hexo
1. 安装git和nodejs

   git我已经安装好了

去nodejs官网（[Node.js — Run JavaScript Everywhere](https://nodejs.org/en/)）安装了一下。

这两样都准备好了就可以开始安装hexo了

```shell
npm install -g hexo-cli
```

然后在控制台输入

```shell
hexo init myBlog
cd myBlog
npm install
```

然后我们就可以运行```hexo s```命令，访问控制台中的网站就可以预览了



可以看到hexo的默认模板还是很简约大气的。

  

部署好后，我打算换一个主题，因为这不是主站，所以也就没必要那么花哨（有一说一hexo那么多主题还真有几个让老夫心动的）



## 更换主题

把主题文件夹复制到安装目录下的/themes文件夹内

复制好文件名，打开_config.yml

找到第一百行，把文件名替换

修改好后在gitbash中执行```hexo g``` ```hexo s```

## 部署github

- 新建名为```你的用户名.github.io```的新仓库

- 配置SSH key，用git工具首先配置，为部署本地博客到github'做准备

  ```shell
  git config --global user.name "你的用户名"
  git config --global user.email "邮箱地址"
  ssh-key - t rsa -c '上面填写的邮箱地址'
  ```

  **一定要手敲！**

  **一定要手敲！！**

  **一定要手敲！！！**

  输入这行指令可以查看你的SSH

  ```cat ~/.ssh/id_rsa.pub```

  首次使用要确认并添加主机到本机SSH可信列表，若返回啥啥啥successfully什么就代表添加成功了

  输入以下代码

  ```ssh -T git@github.com```

  如果出现```ssh: connect to host github.com port 22: Connection refused``` 把你的加速器关了。

- 登录github上添加刚刚生成的SSH key

  步骤：右上角头像>settings>SSH and GPG keys>New一个SSH出来，标题随便写，key把刚刚生成的复制过来，建立。这样在SSH keys列表中就能看到刚刚添加的秘钥。


本地和github的活基本上干完了，该把他俩链接起来了

## 链接本地与github

1. 打开博客根目录下的_config.yml

2. 拉到末尾。按照下面的例子修改

   ```yaml
   deploy:
     type: git
     repo: https://github.com/yingyu5658/yingyu5658.github.io.git
     branch: master
   ```

3. 还要安装一个部署插件 hexo-deployer-git

   打开git bash 输入以下指令

   ``` npm install hexo-deployer-git --save```

4. 最后执行下面两条指令就可以部署上传了如下g是generate的缩写，d是deploy的缩写

   ```shell
   hexo d
   hexo g
   ```


经历了千辛万苦，终于折腾完了，下一步就是写文章并发布了！！！

## 撰写并发布文章

```hexo new '文章标题'```

他会在\source\_posts创建一个markdown文件（.md）

打开目录写完后保存，然后打开gitbash

```hexo g```

```hexo s```

# 后记

还是typecho舒服，用hexo写篇文章发篇文章那个费劲呀，前前后后敲了几百万行命令，效率太低了。。。。而且部署在github pages上的页面如果不挂url链接，那个图片压根就加载不出来。。。要不是这玩意不花钱我才不用。。。。。。。

> 2025.8.24二编: 静态真好用......

---
date: '2025-12-05T17:22:22+08:00'
draft: false
title: '一次对Webmention的探索'
slug: 'exploring-webmention'
categories:
  - 技术
tags:
  - Webmention
  - 去中心化
  - 博客
---
> Webmention is a simple way to notify any URL when you link to it from your site.
>
> It is an open web standard (W3C Recommendation) for conversations and interactions across the web, a powerful building block used for a growing distributed network of peer-to-peer comments, likes, reposts, and other responses across the web.

Webmention 是一种开放网络标准（W3C推荐标准），用于在链接到某个网址时，自动向该网址发送通知。它是构成分布式网络的基础组件，支持跨网站的点对点评论、点赞、转发等多种互动。

在 [上一篇文章](https://www.glowisle.me/posts/tear-hypocrisy-apart/) 写完后，我开始寻找更合适的评论方案。Webmention这个看起来古老，但又超前的形式很快引起了我的兴趣。「去中心化」这个词貌似对我有什么魔力，就比如Mastodon，比Twitter更吸引我。

我很想试试用Go手搓一套收发系统，但时间并不充裕，正巧[webmention.io](https://webmention.io)提供现成的服务和[详细的文档](https://indielogin.com/setup)，那就跟着文档配置吧。

## 验证与接收

教程提供了多种验证方案，这里使用最简便的Github. 只要在网站的首页挂上一个链接，指向用户档案页：

```html
<a href="https://github.com/example" rel="me">github.com/example</a>
```

如果不想让它可见，也可以设置为一个`<link>：

```html
<link href="https://github.com/example" rel="me">
```

![作为验证，你需要在Github主页中包含你的网站](https://images.glowisle.me/2025-12-05_18-26.png)

这里我部署后回退了一下网页就弹出来Github APP 认证请求了，大概需要刷新网页或打开Github？

这样，访问之后页面中提供的链接，就可以看到别人发送的Webmention了。

## 渲染

在网页中添加link

```html
<link rel="webmention" href="https://webmention.io/你的用户名/webmention" />
```

我使用[webmention.js](https://github.com/PlaidWeb/webmention.js)，根据说明文档，可以复制仓库中的`/static/webmention.min.js`到博客的`/static/js/webmention.min.js`.

在评论框下方提供一个容器`<div id="webmentions"></div>`，并引用脚本

```html
<div id="webmentions"></div>
<script src="/js/webmention.min.js"
    data-id="webmentions" // 与容器id匹配
    data-page-url="https://yourdomain.com/当前文章永久链接" // 建议使用
    data-max-webmentions="50" // 最多显示数量
    data-wordcount="30" // 回复预览最大字数
    data-sort-by="published" // 按照发布时间排序
    data-sort-dir="up" // 时间升序
    async>
</script>
```

Hugo用户在永久链接上可以使用：

```html
data-page-url="https://yourdomain.com{{ .RelPermalink  }}"
```

为了本地测试，使用相对链接的变量拼接。脚本会对API发送请求，如果拿到的数据是空的，则会把最终的HTML输出为一个空字符串，所以刚开始看不到输出是正常的。大概写点CSS就可以正常投入使用了。

## 对Webmention的看法

我认为Webmention是一种很像友情链接的互惠模式，优于在评论区下方留下链接的形式。续上上一篇文章的话题，这样不仅促成高质量的互动，也能丰富自己的写作素材，分量应该重于评论区链接的手段。就像上一篇文章的结尾所说，利人利己，何乐而不为呢？

虽然这种模式的普及程度不高，但我相信去中心化会称为互联网的新趋势。开放、互联才能称为「互联网」。

我通过一些Webmention，一条一条顺藤摸瓜也找到了很多有趣的博客。我准备有时间优化渲染格式，可能也会研究一点桥接的功能，不过还是要保持博客一贯的简洁风格。当然，要先有人回应才有数据拿来渲染，欢迎大家使用Webmention参与互动！

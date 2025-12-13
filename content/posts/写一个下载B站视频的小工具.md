---
date: '2025-11-08T12:20:36+08:00'
draft: true
title: '写一个下载B站视频的小工具'
slug: 'download-bilibili-video-with-golang'
categories:
  - 往昔
tags:
  - Golang
---
## 前置条件

Bilibili的视频接口链接是这样的

```
https://api.bilibili.com/x/player/playurl?fnval=80&cid=746904707&bvid=BV1pT41157it
```

- avid可以用bvid，也就是视频的BV号代替
- cid的值可以通过aid获取，它是每个视频的分p编号，同个av号视频里的每p视频都有不同cid值[^1]

json数据中，`baseUrl`就是视频下载链接，根据清晰度的不同，有多条下载链接。

### 构造请求

#### 获得 cid

```
https://api.bilibili.com/x/player/pagelist?bvid=填写视频的BV号
```

使用这个接口也是可以得到cid的

```
https://api.bilibili.com/x/web-interface/view?bvid=
```


一个标准的B站视频网页PC端链接是这样的：

```
https://www.bilibili.com/video/BV1YUs5zVE2w/
```

最后以BV开头的字符就是BV号。我们可以得到以下链接：

```
https://api.bilibili.com/x/player/pagelist?bvid=BV1YUs5zVE2w
```

对这个url发送请求，可以得到以下内容
```json
{
  "code": 0,
  "message": "0",
  "ttl": 1,
  "data": [
    {
      "cid": 33335151537, // 我们需要的cid
      "page": 1,
      "from": "vupload",
      "part": "防波堤にいた白猫をナデナデしたらコロコロ転がって落ちた",
      "duration": 172,
      "vid": "",
      "weblink": "",
      "dimension": { "width": 1920, "height": 1080, "rotate": 0 },
      "first_frame": "http://i2.hdslb.com/bfs/storyff/_000003dxlmk3m5bg52v8f5zbx7p5hyb_firsti.jpg",
      "ctime": 1761233073
    }
  ]
}

```

#### 构造下载链接

这个结构有cid和bvid两个参数：

```
https://api.bilibili.com/x/player/playurl?fnval=80&cid=&bvid=
```

根据上面的结果，我们可以构造以下url:
```
    https://api.bilibili.com/x/player/playurl?fnval=80&cid=33335151537&bvid=BV1YUs5zVE2w
```

这个url返回的数据中，baseUrl即为下载链接。

## 写代码

我们需要做的事有：

- 发送网络请求
- json 解析
- 文件IO
- 日志输出

### 网络请求

在go语言中，发送http请求的最简单方法就是使用`net/http`


[^1]: https://zhuanlan.zhihu.com/p/541308878

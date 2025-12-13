---
CopyRight: true
NoCover: true
ShowReward: false
ShowToc: show
abbrlink: 1636322595
author: yingyu5658
categories:
- 往昔
cid: 163
date: "2024-12-17 11:46:07"
desc: null
keywords: null
layout: post
showTimeWarning: true
slug: 163
status: publish
summaryContent: null
tags:
- 服务器
thumb: null
title: 记录配置SSL证书
updated: 2024/12/17 11:46:07
---
首先你要有一个SSL证书，建议在阿里云购买或者[免费申请](https://developer.aliyun.com/article/1595201)，具体过程阿里云这个页面讲的很详细，在此不过多赘述。
# 配置证书
由于我的nginx安装了ssl模块，直接进入配置证书。

解压下载好的证书，然后上传到服务器。位置自己方便找到即可
我放到了root/card

# 配置nginx.conf
进入nginx.conf，我的文件位置在``/etc/nginx/nginx.conf``,有些可能在``/usr/local/nginx/conf``
编辑模式，启动！
```

  

http {

    include       mime.types;  # 包含 MIME 类型定义

    default_type  application/octet-stream;

    sendfile        on;

    keepalive_timeout  65;

  

    # HTTPS server block

    server {

        # 监听443端口（HTTPS）

        listen 443 ssl;

  

        # 【请修改】您的域名

        server_name xxx;

  

        # 启用 SSL (注意: "ssl on;" 已被弃用，直接使用 "listen ... ssl;")

        ssl on;

  

        # 【请修改】SSL 证书的 PEM 文件路径

        ssl_certificate  /root/card/www.xxxx.pem;

  

        # 【请修改】SSL 证书的 KEY 文件路径

        ssl_certificate_key /root/card/www.xxxx.key;

  

        location / {

            # 【请修改】代理转发的目标地址和端口（例如公网IP和项目端口号）

            proxy_pass  http://公网地址:项目端口号;

        }

    }

  

    # HTTP server block for redirecting to HTTPS

    server {

        # 监听80端口（HTTP）

        listen 80;

  

        # 【请修改】您的域名

        server_name huiblog.top;

  

        # 将所有 HTTP 请求永久重定向到 HTTPS

        rewrite ^(.*)$ https://$host$1 permanent;

    }

}

```
# 重新加载Nginx
``sudo systemctl reload nginx``

---
title: '2026年，一个普通Emacs用户如何把Gnus跑起来'
date: '2026-02-10T18:34:00+08:00'
slug: 'gnus-guide'
categories: 
- 技术
tags:
- GNU/Linux
- Emacs
- Gnus
draft: false 
comments: true
---

## 前言

Emacs中有众多的邮件管理工具，目前比较流行的是[mu4e](https://github.com/emacsmirror/mu4e)，但如果你和我一样，不喜欢它的操作逻辑和界面，或者同样有怀旧情怀，一定会想玩玩Gnus。然而这个在Emacs中自带的包，居然在中文互联网上几乎没有任何讨论度，甚至能用中文搜索到的配置教程是写于2012年的博客园文章。几乎找不到近些年的帖子或文章。所以我写下这篇文章，为同样想折腾Gnus的，使用中文的Emacser指路。

本篇文章不是《Emacs完全上手指南/圣经/官方文档》，不能做到全面、无误，但可以保证是中文互联网上较新的资料，如有错误，欢迎邮件或在评论区指出。

Gnus是一个多功能的信息聚合器，邮件只是它的功能之一，本篇文章主要配置邮件功能。

## Getting started

Gnus的配置文件默认在`~/.gnus`，Emacs会将它当作elisp文件读取，网上也有一些说法是`~/.gnus.el`其实只是加载顺序的不同，如果你此前有尝试，请备份并删除以前的文件。

```
touch ~/.gnus
```

## gnus-select-method

Gnus的后端选择，对于imap协议，一般选择`nnimap`：

```elisp
(setq gnus-select-method
      '(nnimap "NAME" ;这里是自己起的名字，用来区分不同的帐号
               (nnimap-address "") ; imap服务器
               (nnimap-inbox "INBOX") ; 大多数服务器都使用INBOX，除非你明确知道不同，否则不建议修改
               (nnimap-expunge t) ; 立即在服务器上同步删除的邮件（按需开启，开启后删除邮件无法恢复）
               (nnimap-server-port 993)
               (nnimap-stream ssl)  ; 使用 SSL
               (nnimap-authenticator login)  ;指定认证方式，如果服务器支持多种认证方式但自动协商失败，建议开启
               ))

```

在配好后，重启Emacs，输入`M-x RET gnus RET`，下方会闪过一些输出，根据提示填写用户名和密码后，询问是否要把用户名和密码填入`~/.authinfo`，建议选y。

`C-x b`切换到`*Messages*`buffer查看，会看到类似这样的输出，那就表明你的配置无误！

```
Opening connection to imap.qiye.aliyun.com via tls...
Opening connection to imap.qiye.aliyun.com...done
Saving file /home/yingyu5658/.newsrc-dribble...
Wrote /home/yingyu5658/.newsrc-dribble
Gnus auto-save file exists.  Do you want to read it? (y or n) n
Reading /home/yingyu5658/.newsrc...done
Subscribe newsgroup: 已删除邮件
Subscribe newsgroup: 草稿
Subscribe newsgroup: INBOX
Subscribe newsgroup: 已发送
Subscribe newsgroup: 垃圾邮件
Opening nnfolder server on archive...done
5 new newsgroups have arrived
Checking new news...
nnimap read 0k from imap.qiye.aliyun.com (initial sync of 5 groups; please wait)
Checking new news...done
No news is good news
```

这个news是历史遗留词汇，最后一行输出仅仅代表当前没有未读邮件。

你可以用另一个账号向这个邮箱发送一封测试邮件，重新打开Gnus，会有这样的输出：

```
1:*INBOX
```

我们回车点进去，就会打开那封邮件显示内容啦。

![测试邮件效果](https://images.glowisle.me/2026-02-10_19-50.png)

在Group Buffer中按下`L`，可以看到所有文件夹。

## 多帐号配置

多账号配置需要设置`gnus-secondary-select-methods`这个变量，这里和`gnus-select-method`一起说一下。后者是主服务器，前者是额外服务器列表，但几乎和主服务器同级，使用中可以当作平级。

多账号配置示例：

```elisp
(setq gnus-select-method
      '(nnimap "glowsisle"
               (nnimap-address "imap.qiye.aliyun.com")
               (nnimap-inbox "INBOX")
               (nnimap-expunge t)
               (nnimap-server-port 993)
               (nnimap-stream ssl)  ; 使用 SSL
               (nnimap-authenticator login)  ; 必须指定认证方式
               ))

(setq gnus-secondary-select-methods
      '((nnimap "outlook"
		(nnimap-address "outlook.office365.com")
		(nnimap-server-port 993)
		(nnimap-stream ssl)))
		
	; 如果你有更多账户，另一个账户的配置同上。
	)
```

注意到了吗，`secondary`的配置和我们一开始配置的`gnus-select-method`一模一样，而且它可以容纳多个账户。

注意：Microsoft Outlook / Microsoft 365 默认禁用普通 IMAP 密码登录。Gnus 无法使用 OAuth2，因此必须在 Microsoft 帐号中启用双重验证并生成应用专用密码，否则会出现 NO LOGIN failed 错误。

## 发邮件

虽然对于一个Gnus教程来说有点跑题，但你应该会需要发件配置的。

在Emacs中发送邮件有三条路，分别是`msmtp`、`smtpmail`（Emacs内置）、sendmail。

最推荐的是msmtp，与Gnus、Emacs解耦，并且配置简单优雅。

### 安装

以Debian为例：

```
sudo apt update
sudo apt install msmtp
```

在配置文件中

```elisp
(setq send-mail-function 'sendmail-send-it)
(setq message-send-mail-function 'sendmail-send-it)
(setq sendmail-program "/usr/bin/msmtp")
```

在`~/.msmtprc`：

```
account 账户名
host smtp.server.address
from your@account.com
auth login
port yourport
user your@account.com
password 不建议明文写密码，配置方式见下文
auth on
tls on
tls_starttls off
tls_certcheck  off 
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default : 默认账户，填写account的值
```

## 密码存储

需要创建一个包含密码的文本文件。

```bash
touch password && echo "yourpassword" > ./password
```

然后使用GPG加密，这样会生成一个`password.gpg`文件

```
gpg --symmetric --cipher-algo AES256 password
```

然后在`~/.msmtprc`中，把密码那行改成

```
passwordeval "gpg --quiet --batch --decrypt /path/to/password.gpg"
```

这样每次使用都要输入GPG密码，为了避免这种情况，可以在`~/.gnupg/gpg.conf`写入以下内容来缓存密码。

```
use-agent
```

这样就不用每次都输入密码了。记得删除明文存储密码的password文件:)

## 参考

- [Gnus Manual](https://www.gnu.org/software/emacs/manual/html_mono/gnus.html)
- [Emacs Gnus 的基本配置与使用](https://www.cnblogs.com/csophys/articles/2375236.html)
- [Emacs收发邮件完全操作指南: Send-Mail, Rmail and Gnus](https://emacs-china.org/t/emacs-send-mail-rmail-and-gnus/11730/4?page=2)

---
date: '2025-11-12T16:48:02+08:00'
draft: false
title: '使用Emacs收发邮件'
slug: 'email-with-emacs'
categories:
  - 往昔
tags:
  - GNU/Emacs
  - Linux
---
作为一个合格的操作系统，肯定少不了Email. 我的配置很简单，只要实现基础的收发功能即可，每天的邮件量不大。在这里记录一下配置。

## 收邮件

我尝试过 **[fetchmail](https://www.fetchmail.info)**，但不知道这个东西拿到的邮件都在哪，所以最后还是选择了 **mbsync**.

```
# ~/.mbsyncrc
# GlowIsle 账户配置
IMAPAccount GlowIsle
Host imap.qiye.aliyun.com
Port 993
User i@glowisle.me
Pass ******
TLSType IMAPS
AuthMechs LOGIN
CertificateFile /etc/ssl/certs/ca-certificates.crt

# 远程存储
IMAPStore glowisle-remote
Account GlowIsle

# 本地存储
MaildirStore glowisle-local
Path ~/mail/GlowIsle/
Inbox ~/mail/GlowIsle/Inbox
Subfolders Verbatim

# 同步通道
Channel glowisle
Far :glowisle-remote:
Near :glowisle-local:
Patterns *
Create Both
Sync All
Expunge Both
SyncState *

```


## 发邮件

```
# ~/.msmtprc
# glowisle
account glowisle 
host smtp.qiye.aliyun.com
from i@glowisle.me
auth login
port 465
user i@glowisle.me
password ******* 
auth on
tls on
tls_starttls off #使用465端口时不能开启
tls_certcheck  off 
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default : glowisle

```


## Emacs 配置

在Doom Emacs的`init.el`中开启 mu4e

```lisp
 :email
    (mu4e +org)
 
```


```lisp
;; config.el
(after! mu4e
  ;; 基本设置
  (setq mu4e-maildir "~/mail"     ; 邮件目录
        mu4e-get-mail-command "mbsync -a"  ; 接收邮件命令
        mu4e-update-interval 300  ; 自动更新间隔（秒）
        mu4e-view-show-images t   ; 显示图片
        mu4e-compose-signature "Best regards.\nVerdant") ; 邮件签名

  ;; 使用 msmtp 发送邮件
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "/usr/bin/msmtp"
        sendmail-arguments '("--read-envelope-from" "--read-recipients"))


  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "GlowIsle"
          :match-func (lambda (msg)
                        (when msg
                          (string-match-p "^/GlowIsle" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "i@glowisle.me")
                  (user-full-name    . "Verdant")
                  (smtpmail-smtp-server . "smtp.qiye.aliyun.com")
                  (smtpmail-smtp-service . 465)
                  (smtpmail-stream-type . starttls)))))

  )

```

## 基本使用

- `SPC o m` 进入 mu4e 主页面

```
Basics

    * [J]ump to some maildir
    * enter a [s]earch query
    * [C]ompose a new message

Bookmarks

    * [bu] Unread messages      (0/0)
    * [bt] Today's messages     (0/14)
    * [bw] Last 7 days
    * [bp] Messages with images (0/0)
    * [bf] Flagged messages     (0/1)

Misc

    * [;]Switch focus
    * [u]pdate email & database

    * [N]ews
    * [A]bout mu4e
    * [H]elp
    * [q]uit
```
---

微软的Outlook邮箱使用OAuth2.0认证，我暂时没找到成功的解决方案能在Emacs上使用，如果有哪位路过的好哥们知道方法请留言或[发个邮件](mailto:i@glowisle.me)探讨一下！

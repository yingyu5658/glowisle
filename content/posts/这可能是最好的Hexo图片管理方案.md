---
abbrlink: 1950788762
categories:
- 往昔
date: "2025-06-29 10:52:05"
tags:
- Hexo
title: 这可能是最好的Hexo图片管理方案
---

## 前言
通常在Hexo博客中，我们管理图片资源都有以下两种方案：

1. 在`_post`目录下新建文章同名文件夹
2. 在`source`目录下新建images文件夹，存放所有图片

两种方法各有优劣，前者方便查找但污染目录，后者集中管理但维护成本高。所以就诞生出本文要介绍的方法——`images`目录下新建文章同名目录

这是一个折中的办法，既保留方法1的查找方便，又保留方法2的集中性。

## 实现方法

**创建脚本文件**

在Hexo根目录的`scripts`文件夹（若不存在则新建）下创建一个javascript脚本，我这里就命名为`auto-image-folder.js`

```js
const fs = require("fs")
const path = require("path")

hexo.on("new", function(data) {
        const postName = path.basename(data.path, ".md")
        const imageDir = path.join(hexo.source_dir, "images", postName)

        if(!fs.existsSync(imageDir)){
                fs.mkdirSync(imageDir, {recusive: true})
        }
})
```

**效果测试**
```bash
hexo new "新文章"
```

这时候就在images目录下新建了一个与文章同名的文件夹。


## 编辑器设置优化

### Typora 

打开Typora → 偏好设置 → 图像

设置：

  - 插入图片时：复制到指定路径

  - 自定义路径：../source/images/${filename}/

  - 勾选：优先使用相对路径

```
PS E:\blog> ls .\source\images\测试\


    目录: E:\blog\source\images\测试


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         2025/6/29     11:14            229 image-20250629111411456.png
```

完成！


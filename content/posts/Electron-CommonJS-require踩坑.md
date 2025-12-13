---
abbrlink: 472869193
categories:
- 往昔
date: "2025-05-31T09:07:36+08:00"
tags:
- 前端
- Electron
title: Electron CommonJS require踩坑
---
最近在开发一个Electron项目，在导入类的时候有以下报错:
```
node:internal/modules/cjs/loader:1411 Uncaught Error: Cannot find module './File'
Require stack:
- E:\Develop\markdown-editor\src\html\index.html
    at Module._resolveFilename (node:internal/modules/cjs/loader:1408:15)
    at a._resolveFilename (node:electron/js2c/renderer_init:2:2643)
    at defaultResolveImpl (node:internal/modules/cjs/loader:1064:19)
    at resolveForCJSWithHooks (node:internal/modules/cjs/loader:1069:22)
    at Module._load (node:internal/modules/cjs/loader:1218:37)
    at c._load (node:electron/js2c/node_init:2:17950)
    at s._load (node:electron/js2c/renderer_init:2:31718)
    at TracingChannel.traceSync (node:diagnostics_channel:322:14)
    at wrapModuleLoad (node:internal/modules/cjs/loader:242:24)
    at Module.require (node:internal/modules/cjs/loader:1494:12)
```
提示找不到模块。

Electron中，使用require语句导入，都是默认从项目跟目录开始查找，所以要拼接完整路径。使用绝对路径也是不行的，在IDE里可以跳转，但是一运行就是找不到模块
`const File = require("src/js/File")`

```
Uncaught Error: Cannot find module 'src/js/File'
Require stack:
- E:\Develop\markdown-editor\src\html\index.html
    at Module._resolveFilename (node:internal/modules/cjs/loader:1408:15)
    at a._resolveFilename (node:electron/js2c/renderer_init:2:2643)
    at defaultResolveImpl (node:internal/modules/cjs/loader:1064:19)
    at resolveForCJSWithHooks (node:internal/modules/cjs/loader:1069:22)
    at Module._load (node:internal/modules/cjs/loader:1218:37)
    at c._load (node:electron/js2c/node_init:2:17950)
    at s._load (node:electron/js2c/renderer_init:2:31718)
    at TracingChannel.traceSync (node:diagnostics_channel:322:14)
    at wrapModuleLoad (node:internal/modules/cjs/loader:242:24)
    at Module.require (node:internal/modules/cjs/loader:1494:12)
```

## 解决方法
使用path.join拼接完整路径
```js
const File = require(path.join(__dirname, "../js/File.js"));
```
经过测试，只能用这种方法导入，太怪了

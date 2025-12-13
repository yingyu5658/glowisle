---
abbrlink: 2367638025
categories:
- 往昔
date: "2025-03-22 18:56:33"
tags:
- JavaScript
- NodeJS
title: Nodejs环境下控制台拼接字符串输出有undefind
---

今天在Nodejs环境下搓小工具，控制台输出拼接字符串时，发现有`undefind`，代码如下：

```javascript
const date = new Date();
const year = date.getFullYear();
const month = date.getMonth();
const day = date.getDate();
const hour = date.getHours();
const minute = date.getMinutes();
const second = date.getSeconds();
const logTime = `[${year}-${month}-${day} ${hour}:${minute}:${second}] `;

class GenerateLog {
  static log() {
    process.stdout.write(logTime);
  }
}

console.log(GenerateLog.log() + "log output on the console");
```

输出确是这样：

```
[2025-3-22 18:56:33] undefindlog output on the console
```

原因
：`GenerateLog.log()`方法没有返回值，所以输出`undefind`，解决方法如下：

```javascript
// 让log方法返回logTime
class GenerateLog {
  static log() {
    return logTime; // 返回字符串
  }
}

console.log(GenerateLog.log() + "log output on the console");
```

关键总结：
Javascript中，如果方法没有返回值，那么输出的就是`undefind`

#### 扩展

为什么 console.log() 本身会返回 undefined？
在 REPL 环境（如 Node.js 命令行或浏览器控制台）中，每条语句的执行结果会被隐式打印。由于 console.log() 函数本身没有返回值（即返回 undefined），因此会显示 undefined。但在脚本执行时，这一行为不会发生，因为脚本模式不自动打印返回值

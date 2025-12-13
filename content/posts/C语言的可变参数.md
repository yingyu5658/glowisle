---
abbrlink: 188975074
categories:
- 往昔
date: "2025-07-05 18:32:52"
tags:
- C语言
- 编程
title: C语言的可变参数
---

## 介绍

C语言中，`printf()`和`scanf()`函数就是典型的变参函数，其优点是灵活处理参数。

想要创建变参函数需引入头文件`stdarg.h`，它有一些宏：

```
va_list 指向整个可变参数列表的指针
原型：typedef char* va_list;

va_start 指向可变参数列表前的参数（...前的参数）
原型：void va_start(va_list ap, paramN);

va_arg 可变参数列表
原型：typedef va_arg(va_list ap, type)

va_end 结束对可变参数列表的访问，并释放资源
原型：void va_end(va_list ap);
```

## 使用例

```c
#include <stdio.h>
#include <stdarg.h>


// 定义一个使用省略号的函数原型
void function(int argument, ...)
{
        // 声明一个va_list类型的变量ap，这是可变参数列表
        va_list ap;

        // 使用va_start把变量ap初始化为参数列表
        va_start(ap, argument);

        // 第二个参数表明本函数期望传入一个int类型
        // 但是编译器不会检查到底输入了什么。
        int output = va_arg(ap, int);

        printf("可变参数：%d\n", output);

        va_end(ap);
}


int main()
{
        function(1, 109);
}
```

输出：

```
可变参数：109
```

函数起了作用，但是如果我们需要接受多个参数，应该如何获取呢？

```c
#include <stdio.h>
#include <stdarg.h>


// 定义一个使用省略号的函数原型
void function(int argument, ...)
{
        // 声明一个va_list类型的变量ap，这是可变参数列表
        va_list ap;

        // 使用va_start把变量ap初始化为参数列表，此处的第二个参数是最后一个固定参数
        va_start(ap, argument);

        // 第二个参数表明本函数期望传入一个int类型
        // 但是编译器不会检查到底输入了什么。

        int arguments_list[4];

        for(int i = 0; i < 4; i++) {
                arguments_list[i] = va_arg(ap, int); // 按int类型提取参数
        }

        va_end(ap);

        // 遍历参数列表并打印
        for (int i = 0; i < 4; i++) {
                printf("可变参数%d：%d\n", i + 1, arguments_list[i]);
        }

}


int main()
{
        function(1, 10, 12, 2, 111);
}
```



## 扩展：`va_start`的第二个参数的工作原理

`va_start`的第二个参数用于定位可变参数列表的起始位置，具体而言，它指向函数参数列表中最后一个固定参数（即省略号前的参数），通过该参数的地址计算出第一个可变参数在内存中的位置。

C函数的参数按从右至左顺序入栈（栈底高地址，栈顶低地址）

`va_start`的第二个参数作为基准点，其地址加上自身大小后，即指向第一个可变参数的起始地址。

所以`...`前至少要有一个固定参数用于寻址。

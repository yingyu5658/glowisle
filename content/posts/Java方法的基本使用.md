---
abbrlink: 3033809787
author: yingyu5658
categories:
- 往昔
cid: 89
cover: images\2024\12\2743265221.jpg
customSummary: null
date: "2024-11-29T20:45:20+08:00"
layout: post
mathjax: auto
noThumbInfoEmoji: null
noThumbInfoStyle: default
outdatedNotice: "no"
parseWay: auto
reprint: standard
slug: 89
status: publish
tags:
- Java
thumb: null
thumbChoice: default
thumbDesc: null
thumbSmall: null
thumbStyle: default
title: Java方法的基本使用
updated: 2024/11/29 20:46:17
---




# 方法是什么

方法是一种语法结构，它可以把代码封装成一段功能，以便重复调用。

方法的完整格式：

例子：数字求和

```java
    public static  int sum(int a,int b){
        int c = a + b;
        return c;
    }
```

方法的调用：

```java
       int rs= sum(10,20);
```

## 方法使用的注意点：

方法申明了具体的返回值类型，内部必须使用return返回对应类型的数据。

形参列表可以有多个，甚至可没有；如果有多个形参，必须用英文逗号隔开，且不能给初始化值

## 使用方法的好处

- 提高代码的复用性，提高了开发效率
- 让程序逻辑性更清晰

## 方法的其他定义形式

```java
    public static void printHelloWorld(int n) {
        for (int i = 1; i <=n; i++) {
            System.out.println("Hello World");
        }
    }
//打印三行helloworld（使用方法）
```



- 如果方法不需要返回数据，返回类型必须申明成``void``此时方法内部可以不使用return返回数据。
- 方法如果不需要接收数据，则不需要定义形参，调用方法时也不可以传数据给方法了。
- 没有参数，且没有返回类型（void）申明的方法，称为**无参数、无返回值的方法**

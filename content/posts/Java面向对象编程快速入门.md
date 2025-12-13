---
abbrlink: 1091767210
author: yingyu5658
categories:
- 往昔
cid: 98
customSummary: null
date: "2024-12-01 13:05:00"
layout: post
mathjax: auto
noThumbInfoEmoji: null
noThumbInfoStyle: default
outdatedNotice: false
parseWay: auto
reprint: standard
slug: 98
status: publish
tags:
- Java
thumb: null
thumbChoice: default
thumbDesc: null
thumbSmall: null
thumbStyle: default
title: Java面向对象编程快速入门
updated: 2024/12/07 10:56:43
---


# 什么是面向对象编程
通俗易懂的说，就是把一坨一坨的数据放到一起存储
比如要存储一个学生的语文成绩和数学成绩
新建一个类
```java
public class Student {
    String name;//名字
    double chinese;//语文成绩
    double math;//数学成绩

    public void printTotalScore() {
        System.out.println(name + "的总成绩是" + (chinese + math));
    }

    public void printAverageScore() {
        System.out.println(name + "的平均成绩是" + (chinese + math) / 2.0);
    }
}
```
这样学生的模板就创建好了，但是这个模板还没有指向学生的每一个个体。我们可以再同一个包下再新建一个类。
```java
public class Test {
    public static void main(String[] args) {
        //1.创建宇哥学生对象来封装学生a的数据
        Student s1 = new Student();
        s1.name = "学生a";
        s1.chinese = 100;
        s1.math = 100;
        s1.printTotalScore();
        s1.printAverageScore();

        //2.再创建一个学生对象，封装学生b的数据
        Student s2 = new Student();
        s2.name = "学生b";
        s2.chinese = 100;
        s2.math = 59;
        s2.printTotalScore();
        s2.printAverageScore();
    }
}
```
用以上代码新建一个学生类并且调用我们之前写好的功能

- 开发一个一个的对象，把数据交给对象，再用调用对象的方法来完成对数据的处理，这种方法叫**面向对象编程**。

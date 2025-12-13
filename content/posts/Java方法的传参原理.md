---
abbrlink: 1642973481
author: yingyu5658
categories:
- 往昔
cid: 95
cover: images\2024\12\2743265221.jpg
customSummary: null
date: "2024-11-30 20:14:00"
layout: post
mathjax: auto
noThumbInfoEmoji: null
noThumbInfoStyle: code
outdatedNotice: false
parseWay: auto
reprint: standard
slug: 95
status: publish
tags:
- Java
thumb: null
thumbChoice: default
thumbDesc: null
thumbSmall: null
thumbStyle: default
title: Java方法的传参原理
updated: 2024/12/07 10:56:51
---


## Java方法的参数传递机制-基本类型
值传递
### 值传递是什么
在传输实参给方法的形参的时候，**传输的是实参变量中存储的副本**
说人话，把实参里面的东西赋值了一部分扔了给形参
## 值传递具体理解案例
```java
public class prameter {
    public static void main(String[] args) {
        int a = 10; //定义一个int变量a赋值为10
        change(a); //调用change方法
        System.out.println("main" + a); //打印mian a中的值
    }

//这里开始写方法
    public static void change(int a){
        System.out.println("change1" + a); //打印方法中a的值
        a = 20;
        System.out.println("change2"a); //打印赋值后a的值
    }
}
```
我们运行以后，控制台输出的结果为
```
change1 10
change2 20
main 10
```
## 为什么main中打印的不是赋值后的20？
这就要提到刚才的概念：**值传递**
我们定义了一个变量``a = 10；``,在方法中``public static void change(int a)``
由于**值传递**，也就是把值复制了一分传给方法，所以我们方法里用的值永远都是刚刚定义的``int a = 10;``，所以``change(a); = change(10);``
我们后面再赋值，打印出来的结果还是10，除非你把变量定义的代码改了，否则方法里的值不会变。


## 引用类型的参数传递
引用类型的参数传递也满足值传递，但代码中会有不同的地方。
示例代码
```java
    public static void main(String[] args) {
        int[] arrs = new int[]{10,20,30};
        change(arrs);
        System.out.println("main" + arrs[1]);
    }
    public static void change(int[] arrs) {
        System.out.println("方法内1" + arrs[1]);
        arrs[1] = 222;
        System.out.println("方法内2" + arrs[1]);
    }
```
结果：
```
方法内1：20
方法内2：222
main：222
```
上一篇文章提到了栈内存的执行顺序，根据上一篇所讲，代码执行顺序如下:
1.先执行
```java
    public static void change(int[] arrs) {
        System.out.println("方法内1" + arrs[1]);
        arrs[1] = 222;
        System.out.println("方法内2" + arrs[1]);
    }
```
2.再回到main方法
```java
        System.out.println("main" + arrs[1]);
```
在1时进行打印，结果得到数组内第二个位置存储的20.
代码继续向下执行，第二个位置被赋值为222，此时再打印它，结果得到222.
这时候change方法执行完，它在栈内存中会被清除，然后回到main方法，由于刚才change方法中对arr[1]进行了赋值，所以我们再打印，结果得到的还是它赋值出来的222.

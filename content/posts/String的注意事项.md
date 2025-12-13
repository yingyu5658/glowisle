---
CopyRight: true
NoCover: true
ShowReward: false
ShowToc: show
abbrlink: 1413738899
author: yingyu5658
categories:
- 往昔
cid: 171
cover: images\2024\12\2743265221.jpg
date: "2024-12-19 22:28:15"
desc: null
keywords: null
layout: post
showTimeWarning: true
slug: 171
status: publish
summaryContent: null
tags:
- Java
thumb: null
title: String的注意事项
updated: 2024/12/19 22:28:15
---


# String的注意事项
- 1. String对象的内容不可改变， 被称为不可变字符串对象。
- 2. 只要是以“...”的方式写出的字符串，都会存储到字符串常量池，且相同的字符串只存储一份；
- 但通过new方式创建字符串对象，每new一次都会产生一个新的对象放在堆内存中。
# 不可变字符串对象
不可变？它肯定可变啊，比如
```java
package string;  
  
public class StringDemo3 {  
    public static void main(String[] args) {  
        String name = "yingyu5658";  
        name += ".me";  
        name += "域名";  
        System.out.println(name);  
  
    }  
}
```
这时候把name打印出来不就是``yingyu5658.me域名``了吗？
**每次试图改变字符串对象实际上是新产生可字符串对象，变量每次都与指向了新的字符串对象，之前字符串对象的内容确实是没有改变的，因此说String的对象都是不可变的。**

# 第二点注意事项

示例代码：
```java
package string;  
  
public class StringDemo3 {  
    public static void main(String[] args) {  
        String s1 = "abc";  
        String s2 = "abc";  
        System.out.println(s1 == s2);  
        //true  
    }  
}
```
这里使用双等来判断两个变量的地址是否相同，返回结果为``true``,也就是说，地址是相同的。
原理：上文提到，双引号包裹住的字符串，会被保存到字符串常量池中，**且相同的字符串只存储一份**。这里我们声明了两个内容为abc的String类型变量。Java是很聪明的，当我们把s2声明，它要存到字符串常量池时，看到内容一样，就不再存了，而是把**s2也指向abc**，因此s1地址和s2地址是一样的。

## new
示例代码：
```java
package string;  
  
public class StringDemo3 {  
    public static void main(String[] args) {  
        char[] chars = {'a','b','c'};  
       String a1 =  new String(chars);  
       String a2 =  new String(chars);  
        System.out.println(a1 == a2);  
        //false  
    }  
}
```
上文提到，每new一次就会创建一个新的对象，所以此时再比较两者地址，返回false，是不同的。

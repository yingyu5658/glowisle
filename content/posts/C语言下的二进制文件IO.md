---
date: "2025-07-12T00:26:59+08:00"
draft: false
categories: 
- 往昔
slug: ""
title: C语言下的二进制文件IO踩坑
---

C语言下的二进制文件读写有个坑，就是一定要按存储的顺序读取。例：
```c
typedef struct player {
	int id;
	double XP;
	double MP;
}player;
```

这里有一个玩家的数据结构，我们创建变量并初始化。

```c
int b_i[32] = {1, 233, 2453, 5432, 21 ,43 ,297, 752, 643};
player yingyu5658;
yingyu5658.MP = 100;
yingyu5658.XP = 100;
yingyu5658.id = 114514;
```

对文件进行存储时，按照MP=>XP=>ID的顺序存储
```c
pd = fopen("./data", "wb");
fwrite(&yingyu5658.MP, sizeof(double), 1, pd);
fwrite(&yingyu5658.XP, sizeof(double), 1, pd);
fwrite(&yingyu5658.id, sizeof(int), 1, pd);
```

读取的时候一定要按照这个顺序，否则读取出来的内容是无效的。

```c
int id;
double XP, MP;
pd = fopen("./data", "rb");
fread(&MP, sizeof(double), 1, pd);
fread(&XP, sizeof(double), 1, pd);
fread(&id, sizeof(int), 1, pd);
player new_player;
new_player.id = id;
new_player.XP = XP;
new_player.MP = MP;
printf("id: %d\n", new_player.id);
printf("XP: %f\n", new_player.XP);
printf("MP: %f\n", new_player.MP);
```

运行结果：	
```
写入了id: 114514
写入了XP: 100.000000
写入了MP: 100.000000

id: 114514
XP: 100.000000
MP: 100.000000
```

使用完也要关闭流，否则资源泄漏
```c
fclose(pd);  // 必须显式关闭
```

---
abbrlink: 594023371
categories:
- 往昔
date: "2025-06-07 13:08:07"
tags:
- Malody
- osu
- 数据结构与算法
title: 4Key音游段位单曲成绩计算的程序实现
---
## 前言

其实这个坑我很早以前就想开了，在我刚开始学编程那会就一直想写一个这个东西。但苦于数学进度没达到，要用到加权平均数，这东西我前两天才学到，之前对数学也一直是懒得学的状态，要不然几乎是看不懂那个算法的。

我手头有一个[Special-Week](https://github.com/Special-Week)写的网页版的单曲成绩计算器，就以这个为研究样本吧。以下简称原作者为sw（如有冒犯请联系修改）

## 数据结构设计

```js
    // 基础的4k类
    class Dan4k {
        constructor(key1, key2, key3, key4, danName) {
            this.m_key1 = key1;
            this.m_key2 = key2;
            this.m_key3 = key3;
            this.m_key4 = key4;
            this.m_danName = danName;
        }
    }

```

每一个段（LN、Om），sw都单独写了一个内部类，继承Dan4k。

```js
 // lnDan类
    class LnDan extends Dan4k {
        constructor(key1, lnKey1, key2, lnKey2, key3, lnKey3, key4, lnKey4, danName) {
            super(key1, key2, key3, key4, danName);
            this.m_lnKey1 = lnKey1;
            this.m_lnKey2 = lnKey2;
            this.m_lnKey3 = lnKey3;
            this.m_lnKey4 = lnKey4;
        }
    }
    // ma段
    class MaDan extends Dan4k {
        constructor(key1, key2, key3, key4, name1, name2, name3, name4, danName) {
            super(key1, key2, key3, key4, danName);
            this.m_name1 = name1;
            this.m_name2 = name2;
            this.m_name3 = name3;
            this.m_name4 = name4;
        }
    }
    // reform段
    class ReformDan extends Dan4k {
        constructor(key1, key2, key3, key4, name1, name2, name3, name4, danName) {
            super(key1, key2, key3, key4, danName);
            this.m_name1 = name1;
            this.m_name2 = name2;
            this.m_name3 = name3;
            this.m_name4 = name4;
        }

    }
    // om段
    class OmDan extends Dan4k {
        constructor(key1, key2, key3, key4, danName) {
            super(key1, key2, key3, key4, danName);
        }
    }
```

我打算重写的程序不带LN玩了，我自己也没玩过LN，不清楚是什么机制。那就来看看剩下的几个类。

`Dan4k`类定义了一个段位的基础属性，但是这个参数key1-4是用来做什么在当前上下文暂且不清楚，是第n首歌的物量吧。

那么由此可以推断，这些类都描述了一个谱面的基本属性：
- 物量
- 歌曲名称
- 段位名称
然后分支匹配数据并计算。我也用C语言实现一个。

```c
// 整个段位信息
typedef struct Dan {
    // 段位名字
    char* dan_name; 
    // 四首歌的名字，用于匹配数据
    char* song1_name;
    char* song2_name;
    char* song3_name;
    char* song4_name;
    // 四首歌的物量
    int song1_key;
    int song2_key;
    int song3_key;
    int song4_key;
}Dan;
```

来看看网页版中数据是如何存储的

```js
    // MaDan数据
    let MaArr = [
        new MaDan(813, 955, 907, 654, "Glitch Nerds", "Borealis", "Niflheim", "Moon", "1dan"),
        new MaDan(1152, 850, 950, 969, "Follow Tomorrow", "Bronze Coffin", "Keigan no Zettaireido", "SakuraMirage", "2dan"),
        new MaDan(1169, 1143, 974, 1347, "Quon", "Genkyoku o Kirikizamu", "Gin no Kaze", "Adjudicatorz-Danzai-", "3dan"),
        new MaDan(1400, 1402, 1685, 1599, "Tenkuu no Yoake", "VALLISTA", "Crystal World ~Fracture~", "Zenithalize", "4dan"),
        new MaDan(1953, 2250, 2166, 1667, "Ten Thousand Tons of Anonymous Letters", "Chips of Notes", "Despair of Elferia", "Kamigami no Asobi", "5dan"),
        new MaDan(1487, 1424, 1381, 1587, "Sweet Cherry X", "Akasagarbha", "HELLO EveryOne", "DataErr0r", "6dan"),
        new MaDan(1909, 1814, 1777, 2681, "Fairy Stage", "Xross Infection", "Wave", "Blue Zenith", "7dan"),
        new MaDan(1962, 1067, 2388, 1772, "The Lost Dedicated", "The Party We Have Never Seen", "Finixe", "Ultimate Dream", "8dan"),
        new MaDan(1799, 2023, 2283, 1787, "Dusk", "Panic Popn Picnic", "Kick-ass Kung-Fu Carnival", "Yakusoku no kimi", "9dan"),
        new MaDan(2606, 2188, 2194, 2187, "Chaser", "Loli Fantasy", "Daydream", "Moon Gate", "10dan"),
        new MaDan(2160, 1952, 1821, 3249, "Border of Life", "Scorpion Dance", "The Island of Albatross", "beautiful loli thing", "ex1"),
        new MaDan(2871, 2024, 1871, 2452, "Hitsune no youmeiri", "紫阳花-AZISAI-", "love&justice", "message", "ex2"),
        new MaDan(2327, 1593, 2166, 2200, "Jumble Rumble", "End Time", "++", "Crow Solace", "ex3"),
        new MaDan(2731, 2653, 2033, 2761, "EDM Jumpers", "line-epsilon", "Contrapasso -paradiso-", "YELL!", "ex4"),
        new MaDan(3229, 2731, 2561, 2109, "Satori de Pon!", "Legend of Seeker", "Crystal World -Fracture-", "Wizdomiot", "ex5"),
        new MaDan(1766, 1861, 3171, 1680, "Sepia", "Nopea", "Satori Trisis", "Death", "ex6"),
        new MaDan(2339, 2461, 2511, 2177, "Paranoia", "Boulafacet", "Paraclete -Miracle-", "Yumemi no Shonen", "ex7"),
        new MaDan(1929, 2380, 2710, 4675, "Martail Arts", "Gene Disruption", "Paradigm Shift", "Death Melody", "ex8"),
        new MaDan(3468, 3335, 3698, 5061, "Only my railgun", "-Purgatorium-", "Blue Zenith", "Inner Universe", "exfin"),

        new MaDan(492, 529, 595, 681, "Ikitoshi Ikerumono", "Rambling Pleat", "Yi Meng Qian Xiao", "White Eternity", "0danv3"),
        new MaDan(695, 621, 718, 1279, "Rex Incoqnito", "Koiseyo Otome!", "Break", "KING", "1danv3"),
        new MaDan(1397, 1090, 805, 1212, "Stargazer", "Seyana", "Love Emotion", "Mermaid Girl", "2danv3"),
        new MaDan(1055, 1489, 1288, 1789, "Koi Kou Enishi", "Onegai!Kon Kon Oinari-sama", "The Last page", "Hoshi ga Furanai Machi", "3danv3"),
        new MaDan(1865, 1434, 1284, 1839, "Umiyuri Kaiteitan", "Fire in the sky", "Icyxis", "The Crimson Empire", "4danv3"),
        new MaDan(1282, 1706, 1473, 1939, "Platinum Disco", "Cute na Kanojo", "Reimei Sketchbook", "Joker", "5danv3"),
        new MaDan(1694, 1636, 1803, 2115, "Chocolate Disco", "Call Me, Beep Me (If You Wanna Reap Me)", "DIE IN THE SEA", "unhappy century", "6danv3"),
        new MaDan(1701, 1799, 2132, 1899, "Don't Stop The Music", "Six Acid Strings", "Arkadia [Illusion]", "Valkyrie Revolutia", "7danv3"),
        new MaDan(2237, 2081, 2280, 2000, "Don't let you down", "Yoru ni Kakeru", "Snow Veil -Shoujo to Kemono no Mori-", "Positive Dance Time", "8danv3"),
        new MaDan(2374, 1899, 2142, 1810, "Kikai Shoujo Gensou", "Cold Planet", "Stray Star", "Unleashed World", "9danv3"),
        new MaDan(2034, 1740, 2270, 2166, "Hiensou", "Rocky Buinne", "Yue Ai Yue Ye", "Spin Eternally", "10danv3"),
        new MaDan(1952, 2013, 1953, 2111, "Scorpion Dance", "Tailin no Soul", "Eiya no Parade", "Onsoku Uchuu Ryokou", "ex1v3"),
        new MaDan(2107, 1953, 2386, 2674, "Moments", "Towards the Horizon", "Torikago", "Frontier Explorer", "ex2v3"),
        new MaDan(2518, 2636, 2326, 2511, "Edison", "INTERNET OVERDOSE", "Euthanasia", "Fin.ArcDeaR", "ex3v3"),
        new MaDan(2634, 2212, 2336, 2602, "ZENITHALIZE", "Asymmetrical Grooves", "Pure Ruby", "EVERLASTING HAPPiNESS", "ex4v3"),
        new MaDan(2734, 2417, 3089, 2974, "Bring Our Ignition Back", "Unsan-musho", "Electric Angel", "Kegare Naki Bara Juuji", "ex5v3"),
        new MaDan(2483, 2276, 2921, 3194, "Defeat awaken battle ship", "Extraction", "Pastel Subliminal", "Synthesized Fortress", "ex6v3"),
        new MaDan(2846, 2260, 2333, 3347, "LiFE Garden", "Alpha", "Stay Alive", "Heaven's Fall", "ex7v3"),
        new MaDan(3789, 3663, 2424, 3255, "Hayabusa", "Shuu no hazama", "Amatsukami", "CRIMSON FIGHTER", "ex8v3"),
        new MaDan(3888, 3030, 3581, 3700, "crazy_tek (DJ Noriken Remix)", "Nhelv", "Shuuten", "Deadly force - Put an end", "ex9v3"),
        new MaDan(2828, 3362, 3393, 5100, "Infinity Heaven", "NEURO-CLOUD-9", "Kizuato", "Runengon", "exfinv3"),
    ]
```

可以看到，简单地调用构造函数新建对象。继续实现：
我们可以写一个`init`函数，根据需要创建结构体变量。
```c
Dan* dan_data_init(Dan*, int* songs_key);
```

第二个参数是存放物量的数组，这样就实现了代码复用，减少重复代码的编写，定义一次所有物量即可。

```c
// 常规段
int mld_1dan_total_keys[] = {813, 955, 907, 654};
int mld_2dan_total_keys[] = {1152, 850, 950, 969};
int mld_3dan_total_keys[] = {1169, 1143, 974, 1347};
int mld_4dan_total_keys[] = {1400, 1402, 1685, 1599};
int mld_5dan_total_keys[] = {1953, 2250, 2166, 1667};
int mld_6dan_total_keys[] = {1487, 1424, 1381, 1587};
int mld_7dan_total_keys[] = {1909, 1814, 1777, 2681};
int mld_8dan_total_keys[] = {1962, 1067, 2388, 1772};
int mld_9dan_total_keys[] = {1799, 2023, 2283, 1787};
int mld_10dan_total_keys[] = {2606, 2188, 2194, 2187};
```

这里目前把常规段都录入了，那要怎么按需匹配创建结构体变量呢？可以通过一个指针数组保存这些数据数组的地址，然后根据用户输入的数字直接作为索引，创建结构体变量并进行初始化赋值。

优点：避免if/switch分支判断逐个比较，时间复杂度为常数阶。

```c
int* dan_total_keys_index[] = {mld_1dan_total_keys, mld_2dan_total_keys, mld_3dan_total_keys, mld_4dan_total_keys, mld_5dan_total_keys, mld_6dan_total_keys, mld_7dan_total_keys, mld_8dan_total_keys, mld_9dan_total_keys, mld_10dan_total_keys};
```

后续接着往这个数组里面装指针即可。

基本的数据结构实现了，就可以开始研究一下算法，后续再录入数据吧。

## 算法实现

曾经听群友讲过这个东西核心理念是加权平均数，最近才学到，那就来看看怎么做这个平均数吧。

直接看原作者是怎么实现的

```js
 function normal_calculation(accArr, noteArr) {
            let score1 = accArr[0]
            let temp1 = (noteArr[0] + noteArr[1]) * accArr[1] - noteArr[0] * accArr[0]
            let score2 = temp1 / (noteArr[1])
            let temp2 = (noteArr[0] + noteArr[1] + noteArr[2]) * accArr[2] - (noteArr[0] + noteArr[1]) * accArr[1]
            let score3 = temp2 / (noteArr[2])
            let temp3 = (noteArr[0] + noteArr[1] + noteArr[2] + noteArr[3]) * accArr[3] - (noteArr[0] + noteArr[1] + noteArr[2]) * accArr[2]
            let score4 = temp3 / (noteArr[3])
            return [score1, score2, score3, score4]
        }
```

第一首的ACC不变，这个不说了。

这个temp算的是什么？？？

刚刚去看了一下引用，accArr存放着四首的玩家成绩Acc，noteArr存着这四首歌的Note总数量。

还是没搞明白这个temp在干什么，看这段代码是真想骂街啊。

用1dan举例子，Note和ACC：
```
813, 955, 907, 654
99   98   96   94
```
~~叠批来了~~

Malody的每一个判定都有不同的权重，都有对应不同的Acc衰减，所以每一首歌曲结束后都是一个加权平均数。程序要做的事情就是逆推出原本的Acc。

所以`accArr`是一个累计加权平均值数组。
`noteArr`是每批数据的权重。
目标：计算每批数据的**独立加权平均值**。

### 数学逻辑

**第一批数据：**
```js
let score1 = accArr[0]
```
直接使用第一个累计平均值a1，此时只有第一批数据。

**第二批数据：**
```js
let temp1 = (noteArr[0] + noteArr[1]) * accArr[1] - noteArr[0] * accArr[0] 
let score2 = temp1 / noteArr[1]
```

- 累计平均值`a2 = (n1s1 +n2s2) / (n1 + n2)`
- 解得`s2`:`(n1 +n2)a2 - n1s1 / n2`
......

额...这一顿推导，给我也整不会了。我数学奇烂，那就用一个简明易懂的例子来理解吧。

### 人话

假设参加了4次考试

- 第一次考了80分(score1)
- 第二次的平均分是93.3(accArr[1])
- 第三次的平均分是95(accArr[2])
- 第四次的平均分是97.5(accArr[3])

但是你忘了每次考试的重要程度（权重）：
- 第一次考试占10(noteArr[0] = 10)
- 第二次 20(noteArr[1] = 20)
- 第三次  30(noteArr[2] = 30)
- 第四次 40(noteArr[3] = 40)

你想知道每次考试单独的平均分是多少

1. 第一次考试：
   直接用平均分（因为只有一次考试）
2. 第二次考试：
   先算总分：`前两次总分 = (10+20)*93.3 = 2800`
   减去第一次的分数：`第二次分数 = 2800 - 10 * 80 = 2000`
   第二次平均分： ``score2 = 2000 / 20 = 100``
3. 第三次考试：
   总分：`(10 + 20 + 30 )*95 = 5700`
   减去前两次：`第三次分数 = 5700 - 2800`
   平均分：`score3 = 2900 / 30 ≈ 96.7`
4. 第四次考试
   总分：`(10+20+30+40)*97.5 = 9750`
   减去前3次：`第四次分数 = 9750 - 5700 = 4050`
   平均分：`score4 = 4050 / 40 = 101.25`

写着写着突然发现
```c
typedef struct Dan
{
    // 四首歌的物量
    int* songs_total_keys;
} Dan;
```
这个数据结构只需要一个数组。

人话说完了，该说说计算机的话了。

### 实现

```c
double *common_calc(int *total_keys, double *player_acc)
{
    // 权重：total_keys
    // 分数：player_acc
    // 返回的数组，保存计算完成的Acc
    double *result = (double *)malloc(sizeof(double) * 4);
    if (result == NULL)
    {
        printf("[ERROR] 内存分配失败！");
        return NULL;
    }

    double song1_acc, song2_acc, song3_acc, song4_acc;

    // 第一首歌：直接取第一个累积平均值
    result[0] = player_acc[0];

    // 第二首歌：((n0 + n1)*a1 - n0*a0) / n1
    double sum2 = total_keys[0] + total_keys[1];
    result[1] = (sum2 * player_acc[1] - total_keys[0] * player_acc[0]) / total_keys[1];

    // 第三首歌：((n0 + n1 + n2)*a2 - (n0 + n1)*a1) / n2
    double sum3 = sum2 + total_keys[2];
    result[2] = (sum3 * player_acc[2] - sum2 * player_acc[1]) / total_keys[2];

    // 第四首歌：((n0 + n1 + n2 + n3)*a3 - (n0 + n1 + n2)*a2) / n3
    double sum4 = sum3 + total_keys[3];
    result[3] = (sum4 * player_acc[3] - sum3 * player_acc[2]) / total_keys[3];

    return result;
}
```

然后就是主函数处理用户输入了，没什么含金量，不水了。

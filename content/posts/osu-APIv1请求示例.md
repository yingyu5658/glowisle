---
abbrlink: 3260068752
categories:
- 往昔
date: "2025-04-11 22:29:23"
tags:
- JavaScript
- NodeJS
title: osu!APIv1请求示例
---

## 前言

本文章使用Nodejs环境做演示。请求用户数据。代码中的APIKEY要在[osu官网‬](https://osu.ppy.sh/home/account/edit)申请。

```js
const API_URL = "osu.ppy.sh";
const init = {
    k: "YOUR_API_KEY",
    type: "string",
    u: "kyzzz5658",
};

const https = require("https");

// 将参数序列化为查询字符串
const query = new URLSearchParams(init);
const options = {
    hostname: API_URL,
    method: "GET",
    path: `/api/get_user?${query}` // 附加参数
};

const req = https.request(options, (res) => {
    let data = '';
    res.on('data', (chunk) => data += chunk);
    res.on('end', () => {
        try {
            console.log(JSON.parse(data[0].username));
        } catch (e) {
            console.error('JSON 解析失败:', e);
        }
    });
});

// 错误处理
req.on('error', (err) => {
    console.error('请求失败:', err.code);
});
```

输出：

```
[
  {
    user_id: '33932276',
    username: 'Kyzzz5658',
    join_date: '2023-06-24 08:48:13',
    count300: '2139',
    count100: '609',
    count50: '194',
    playcount: '44',
    ranked_score: '1917044',
    total_score: '3095639',
    pp_rank: '1968010',
    level: '8.0115',
    pp_raw: '43.5449',
    accuracy: '81.70417785644531',
    count_rank_ss: '0',
    count_rank_ssh: '0',
    count_rank_s: '0',
    count_rank_sh: '0',
    count_rank_a: '1',
    country: 'CN',
    total_seconds_played: '2259',
    pp_country_rank: '38721',
    events: []
  }
]
```

​	[首页 ·ppy/osu-api 维基](https://github.com/ppy/osu-api/wiki)

---
title: "安裝 ActionHero"
tags: w3HexSchool ActionHero
---

## 安裝 ActionHero

官網：[Actionhero](https://www.actionherojs.com/)

一開始先試著使用 yarn 安裝，但是一直卡住，最後退回官方教學

Quick start
```bash
# Generate a new Project
npx actionhero generate
npm install
npm run build # <--- new! I compile the TS to JS
npm run dev # <--- new! I use `ts-node` to let you develop on your ts files without compiling
```

成功啟動會試著連 Redis, 連不上則啟動失敗，所以需要有 Redis 才能使用

```
info: Redis connection `client` reconnecting
```

需要有 Redis 才能順利動，啟動 Redis 之後終於順利啟動 Server

執行結果

![](/assets/images/2020-02-29/2020-02-29_22-03-31.png)

範例內建 WebSocket 聊天室，可以直接使用

![](/assets/images/2020-02-29/2020-02-29_22-07-50.png)

接下來要研究一下可以用來玩些什麼
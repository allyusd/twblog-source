---
title: "解決 Puppeteer 在 Github Action 失敗的問題"
tags: w3HexSchool Puppeteer Github-Action DevOps
---

## 問題

Actionhero 發了一個 PR，將 Puppeteer 當作 Web 測試工具，雖然在他開發環境上可以正常執行，但是在Github Action 卻無法通過。

[Browser tests with Puppeteer rather than Selenium by evantahler · Pull Request #1562 · actionhero/actionhero](https://github.com/actionhero/actionhero/pull/1562)

## 結果

![](/assets/images/2020-11-29/2020-11-29-144029.png)


## 問題分析

從環境不同導致結果不同來看，很可能是相依性造成的，在透過 google 查詢關鍵字之後，發現很有用的文章，尤其是這篇關於 puppeteer 3 以上 在 Ubuntu 的回應。

[Ubuntu 18.04 Headless Chrome Node API - Puppeteer - Installation Guide · Issue #3443 · puppeteer/puppeteer](https://github.com/puppeteer/puppeteer/issues/3443#issuecomment-629662626)

## 修改原始碼

在找到問題的解決方案後，在 ci 的 yaml 上加上相依套件的安裝

```yml
sudo apt-get update && apt-get install -y libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb libgbm-dev
```

以及在 puppeteer.launch 時加上 `no-sandbox` 參數

```ts
browser = await puppeteer.launch({
  headless: true,
  args: ["--no-sandbox"],
});
```

最後完整的修改紀錄

[fixed ci fail for puppeteer by allyusd · Pull Request #1654 · actionhero/actionhero](https://github.com/actionhero/actionhero/pull/1654))

這是第二次在 Actionhero 發的 PR，但是第一個在 Actionhero 被接受合併的 PR，留個紀錄紀念一下

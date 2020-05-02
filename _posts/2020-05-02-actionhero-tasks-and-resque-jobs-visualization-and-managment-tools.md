---
title: "ActionHero Tasks & Resque Jobs 視覺化管理工具"
tags: w3HexSchool ActionHero ah-resque-ui
---

本篇介紹如何安裝 ah-resque-ui
[actionhero/ah-resque-ui: Visualization and Managment tools for Actionhero Tasks & Resque Jobs](https://github.com/actionhero/ah-resque-ui)

## 建立 actionhero 專案

```shell
npx actionhero generate
```

## 安裝 ah-resque-ui

```shell
yarn add ah-resque-ui
```

設定 plugin

修改 `./config/plugins.ts`

```ts
export const DEFAULT = {
  plugins: (config) => {
    return {
      "ah-resque-ui": { path: __dirname + "/../../node_modules/ah-resque-ui" },
    };
  },
};
```

新增 `./src/config/ah-resque-ui.ts`

```ts
export const DEFAULT = {
  "ah-resque-ui": (config) => {
    return {
      // the name of the middleware(s) which will protect all actions in this plugin
      // ie middleware: ['logged-in-session', 'role-admin']
      middleware: null,
    };
  },
};
```

輸入 `yarn dev` 啟動後，連到 `http://localhost:8080/resque#/` 即可看到畫面

![](/assets/images/2020-05-02/0001.png)

要注意兩點

一、當沒有任何一個 Queue 的情況下，Overview 的圖會一直處於 loading 狀態

二、UI 的資料是保留在 Client 當下，也就是只要切換頁面不會保留過去的資料，Overview 的圖會清空

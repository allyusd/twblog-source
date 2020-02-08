---
title: "使用 Vue CLI 建立 Vue.js 專案"
tags: w3HexSchool Vue.js Vue-CLI
---

## 安裝 Vue CLI
假設已經安裝好 yarn 跟 Node.js，使用 yarn 安裝 Vue CLI

```bash
yarn global add @vue/cli @vue/cli-service-global
```

安裝後可以透過 version 參數查詢 Vue CLI 安裝版本

```bash
vue --version
```

![](/assets/images/2020-02-08-use-vue-cli-create-vuejs-project/2020-02-04_22-09-51.png)

## 查詢 Vue CLI
想知道 Vue CLI 可以使用哪些指令，可以透過 help 參數，或是 h 短參數，什麼都沒輸入也可以，
三種執行結果相同
```bash
vue --help
vue -h
vue
```
![](/assets/images/2020-02-08-use-vue-cli-create-vuejs-project/2020-02-04_22-15-03.png)

## 建立專案
使用 create 指令建立專案，可以故意不帶參數查詢指令細節，或是乖乖的輸入 help 參數
```bash
vue create --help
vue create -h
vue create
```
![](/assets/images/2020-02-08-use-vue-cli-create-vuejs-project/2020-02-04_22-19-03.png)
上圖除了顯示指令細節之外，最後提示缺少必要的參數 app-name

建立第一個叫 00_default_app 的專案

```bash
vue create 00_default_app
```

預設選擇 default (babel, eslint)

![](/assets/images/2020-02-08-use-vue-cli-create-vuejs-project/2020-02-08_21-06-20.png)

下一步選擇使用的套件管理工具，依個人喜好而定，這邊選擇 yarn

![](/assets/images/2020-02-08-use-vue-cli-create-vuejs-project/2020-02-08_21-07-01.png)

等待專案產生完畢，依照提示啟動

```bash
cd 00_default_app
yarn serve
```

接者開啟 http://localhost:8080/ 就可以看到網頁了

![](/assets/images/2020-02-08-use-vue-cli-create-vuejs-project/2020-02-08_21-16-49.png)
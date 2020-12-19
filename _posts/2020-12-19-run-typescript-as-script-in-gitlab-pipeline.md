---
title: "在 GitLab Piepeline 使用 TypeScript 當 script 使用"
tags: w3HexSchool GitLab TypeScript
---

## 問題

本來在 GitLab Piepeline 主要使用 bash 寫 script，
簡單的還好處理，稍微複雜一點的邏輯，可讀性跟維護性都不高。
加上目前開發主要使用 TypeScript，所以就興起把 TypeScript 當 script 使用，取代 bash 的想法。

## 結果

![](/assets/images/2020-12-19/2020-12-19-222427.png)

## GitLab Pipleline YAML 示範

使用 node.js image，不然要先安裝 node.js 相關的套件

```yml
image: node:12.16.1

stages:
  - run-script

run-script:
  stage: run-script
  before_script:
    - yarn global add typescript
    - yarn global add ts-node
    - yarn
  script:
    - ts-node helloworld.ts
```

## 說明

想要把 typescript 當 script，要安裝 typescript 及 ts-node
為了避免影響 local project 的 package.json，所以使用 global 安裝
為了區隔，在 yml 使用 `before_script`

### 前置準備

```yml
before_script:
  - yarn global add typescript
  - yarn global add ts-node
```

### 執行

```yml
script:
  - ts-node helloworld.ts
```

## 其它套件

如果要使用 fs 之類 node.js 的函式庫，需要安裝 `@types/node`，所以需要 `package.json`

```json
{
  "dependencies": {
    "@types/node": "^14.11.1"
  }
}
```

似乎因為 ts 會去找 `tsconfig.json` 檔案，所以同層給一個檔案才不會跑掉
可以透過 `tsc --init` 產生檔案

## 檔案夾隔離

因為本身已經是 TypeScript 專案，所以相關的 script 放在獨立資料夾 `ci` 下。

## 完整版的 YAML

```yml
image: node:12.16.1

stages:
  - run-script

run-script:
  stage: run-script
  before_script:
    - yarn global add typescript
    - yarn global add ts-node
    - cd ci
    - yarn
    - cd ..
  script:
    - cd ci
    - ts-node main.ts
    - cd ..
```

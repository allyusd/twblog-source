---
title: "減少 Node.Js Docker image 容量大小"
tags: w3HexSchool Docker Dockerfile
---

## 改用 alpine 系列 image

第一點可以修改的是 base image 改用 alpine，這點很多地方都有提到，不多說。

## yarn install --production

`--production` 參數表示只安裝 package.json 裡面 dependencies 的套件，
不安裝 devDependencies 的套件，devDependencies 表示開發才需要的套件。

ps 1：在 CI 安裝後，通常會加上 `--frozen-lockfile` 讓 yarn 完全依照 `yarn.lock` 安裝
確保 CI 跟開發環境一致，完整指令：`yarn install --production --frozen-lockfile`

ps 2：`yarn add` 指令會讓所有套件都安裝，包含 devDependencies，
不要在 CI 過程中使用 `yarn add` 指令，會破壞這個原則。

## yarn cache clean

yarn 為了加速套件安裝，會在本地暫存一份 cache，但是在 image 不需要這個，
原理跟 `apt install` 一樣，在安裝套件後清除本地快取，
完整指令：`yarn install --production --frozen-lockfile && yarn cache clean`

## 完整 Dockerfile

以 Actionhero 為範例

```Dockerfile
FROM node:12.19.1-alpine

WORKDIR /app

# 需要 packagejson 跟 yarn.lock 提供版本資訊
COPY package.json yarn.lock ./

# --production 不安裝 dev 相關套件
# --frozen-lockfile 強制安裝 yarn.lock 套件
# NOYARNPOSTINSTALL=1 跳過 postinstall
RUN NOYARNPOSTINSTALL=1 yarn --production --frozen-lockfile && yarn cache clean

# actionhero 會在這個目錄建立 websocker js file
RUN mkdir -p public/javascript/

# backend
COPY dist dist

# frontend
COPY public public

EXPOSE 8080
CMD [ "node", "dist/server.js" ]
```

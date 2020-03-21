---
title: "在 Windows 透過 nvm 安裝 Node.js"
tags: w3HexSchool Node.js nvm Windows
---

nvm 是 Node Version Manager，用來管理各種不同的 Node.js 版本的工具，
當各種專案需要使用不同版本的 Node.js 時，透過 nvm 可以快速切換版本

## 安裝 nvm
[coreybutler/nvm-windows: A node.js version management utility for Windows. Ironically written in Go.](https://github.com/coreybutler/nvm-windows)

到 Release 頁面，下載 ```nvm-setup.zip``` 並安裝

## 安裝 Node.js

```shell
nvm install 12.13.1
```

### 使用指定版本

```shell
nvm use 12.13.1
```

![](/assets/images/2020-03-21/2020-03-09_14-20-05.png)

### 確定 Node.js 版本

```shell
node -v
```

---
title: "使用 VSCode Debug ActionHero (Nodejs) with TypeScript"
tags: w3HexSchool ActionHero Nodejs Debug TypeScript
---

2020-04-26 Update

發現不明原因導致本文方法失效，新的方法已更新在這 [使用 VSCode Debug Actionhero version 22 on windows](https://twblog.hongjianching.com/2020/04/26/actionhero-v22-debug-with-vscode-on-windows/)

2020-03-19 第一次參加 [Actionhero](https://www.actionherojs.com/) 的 Office Hours，詢問了如何使用 VSCode Debug ActionHero，實際上也是 Node.js with TypeScript 專案如何使用 VSCode Debug 的使用方案。會後 [Evan Tahler](https://www.evantahler.com/) 發了一個 [Pull Request](https://github.com/actionhero/actionhero/pull/1428) 新增了 Debug 相關的變更，同時也更新了[官網的文件](https://www.actionherojs.com/tutorials/repl-and-debugging)。

## VSCode Debug 設定

因為原始碼會先建置後才執行，所以想要使用原始碼直接 Debug，就要靠 sourceMap 告訴 VSCode 對應執行中的程式碼及原始碼的關係，所以先確認專案中 TypeScript 的設定是否有開啟 sourceMap。

`tsconfig.json`

```json
"sourceMap": true
```

另外在執行指令中加上`--inspect`參數，以 ActionHero 為例，dev 是原本的指令，debug 是新增的指令。

`package.json`

```json
"dev": "ts-node-dev --no-deps --transpile-only ./src/server",
"debug": "ts-node-dev --transpile-only --no-deps --inspect -- ./src/server ",
```

因為在設定中開啟了 sourceMap，所以修改 build 指令關閉 sourceMap。

`package.json`

```json
"build": "rm -rf dist && ./node_modules/.bin/tsc --sourceMap false --declaration",
```

最後新增一個 VSCode 的 Debug launch 設定

`.vscode/launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Actionhero Debugger",
      "protocol": "inspector",
      "port": 9229,
      "restart": true,
      "localRoot": "${workspaceFolder}",
      "remoteRoot": "."
    }
  ]
}
```

接著只要在第一次啟動 VSCode 時，先執行 VSCode 的 Actionhero Debugger，再執行 debug 指令，像是

```shell
npm run debug

or

yarn debug
```

就可以使用 VSCode 進行 Debug 了，而且因為有設定 `"restart": true` 參數，就算結束程式，只要再次啟動，就會自動進入偵錯模式喔。

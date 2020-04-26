---
title: "使用 VSCode Debug Actionhero version 22 on windows"
tags: w3HexSchool ActionHero Debug
---

在之前[使用 VSCode Debug ActionHero (Nodejs) with TypeScript](https://twblog.hongjianching.com/2020/03/28/actionhero-nodejs-debug-with-typescript-on-vscode/)文章中討論過如何使用 VSCode 對 Actionhero 專案進行 Debug，但是後來發現原本的方法失效了。

在 04-23 的 Office Hours 中，[Evan Tahler](https://github.com/evantahler) 及 [Greg Coonrod](https://github.com/gcoonrod) 提供了新的設定，相關的變更在 [better debugging support by evantahler · Pull Request #1439 · actionhero/actionhero](https://github.com/actionhero/actionhero/pull/1439) 之中。

會後，尤於環境不同(我想兩位作者都是使用 Mac 開發環境)，我在 Windows 使用新的設定時，遇到了一些問題，經過反覆嘗試，成功的使用 VSCode 進行 Debug。

其中是針對 `package.json` 的 debug script 改為 node，而非使用 ts-node-dev，原因不明，但我使用原本 script 的 ts-node-dev 版本，會發生 breakpoint 跳動的情況，似乎是 sourcemap 無法正確對應。
```json
"debug": "tsc && node --inspect -- ./dist/server",
```

另一個是針對 `launch.json` 的 remoteRoot 路徑改為跟 localRoot 一樣，完整的設定如下

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Actionhero Debugger (attach)",
      "protocol": "inspector",
      "port": 9229,
      "restart": true,
      "localRoot": "${workspaceFolder}",
      "outFiles": ["${workspaceRoot}/dist/**/*.js"],
      "sourceMaps": true,
      "remoteRoot": "${workspaceFolder}",
    },
  ]
}
```

至於 Actionhero Debugger (launch) 則因為我在 Windows 下使用 bash 當指令操作介面，所以遇到了路徑問題，所以就忽略這個方式了，我期待等到 Windows 2004 版本 Release 之後，改用 WSL 2 當開發環境的時候，就能解決相關的問題。
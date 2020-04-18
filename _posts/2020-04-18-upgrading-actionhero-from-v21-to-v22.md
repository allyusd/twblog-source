更新 Actionhero 版本從 v21 到 v22
===

一開始使用 Actionhero 的時候是 21 版，升級到 22 版的時候有一些變化，Actionhero 這次更新異動比較大的原因是，修改了啟動的機制, 接下來說明應該如何調整

## 必要的修改

更新 actionhero 到最新版， 並且新增兩個套件到開發依賴

```bash
yarn upgrade actionhero@^22.0.7
yarn add @types/ioredis --dev
yarn add ts-node-dev --dev
```
刪除 `/boot.js` 檔案

新增 `/src/server.ts`
```ts
#!/usr/bin/env node
import { Process } from "actionhero";

// load any custom code, configure the env, as needed

async function main() {
  // create a new actionhero process
  const app = new Process();

  // handle unix signals and uncaught exceptions & rejections
  app.registerProcessSignals((exitCode) => {
    process.exit(exitCode);
  });

  // start the app!
  // you can pass custom configuration to the process as needed
  await app.start();
}

main();
```

接著更新 `package.json` 關於 scripts 的部份
```json
"scripts": {
  "postinstall": "npm run build",
  "dev": "ts-node-dev --no-deps --transpile-only ./src/server.ts",
  "debug": "ts-node-dev --transpile-only --inspect -- ./src/server.ts",
  "start": "node ./dist/server.js",
  "test": "jest",
  "pretest": "npm run build && npm run lint",
  "build": "tsc --declaration",
  "lint": "prettier --check src/*/** __test__/*/**",
  "pretty": "prettier --write src/*/** __test__/*/**",
},
```

## 非必要的調整

這邊的目的是讓舊專案更接近新版專案

```shell
yarn remove ts-node
yarn add ws
```

更新 `package.json`，將版本都改為 `latest`

```json
  "dependencies": {
    "actionhero": "22.0.7",
    "ws": "latest",
    "ioredis": "latest",
    "winston": "latest"
  },
  "devDependencies": {
    "@types/node": "latest",
    "@types/jest": "latest",
    "jest": "latest",
    "prettier": "latest",
    "ts-jest": "latest",
    "ts-node-dev": "latest",
    "typescript": "latest"
  },
```

## Ref
[Upgrading from v21 to v22 - Actionhero](https://www.actionherojs.com/tutorials/upgrade-path#Upgrading%20from%20v21%20to%20v22)

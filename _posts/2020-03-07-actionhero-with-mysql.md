---
title: "ActionHero 使用 MySQL"
tags: w3HexSchool ActionHero MySQL
---

## 失敗的嘗試

上週試了一下網路找到的 config

[Actionhero + MySQL](https://gist.github.com/evantahler/801a07085f230fa7f55d)

但是失敗了，後來從作者的 github 找到 plugin

[actionhero/ah-sequelize-plugin: sequelize plugin for actionhero](https://github.com/actionhero/ah-sequelize-plugin)

## 安裝 Plugin

ah-sequelize-plugin 整合了 [Sequelize ORM](https://sequelize.org/) 及 actionhero，首先要安裝相關的 package，sequelize 支援多種資料庫，這裡使用 MySQL

```bash
npm install ah-sequelize-plugin --save
npm install sequelize sequelize-typescript --save
npm install @types/bluebird @types/validator reflect-metadata --save
npm install mysql2 --save
```

## 設定

修改專案中的 ```./src/config/plugins.ts```

```ts
import * as path from "path";

export const DEFAULT = {
  plugins: config => {
    return {
      "ah-sequelize-plugin": {
        path: path.join(process.cwd(), "node_modules", "ah-sequelize-plugin")
      }
    };
  }
};
```

增加 ```experimentalDecorators``` and ```emitDecoratorMetadata``` 到專案 ```tsconfig.json```
```json
{
  "compilerOptions": {
    "outDir": "./dist",
    "allowJs": true,
    "module": "commonjs",
    "target": "es2018",
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
  },
  "include": ["./src/**/*"]
}
```

新增檔案到專案中 ```./src/config/sequelize.js```
記得在 mysql 要建立 actionhero 資料庫

```js
const { URL } = require('url')
const path = require('path')

const DEFAULT = {
  sequelize: config => {
    let dialect = "postgres";
    let host = "127.0.0.1";
    let port = "5432";
    let database = "actionhero";
    let username = undefined;
    let password = undefined;

    // if your environment provides database information via a single JDBC-style URL like mysql://username:password@hostname:port/default_schema
    if (process.env.DATABASE_URL) {
      const parsed = new URL(process.env.DATABASE_URL);
      if (parsed.username) {
        username = parsed.username;
      }
      if (parsed.password) {
        password = parsed.password;
      }
      if (parsed.hostname) {
        host = parsed.hostname;
      }
      if (parsed.port) {
        port = parsed.port;
      }
      if (parsed.pathname) {
        database = parsed.pathname.substring(1);
      }
    }

    return {
      autoMigrate: true,
      logging: false,
      dialect: dialect,
      port: parseInt(port),
      database: database,
      host: host,
      username: username,
      password: password,
      models: [path.join(__dirname, "..", "models")],
      migrations: [path.join(__dirname, "..", "migrations")]
    };
  }
};

module.exports.DEFAULT = DEFAULT;

// for the sequelize CLI tool
module.exports.development = DEFAULT.sequelize({
  env: "development",
  process: { env: "development" }
});

module.exports.staging = DEFAULT.sequelize({
  env: "staging",
  process: { env: "staging" }
});

module.exports.production = DEFAULT.sequelize({
  env: "production",
  process: { env: "production" }
});
```

最後在專案新增資料夾 ```./src/migrations/```

到此完成 ActionHero 操作 MySQL 的設定

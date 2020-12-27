---
title: "Sequelize migrations typescript 版本"
tags: w3HexSchool Sequelize Migrations TypeScript
---

Sequelize 官方是使用 JavaScript，[Migrations](https://sequelize.org/master/manual/migrations.html) 也是使用 js，
這篇介紹 TypeScript 版本的 Sequelize Migrations，
透過 [actionhero/ah-sequelize-plugin](https://github.com/actionhero/ah-sequelize-plugin) 使用，有可能跟原生 Sequelize 有差異。

## Migrations with typescript

基本的範例，使用 QueryInterface 型別加上 DataTypes 定義，支援 async / await。

```ts
import { QueryInterface, DataTypes } from "sequelize";

const tableName = "customer";
const columnName = "email";

module.exports = {
  up: async (queryInterface: QueryInterface) => {
    await queryInterface.addColumn(tableName, columnName, {
      allowNull: false,
      type: DataTypes.STRING,
    });
  },

  down: async (queryInterface: QueryInterface) => {
    return queryInterface.removeColumn(tableName, columnName);
  },
};

```

### Raw query

在 migrations 也可以使用 Raw query，透過 QueryInterface 取得 sequelize 即可。

```ts
import { QueryInterface, DataTypes } from "sequelize";

module.exports = {
  up: async (queryInterface: QueryInterface) => {

    const sql = `
UPDATE customer
  SET email="abc@test.com"
  WHERE customer_id=1;
`;

    queryInterface.sequelize.query(sql);
  },

  ...
};
```

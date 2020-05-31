---
title: "Sequelize 進行 Raw Query 遇到 SQL Injection 問題"
tags: w3HexSchool Sequelize SQL-Injection
---

Sequelize 除了使用 Model Query 之外，還可以透過 SQL 語法直接進行 Raw Query，但是會碰上 SQL Injection 問題

## Model Query

這是使用 Model Query 方法的範例

```ts
// Model Query
private async way1(account: string) {
  let logs: ShoppingLog = await ShoppingLog.findOne<ShoppingLog>({
    where: {
      account: account,
      source: 'TW',
      price: {
        [Op.gt]: 100
      },
    },
    order: [
      ['createTime', 'DESC']
    ]
  });

  return logs;
}
```

## Raw Queries - SQL Injection

這是直接使用 SQL 語法進行查詢，但是會造成 SQL Injection 的範例

```ts
private async way2(account: string) {
  const sequelize: Sequelize = api.sequelize;
  const sql = `
select * from ShoppingLog sl
  where account = ${account}
  and source = 'TW'
  and price > 100
  order by createTime desc
  limit 1
`;

  const logs: ShoppingLog[] = await sequelize.query<ShoppingLog>(sql, {
    model: ShoppingLog,
    mapToModel: true // pass true here if you have any mapped fields
  });

  if (logs.length > 0) {
    return logs[0];
  }

  return null;
}
```

## Raw Queries

這是把參數安全替換，解決 SQL Injection 的範例

```ts
private async way3(account: string) {
  const sequelize: Sequelize = api.sequelize;
  const sql = `
select * from ShoppingLog sl
  where account = :account
  and source = 'TW'
  and price > 100
  order by createTime desc
  limit 1
`;

  const replacements = {
    account: account
  }

  const logs: ShoppingLog[] = await sequelize.query<ShoppingLog>(sql, {
    model: ShoppingLog,
    replacements: replacements,
    mapToModel: true // pass true here if you have any mapped fields
  });

  if (logs.length > 0) {
    return logs[0];
  }

  return null;
}
```

### Ref

[Manual | Sequelize](https://sequelize.org/master/manual/raw-queries.html)

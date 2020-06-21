---
title: "Actionhero 在 action 的 inputs 使用系統保留字"
tags: w3HexSchool ActionHero
---

## 問題

Actionhero 中每個 action 都可以透過定義 inputs，當 action 呼叫時的傳入參考，
但是當使用到 Actionhero 本身的保留字時，就會發生不明的錯誤。

## 問題範例

像是在 inputs 中定義了 `action`、`apiVersion` 的話。

```ts
this.inputs = {
  apiVersion: {
    required: true,
  },
};
```

完整範例請點 [這裡](https://github.com/allyusd/actionhero-action-inputs-using-reserved-params/blob/master/src/actions/usingReservedParams.ts)

呼叫 action 的時候，會一直得到錯誤 `"error": "unknown action or invalid apiVersion"`

## 修改原始碼

在跟作者討論後，試著在 `classes/action.ts` 的 `validate()` 加上驗證，
所有 action 的 inputs 不能包含 `initializers/params.ts` 定義的 `api.params.globalSafeParams`。

但是發現 `validate()` 是在 `initializers/actions.ts` 中呼叫的，而且 `loadPriority` 高於 params，
試著調整 priority 後才發現，原來 params 中有使用到 `api.actions`，這下 deadlock……

### Ref

[actionhero/action.ts at master · actionhero/actionhero](https://github.com/actionhero/actionhero/blob/master/src/classes/action.ts#L77-L95)
[actionhero/params.ts at master · actionhero/actionhero](https://github.com/actionhero/actionhero/blob/master/src/initializers/params.ts#L25-L31)

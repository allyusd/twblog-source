---
title: "ActionHero 新增 action"
tags: w3HexSchool ActionHero
---

在 `src/actions` 新增 `sum.ts`，實作一個合計的 action

這個 action 輸入 a, b 參數，回傳 sum 表示 a + b

## 成果

### 程式碼

```ts
import { Action } from "actionhero"

export class SumAction extends Action {
  constructor() {
    super();
    this.name = "sum";
    this.description = "return sum of a and b"
    this.outputExample = { sum: 3 }
    this.inputs = {
      a: {
        required: true
      },
      b: {
        required: true
      }
    }
  }

  async run({ params, response }) {
    let sum: number = 0;
    sum = Number.parseInt(params.a) + Number.parseInt(params.b);
    
    response.sum = sum;
    return response;
  }
}
```

### 使用

在網址列輸入 `http://localhost:8081/api/sum?a=100&b=23`，回傳結果

```json
{
  "sum": 123,
  "serverInformation": {
    "serverName": "my_actionhero_project",
    "apiVersion": "0.1.0",
    "requestDuration": 2,
    "currentTime": 1585985448163
  },
  "requesterInformation": {
    "id": "15065e43d00dbe702ef96bfed4dc6d884367f0ab-f351e412-d6ea-48f4-b5ef-46edb155fe13",
    "fingerprint": "15065e43d00dbe702ef96bfed4dc6d884367f0ab",
    "messageId": "f351e412-d6ea-48f4-b5ef-46edb155fe13",
    "remoteIP": "127.0.0.1",
    "receivedParams": {
      "a": "100",
      "b": "23",
      "action": "sum"
    }
  }
}
```

第一行 `sum` 即為實作回傳結果

## 說明

首先從 actionhere import `Action` class

接著擴展宣告實作的 `SumAction`

### construction()

在 建構式 `constructor` 先呼叫 `super()` 執行 `Action` 的建構式

接著設定 action 相關的參數

name: 表示 action 的名稱外，同時代表 api 名稱

description: 描述 action 的用途，給人類閱讀用的

outputExample: 描述 action 的回傳參數的範例，也是給人類看的

inputs: 表示 action 的輸入參數，沒有宣告的參數會被忽略，可以透過`required`宣告參數為必需，如果缺少會直接拒絕執行 action

### run()

當 api 呼叫後，會觸發 `run()` 函數進行處理，常用參數

params: 會帶入輸入參數

response: 會回傳輸出參數

connection: 使用者相關資訊

這個範例中，從 `params` 取得輸入參數 `a`, `b` 轉換為 number 後相加，存到 `sum` 之後透過 `response` 回傳


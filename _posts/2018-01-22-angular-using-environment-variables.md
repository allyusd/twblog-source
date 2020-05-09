---
title: "Angular 使用環境變數"
tags: Angular
---

Angular 專案中，如果有依環境不同而需要不同的設定時，像是 apiUrl，該如何處理？

## 開發環境及生產環境

使用 [Angular CLI](https://github.com/angular/angular-cli) 建立的專案預設會有兩個環境設定，一個是開發環境，另一個是生產環境，分別由 **environment.ts** 及 **environment.prod.ts** 兩個檔案所描述。

常用的指令，像是 ng serve 時，預設使用開發環境；使用 ng build --prod 時，則會使用生產環境。

## 新增及使用環境變數

使 apiUrl 為例，設定兩個檔案

environment.ts:

```ts
export const environment = {
  production: false,
  apiUrl: "http://localhost/api/",
};
```

environment.prod.ts:

```ts
export const environment = {
  production: true,
  apiUrl: "http://demo.com/api/",
};
```

然後編輯 foo.service.ts

```ts
import { environment } from '../../environments/environment';
‧‧‧
private baseUrl : string = environment.apiUrl + 'foo';
‧‧‧
```

在開發環境時，baseUrl 是 'http://localhost/api/foo'

在生產環境時，baseUrl 是 'http://demo.com/api/foo'

這樣就可以達到開發跟生產環境使用不同的設定。

## Reference

[Angular 2 and environment variables](https://medium.com/beautiful-angular/angular-2-and-environment-variables-59c57ba643be)

[Environment Variables in Angular](https://alligator.io/angular/environment-variables/)

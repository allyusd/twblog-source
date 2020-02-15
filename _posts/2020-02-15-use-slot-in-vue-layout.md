---
title: "在 Vue 專案使用 Slot 進行 Layout"
tags: w3HexSchool Vue.js Slot
---

## 常見的 Layout 排版範例

這是常見的左中右的排版

![](/assets/images/2020-02-15-use-slot-in-vue-layout/2020-02-15_11-43-27.png)

其中的 template 如下

```html
<template>
    <div class="outside-box">
        <div class="box">
            <div class="item left">left</div>            
            <div class="item center">center</div>
            <div class="item right">right</div>
        </div>
    </div>
</template>
```

其中同時包含了排版 (Layout) 及內容 (Content)，如果要減少重覆的工作，我們可以將其中內容的部份抽離，留下單純的排版。

## 使用 Slot

透過 Vue 的 Slot 機制，將會變動的內容改用 slot 取代，建立 Layout.vue
因為我們需要用到多個 slot，需要分別加上 name 用來代表不用的位置

> Layout.vue

```html
<template>
    <div class="box">
        <slot name="left"></slot>
        <slot name="center"></slot>
        <slot name="right"></slot>
    </div>
</template>
```

接著將原本的 template 套上 Layout.vue
```html
<template>
  <div class="outside-box">
    <Layout>
      <template v-slot:left>
        <div class="item left">left</div>            
      </template>
      <template v-slot:center>
        <div class="item center">center</div>
      </template>
      <template v-slot:right>
        <div class="item right">right</div>
      </template>
    </Layout>
  </div>
</template>
```

執行結果會跟原本的一樣喔！但是擁有一個 Layout.vue 可以重覆使用排版。

關於更多 Slot 資料可以參考官方文件 [Slots — Vue.js](https://vuejs.org/v2/guide/components-slots.html#Named-Slots-with-the-slot-Attribute)
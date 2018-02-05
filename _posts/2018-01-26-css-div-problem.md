---
title: "CSS DIV 問題"
tags: CSS
---

這是我遇到的問題，當右邊 div 比左邊高度還少的時候，會從下方往上堆疊。

![](/assets/images/2018-01-26-css-div-problem/002.png)

這是 html 的部份

```html
<div class="row">
  <div class="column">
    <div class="block1"></div>
    <div class="block1 highlight"></div>
    <div class="block1"></div>
  </div>
  <div class="column">
    <div class="block2"></div>
    <div class="block2 highlight"></div>
    <div class="block2"></div>
  </div>
</div>
```

這是 css 的部份

```css
.row {
  display: table;
  width: 100%;
  table-layout: fixed;
  border-spacing: 1px;
}
.column {
  display: table-cell;
  background-color: #666666;
}
.block1 {
  height: 50px;
  color: black;
  background-color: rgb(0, 153, 0);
}
.block2 {
  height: 20px;
  color: black;
  background-color: rgb(0, 153, 0);
}
.highlight {
  background-color: rgb(255, 153, 0);
}
```

中間試了幾種改法都不太滿意，後來發現這個例子滿足我希望達到的效果，當右邊 div 比左邊高度還少的時候，會從上而下依序顯示。跟原本的差異只有 div 中間有 a1, a2, a3, b1, b2, b3 文字。

![](/assets/images/2018-01-26-css-div-problem/001.png)

經過幾次的測試之後，發現如果 div 中間有文字會從上而下顯示，如果沒有文字，會從下而上堆疊。

最後的解決方案是放上全型空白。

```html
<div class="row">
  <div class="column">
    <div class="block1">　</div>
    <div class="block1 highlight">　</div>
    <div class="block1">　</div>
  </div>
  <div class="column">
    <div class="block2">　</div>
    <div class="block2 highlight">　</div>
    <div class="block2">　</div>
  </div>
</div>
```

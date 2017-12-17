---
title: "修改 Minimal Mistakes Jekyll Theme 網站字型大小"
tags: Jekyll Minimal-Mistakes
---

覺得 Minimal Mistakes 預設的字型大小實在是太大了，對於 Blog 來說很不習慣，幸好可以透過修改 sass 檔來調整全站設定，雖然作者不建議直接修改他。[^1]

原本的 _reset.scss 片段

```scss
html {
  /* apply a natural box layout model to all elements */
  box-sizing: border-box;
  background-color: $background-color;
  font-size: 16px;

  @include breakpoint($medium) {
    font-size: 18px;
  }

  @include breakpoint($large) {
    font-size: 20px;
  }

  @include breakpoint($x-large) {
    font-size: 22px;
  }

  -webkit-text-size-adjust: 100%;
  -ms-text-size-adjust: 100%;
}
```

修改為

```sass
html {
  /* apply a natural box layout model to all elements */
  box-sizing: border-box;
  background-color: $background-color;
  font-size: 16px;

  -webkit-text-size-adjust: 100%;
  -ms-text-size-adjust: 100%;
}
```

[^1]:[Upgrade-friendly way of adjusting font sizes globally](https://github.com/mmistakes/minimal-mistakes/issues/1219)
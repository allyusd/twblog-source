---
title: "Visual Studio Precompiled Headers setting issues"
tags: Visual-Studio
---

## Precompiled Headers
最近發現專案使用的 Precompiled Headers 設定錯誤，增加了 94% 的建置時間。

以下是錯誤的專案設定
![](/assets/images/2018-09-12-visual-studio-precompiled-headers-setting-issues/2018-09-12_20-24-11.png)

在專案中的 Precompiled Headers 設定選項雖然有三個，分別是
* Create(/Yc)
* Use(/Yu)
* Not Using Precompiled Headers

但其實真正能選的只有兩種，就是 Create(/Yc) 不能選，因為這是給檔案設定的。
如果這個專案要啟用 Precompiled Headers 就選 Use(/Yu)，
不啟用就選 Not Using Precompiled Headers。

因為這個專案要啟用，所以改為  Use(/Yu)
![](/assets/images/2018-09-12-visual-studio-precompiled-headers-setting-issues/2018-09-12_20-25-12.png)

就是這個小小的設定，原本要編譯 100 秒的專案，只需要 5.8 秒，足足降低了 94% 的建置時間。

## Multi-processor Compilation
因為目前的電腦都有多核的設計，再啟用多核心編譯功能，設定 Multi-processor Compilation 為 Yes (/MP)
![](/assets/images/2018-09-12-visual-studio-precompiled-headers-setting-issues/2018-09-12_20-32-50.png)

啟用後建置時間只需要 3.5 秒，再節省 60% 的建置時間。

## 結論
正確設定 Precompiled Headers 加上 Multi-processor Compilation，從原本的 100 秒 縮短為 3.5 秒，等於加速了 28 倍，可以大幅減少等待時間。
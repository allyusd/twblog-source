---
title: "Wget 下載檔案遇到網頁亂碼問題"
tags: Command-Line-Tools Wget
---

今天在 FB 看到這個問題，試著解決後紀錄下來。

原指令

```bash
wget -c -r -np -k -L -p http://yabit.et.nthu.edu.tw/2016storyland/document/report/
```

不知道該網站的設定為何，雖然網頁是 UTF-8 編碼，但是 wget 或 Chrome 自動偵測的結果卻不是，
造成解析錯誤，上網查詢是否可以 wget 是否可以指定編碼，結果可以，加上 --remote-encoding=utf-8 參數，
這樣問題只解決一半，因為 wget 下載 UTF-8 檔名時會解析錯誤，還要加上 --restrict-file-names=nocontrol 參數。[^1]

修正後

```
wget -c -r -np -k -L -p http://yabit.et.nthu.edu.tw/2016storyland/document/report/ --remote-encoding=utf-8 --restrict-file-names=nocontrol
```

[^1]:[Stack Overflow - wget and special characters](https://stackoverflow.com/questions/11350310/wget-and-special-characters)

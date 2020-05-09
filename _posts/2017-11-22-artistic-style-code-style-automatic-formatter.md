---
title: "Artistic Style 3.0 - 程式風格自動格式化工具"
tags: Cpp Coding-Style Automatic-Formatter
---

一個免費、快速、小型的自動源始碼格式化工具，支援 C/C++、C++/CLI、Objective-C、C# 和 Jave。

這是官方網站，包含下載連結。
[Artistic Style 3.0 - WebSite](http://astyle.sourceforge.net/)

官方的文件有詳細的說明，有興趣的可以深入研究。
[Artistic Style 3.0 - Documentation](http://astyle.sourceforge.net/astyle.html)

以下範例皆為個人喜好

## 基本用法

```
--style=allman
```

大括號都在新的一行

```
--exclue=####
```

排除特定檔案或目標

```
--ignore-exclude-errors-x / -xi
```

忽略且不顯示被排除的項目

```
--suffix=none / -n
```

不保留原始檔的備份

```
--recursive / -r / -R
```

遞歸處理所有子目錄

```
--quiet / -q
```

不會有任何的訊息

將上面的選項組合起來，對這一層開始包含所有子目錄的 .cpp 及 .h 檔案進行格式化，但是排除 depend 目錄，範例：

```bash
astyle --style=allman --exclude=depend --ignore-exclude-errors-x --suffix=none --recursive --quiet *.cpp *.h
```

太長了，改用短指令

```bash
astyle --style=allman --exclude=depend -A1xinrq *.cpp *.h
```

## 風格設定

```
--style=allman / --style=bsd / --style=break / -A1
```

大括號都在新的一行

```
--indent-switches / -S
```

switch 內縮排

```
--indent-namespaces / -N
```

namespaces 內縮排

```
--indent-after-parens / -xU
```

多行的參數縮排

```
--indent-preproc-block / -xW
```

預處理器內縮排，像是 #ifdef ... #endif 之間

```
--indent-col1-comments / -Y
```

註解跟著程式碼一起縮排

```
--pad-oper / -p
```

操作符號前後空白，像是 1+1 會變成 1 + 1

```
--pad-header / -H
```

在 if, while, for 之後加上空白

```
--align-pointer=type   / -k1
```

將指標或參考符號靠近型別，像是 string& my_name;

```
--add-braces / -j
```

只有一行的 if 也加上大括號

```
--close-templates / -xy
```

消除連續模板間的空白

```
--mode=c
```

指定為 C, C++, C++/CLI, and Objective-C 程式語言

```
--delete-empty-lines / -xe
```

本來想用結果發現他會砍過頭，先不使用

```
--max-code-length=#   / -xC#
--break-after-logical / -xL
```

每行字元上限，目前覺得不需要處理

```
--indent=tab / --indent=tab=# / -t / -t#
```

取代 tab 為空白字元，跟 IDE 預設值衝突，先不使用

長指令範示：

```
astyle --style=allman --indent=tab --indent-switches --indent-namespaces --indent-after-parens --indent-preproc-block --indent-col1-comments --pad-oper --pad-header --align-pointer=type --add-braces --close-templates --mode=c --exclude=depend -xinrq *.cpp *.h
```

短指令範例：

```
astyle -A1SNxUxWYpHk1jxy --mode=c --exclude=depend -xinrq *.cpp *.h
```

## Reference

[Best C++ Code Formatter/Beautifier](https://stackoverflow.com/questions/841075/best-c-code-formatter-beautifier)

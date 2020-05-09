---
title: "Qt Unit Test with Visual Studio"
tags: Qt Unit-Test Visual-Studio
---

基於現成的 Visual Studio 套件 [Google Test Adapter](https://marketplace.visualstudio.com/items?itemName=ChristianSoltenborn.GoogleTestAdapter)，直接借用 [Google Test](https://github.com/google/googletest) 來進行 Qt Unit Test。

有機會再來整合 Qt 自己的 [Qt Test](http://doc.qt.io/qt-5/qttest-index.html)

[Example Code](https://github.com/allyusd/qt-vs-unit-test)

## 建立 VS Google Test 專案

![](/assets/images/2018-07-28-qt-unit-test-with-visual-studio/2018-07-28_16-41-53.png)

建立後會有一個一定會通過的 Unit Test

```cpp
TEST(TestCaseName, TestName) {
  EXPECT_EQ(1, 1);
  EXPECT_TRUE(true);
}
```

Run Test

![](/assets/images/2018-07-28-qt-unit-test-with-visual-studio/2018-07-28_17-26-18.png)

## 編寫 Unit Test

修改 Unit Test 如下

```cpp
TEST(TestLogic, HelloMessage)
{
	Logic logic;

	std::string name = logic.getHelloMessage("Jian-Ching").toStdString();
	EXPECT_EQ("Hello Jian-Ching", name);
}
```

新增 Logic Class 及 getHelloMessage 函式

```cpp
QString Logic::getHelloMessage(QString name)
{
	return "";
}
```

Run Test, 我們會得到一個紅燈

![](/assets/images/2018-07-28-qt-unit-test-with-visual-studio/2018-07-28_20-24-27.png)

## 實作 Qt 程式碼

實作 getHelloMessage 函式

```cpp
QString Logic::getHelloMessage(QString name)
{
	return QString("Hello ").append(name);
}
```

Run Test, 成功通過測試

![](/assets/images/2018-07-28-qt-unit-test-with-visual-studio/2018-07-28_17-51-25.png)

## 其它

如果你的 Goolge Test Apapter 發生錯誤，可以確認一下是否是遇到這個問題，如果問題還未修復，可以先將 Visual Studio 切換為英文語系即可正常使用。

[Google test adapter does not work when the UI of Visual Studio is non english · Issue #121 · Microsoft/TestAdapterForGoogleTest](https://github.com/Microsoft/TestAdapterForGoogleTest/issues/121)

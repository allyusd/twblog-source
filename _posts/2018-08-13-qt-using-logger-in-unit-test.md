---
title: "Qt using Logger in Unit Test"
tags: Qt Unit-Test Visual-Studio
---

先來一張 Test Pass 的結果

![](/assets/images/2018-08-13-qt-using-logger-in-unit-test/2018-08-13_20-07-59.png)

## Legacy Code
開始主題前，先來聊一聊 Legacy Code，

在 [Working Effectively with Legacy Code](https://www.amazon.com/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052) 中，作者對於 Legacy Code 的定義為，沒有測試的程式碼。因為缺乏測試，所以害怕去修改現有的程式碼。久而久之，就越來越不敢修改了，因為你不知道改了之後會弄壞了什麼。

### 高偶合
在實際案例上，往往 Legacy Code 又有各種疊床架屋的情況，常常會牽一髮而動全身。
所以要處理 Legacy Code，基本的動作是加上單元測試 (Unit Test)。

### 缺乏可測試性
要加上單元測試，就不可避免會遇到程式缺乏可測試性的問題，偏偏 Legacy Code 往往欠缺可測試性。

### 重構
想要擁有可測試性，就要將程式改寫，需要進行重構。然而，重構是有風險的，建議先寫測試再開始重構。

### 先有雞？先有蛋？
很好，我們已經陷入了無窮迴圈，可能有人耐不住決定打掉重練了。別急，讓我們回到主題。

## 利用 Logger 協助 Unit Test
存活下來的 Legacy Code 專案，通常埋有不少 Log，就算沒有，補上新的 Log 也是很輕易的，我們可以利用這些 Log 進行 Unit Test。

以 Qt 來說，這是一段產品代碼，範例中很簡單，你可以想像他是一個 1000 行中的某段函式。

```cpp
QString Logic::getHelloMessage(QString name)
{
	auto helloMessage = QString("Hello ").append(name);
		 
	qDebug() << helloMessage.toStdString().data();

	return helloMessage;
}
```

中間有使用 Qt logger 進行輸出，借助於 Qt logging framework 的完善設計，可以直接利用 qInstallMessageHandler 函式進行注入。在其它架構或語言，試著找到 ILog 或是 LogFactory 之類的方法。

下面是 Unit Test 中使用 logger 的方法

```cpp
static QVector<std::string> g_loggerMessages;

void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
	g_loggerMessages.append(msg.toStdString());
}

TEST(TestLogic, HelloMessage)
{
	qInstallMessageHandler(myMessageOutput);

	Logic logic;

	std::string name = logic.getHelloMessage("Jian-Ching").toStdString();
	EXPECT_EQ(true, g_loggerMessages.contains("Hello Jian-Ching"));
}
```

這個技巧可以利用最低的成本，最小的改變為 Legacy Code 補上 Unit Test，接著透過 [Working Effectively with Legacy Code](https://www.amazon.com/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052) 中的技巧，開始拆解程式間的相依性。
---
title: "為什麼 C# 使用不同編碼讀寫檔案卻成功？"
tags: CSharp Encoding
---

## 問題

同樣在 FB 看到這個問題，紀錄下來。這是 C# 程式碼

```csharp
static void Main(string[] args)
{

FileStream s = new FileStream("Bar.txt",FileMode.Create);

StreamWriter w = new StreamWriter(s, System.Text.Encoding.BigEndianUnicode);
w.Write("Hello 我的天");
w.Close();


s = new FileStream("Bar.txt",FileMode.Open);
StreamReader r = new StreamReader(s,System.Text.Encoding.UTF8);
string t;
while((t = r.ReadLine()) != null)
{
Console.WriteLine(t);
}
r.Close();

Console.ReadLine();
}
```

網友提出疑問，為什麼 C# 使用不同編碼讀寫檔案卻成功？
我看了一下，明明使用 BigEndianUnicode 寫檔，使用 UTF8 讀檔，不同的編碼理論上應該會是亂碼才對啊，這真是程式設計師第二常問的問題啊。[^1]

[^1]: 程式設計師第一常問的問題：為什麼這樣錯了？第二常問的問題：為什麼這樣對了？

## 假設 1

首先假設會不會是異名同意，也就是 BigEndianUnicode 是 UTF8 的別名，兩者是相同的東西，那就可以解釋為什麼可以正確顯示。

然而透過 Google 找到的 MSDN 資料表示 BigEndianUnicode 是由大到小的位元組順序 (big endian) 的 UTF-16，也就是 UTF-16 BE。 所以兩者是不同的東西，假設不成立。[^2][^3][^4][^5]

[^2]: [MSDN - Encoding.UTF8 屬性](<https://msdn.microsoft.com/zh-tw/library/system.text.encoding.utf8(v=vs.110).aspx>)
[^3]: [MSDN - Encoding.BigEndianUnicode 屬性](<https://msdn.microsoft.com/zh-tw/library/system.text.encoding.bigendianunicode(v=vs.110).aspx>)
[^4]: [Wiki - UTF-8](https://zh.wikipedia.org/wiki/UTF-8)
[^5]: [Wiki - UTF-16](https://zh.wikipedia.org/wiki/UTF-16)

## 題外話 UTF-8

中間岔題跑去復習，UTF-8 是由 8 位元 (即 1 個位元組) 為最小單位所組成的可變長度編碼，為了相容 ASCII 而設計出來的機制，而且正因為最小單位只有 1 個位元組，所以不像 UTF-16 存在位元組順序 (byte-order) 的問題，實際上不需要加上 BOM。

所以 UTF-16 有分 UTF-16 LE 和 UTF-16 BE，但是 UTF-8 只有一種，就是 UTF-8，回頭想想一開始認為 BigEndianUnicode 是 UTF8 的別名還真是誤會大了。

然而 Windows 作業系統不少程式(像是記事本)，預設會對 UTF-8 檔案加上 BOM，而 Linux 則避免妨礙到像是解譯器腳本而不加 BOM，對於沒有預期要處理 BOM 的 Linux 程式而言，會造成讀取錯誤，這也是跨平台常遇到的事情之一。[^6]

[^6]: [Byte order mark](https://en.wikipedia.org/wiki/Byte_order_mark)

# 假設 2

既然確定是兩者不同的東西，那接著就要懷疑是不是中間有人動了手腳，第一個目標就是 StreamReader，結果在 MSDN 發現了這段註解：

> > StreamReader 物件會嘗試偵測藉由查看前三個位元組資料流的編碼方式。 它會自動識別 utf-8、 由小到大 Unicode 和 big endian Unicode 文字，如果在檔案開頭適當的位元組順序標記。 否則，會使用使用者提供的編碼。[^7]

[^7]: [StreamReader 建構函式 (Stream, Encoding)](<https://msdn.microsoft.com/zh-tw/library/ms143456(v=vs.110).aspx>)

中了！StreamReader 預設會先自動判斷檔案編碼，無法確認才會使用設定的編碼。這在個例子中已經自動判定是 UTF16 BE 編碼，所以傳入的 UTF8 參數無效，也難怪可以正確解讀檔案文字了。

問題到這裡算是解了，但是想說，如果不想要他這麼自動呢？有時候希望能完全控制程式運作，或是自動判斷失靈的情況，該怎麼處理？

馬上找找是否有其它建構函式可以跳過自動判斷，強制使用傳入的編碼，結果真的有，只要在原函式最後加上一個 false 傳入即可。[^8]

[^8]: [StreamReader 建構函式 (Stream, Encoding, Boolean)](<https://msdn.microsoft.com/zh-tw/library/ms143457(v=vs.110).aspx>)

```csharp
StreamReader r = new StreamReader(s,System.Text.Encoding.UTF8, false);
```

這麼一來就會看到亂碼啦！

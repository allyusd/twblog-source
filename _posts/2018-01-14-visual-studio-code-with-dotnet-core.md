---
title: "使用 Visual Studio Code 開發 .Net Core"
tags: Visual-Studio-Code .Net-Core CSharp
---

.Net Core 是跨平台解決方案，同時 Visual Studio Code 也是跨平台開發工具，所以兩者搭配是很好的選擇。

## 安裝 Visual Studio Code 及 .Net Core

首先安裝 [Visual Studio Code](https://code.visualstudio.com/)，當前版本為 1.19.2。

還有安裝 [.NET Core](https://www.microsoft.com/net/)，當前版本為：

.Net Core SDK 2.1.4

.Net Core Runtime 2.0.5

## Hello World 範例

建立一個 **hello_world** 資料夾，開啟 vs-code。

![](/assets/images/2018-01-14-visual-studio-code-with-dotnet-core/001.png)

然後在終端機 ( Ctrl+` ) 使用 **new** 指令建立一個 console 專案。執行後會看到 vs-code 左方檔案總管已經出現專案所需的檔案。

```bash
dotnet new console
```

接著使用 **run** 執行程式，就會看到 **Hello World**。

```bash
dotnet run
```

![](/assets/images/2018-01-14-visual-studio-code-with-dotnet-core/002.png)

[曾經使用的 dotnet restore 不見了？](#dotnet-restore)

## 開發及偵錯

第一個檔案是 **hello_world.csproj**，內容是專案相關設定。

```
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>netcoreapp2.0</TargetFramework>
  </PropertyGroup>

</Project>

```

另一個檔案是 **Program.cs**，是已經寫好的 Hello World 程式碼。

```csharp
using System;

namespace hello_world
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}
```

如果是第一次開啟 C# 相關檔案，vs-code 會建議你安裝 C# 套件，選擇安裝。

![](/assets/images/2018-01-14-visual-studio-code-with-dotnet-core/003.png)

安裝完重啟 vs-code 又會提示你加入偵錯相關設定檔，選擇是。

![](/assets/images/2018-01-14-visual-studio-code-with-dotnet-core/004.png)

接著稍微調整 **Program.cs** 程式碼如下：

```csharp
static void Main(string[] args)
{
    string name = "Jian-Ching";
    string message = "Hello " + name + "!";
    Console.WriteLine(message);
}
```

在 **Console.WriteLine** 下一行設定中斷點 (小紅點)，然後執行 F5，別忘了左邊選擇偵錯可以看到變數資訊，滑鼠移到 **message** 變數也會顯示該變數的值，最下方也有顯示輸出的結果。

![](/assets/images/2018-01-14-visual-studio-code-with-dotnet-core/005.png)

## Console input

如果只能顯示寫好的結果就不好玩了，接著我們讓程式能接受輸入的名字。

首先要調整 vs-code 偵錯相關設定檔 **.vscode/launch.json**，找到 **console** 參數，改為 **integratedTerminal**。[^1]

[^1]:[Configurating launch.json for C# debugging](https://github.com/OmniSharp/omnisharp-vscode/blob/master/debugger-launchjson.md#console-terminal-window)

```
"console": "integratedTerminal",
```

然後修改程式碼：

```csharp
static void Main(string[] args)
{
    Console.WriteLine("What's your name?");
    string name = Console.ReadLine();
    string message = "Hello " + name + "!";
    Console.WriteLine(message);
}
```

再次按下 F5 後，切換到終端機 ( Ctrl+` )

![](/assets/images/2018-01-14-visual-studio-code-with-dotnet-core/006.png)

教學結束，接著可以開始進行其它 C# 的練習嘍！

## dotnet restore

如果你曾經使用過 .Net Core，那可能還紀得這個指令。

```bash
dotnet restore
```

從 .Net Core 2.0 開炲，dotnet restore 已經隱含在所有指令，例如 new, build, run，所以不太需要單獨執行這個指令。

[Microsoft Docs - dotnet restore](https://docs.microsoft.com/zh-tw/dotnet/core/tools/dotnet-restore?tabs=netcore2x)

## Reference

[Using .NET Core in Visual Studio Code](https://code.visualstudio.com/docs/other/dotnet)

[Install the C# extension from the VS Code Marketplace](https://microsoft.com/net/core)

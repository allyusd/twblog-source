---
title: "建立擁有 C++ 編譯環境及 Jenkins Agent 的 Docker Image - Part 1"
tags: 2019-iT-邦幫忙鐵人賽 Cpp Docker Jenkins
---

介紹如何建立一個有 C++ 編譯環境及 Jenkins Agent 的 Docker Image。

在 [使用 Docker 安裝 Jenkins Agent](https://twblog.hongjianching.com/2018/10/10/install-jenkins-agent-with-docker/) 我們已經建立了一個有 Agent 的 Jenkins CI 系統，先建立一個小小的專案，單純確認 Jenkins Agent 是否正常運作。

選擇左方選單的`新增作業`，然後名稱輸入 `test` 並且選擇建置 `Free-Style 軟體專案` 之後按下 OK

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_22-57-50.png)

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_23-11-45.png)

之後會自動進入 test 專案的設定，拉到最下方的`建置`，選擇`新增建置步驟`後按下`執行 Shell`，在指令欄位輸入

```bash
cat /etc/*-release
```

按下儲存後，自動切換到專案主頁，點擊左方`馬上建置`一下，然後點擊左下角`建置歷程`出現的`#1`，再選擇左方的 `Console Output`

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_23-19-09.png)

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_23-20-07.png)

在右邊就會出現在 Agent 上執行的結果

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_23-21-26.png)

看到這個結果，代表我們的 Jenkins 系統正確的運作喔。

接著 [在 Ubuntu 安裝 C++ 編譯環境](https://twblog.hongjianching.com/2018/10/11/install-cpp-compiler-on-ubuntu/) 這篇也已經知道如何編譯 C++ 程式，讓我們試著在 Jenkins 上完成這個件事吧。

照著上面的流程，再新增一個專案，命名為 test_cpp，這次在`原始碼管理`選擇 `Git` 並且輸入 git 網址 `https://github.com/allyusd/helloworld.cpp.git`

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_23-25-37.png)

然後在`執行 Shell`輸入編譯跟執行的動作，

```bash
g++ helloworld.cpp -o helloworld
./helloworld
```

按下儲存後，點選馬上建置，但是，我們得到一個紅燈，代表建置失敗

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_23-29-19.png)

讓我們看一下錯誤訊息

![](/assets/images/2018-11-12-create-cpp-compiler-with-jenkins-agent-docker-image/2018-10-12_23-31-05.png)

錯誤訊息 `g++: not found` 代表我們的 Agent 沒有 C++ 編譯環境，在下一篇我們來解決這個問題
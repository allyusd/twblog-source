---
title: "在 Ubuntu 安裝 Jenkins Agent"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins Ubuntu
---

之前介紹過[使用 Docker 安裝 Jenkins Agent](https://twblog.hongjianching.com/2018/10/10/install-jenkins-agent-with-docker/)，這次要講不使用 Docker 直接在 Ubuntu 安裝 Agent 的方法

在 Jenkins 主頁，選擇**管理 Jenkins** > **管理節點** > **新增節點** >
**節點名稱**輸入 **ubuntu-18.04**，按下 OK

接著在設定頁輸入
* 遠端檔案系統根目錄：**/data/jenkins**
* 啟動模式：**透過 SSH 啟動 Unitx 主機上的 agnet代理程式**
* 主機：輸入 IP
* Credentials：輸入登入主機的 SSH 帳號及密碼
* Host Key Verification Strategy：圖方便跳過驗證，選擇**Non verifying Verification Strategy**

![](/assets/images/2018-10-22-install-jenkins-agent-on-ubuntu/2018-10-22_21-43-37.png)

按下儲存之後可以看到 Agent 啟動 Logs，進去看一下發現失敗

![](/assets/images/2018-10-22-install-jenkins-agent-on-ubuntu/2018-10-22_21-40-20.png)

訊息上看到提示安裝 java 8，我們透過 ssh 登入 Ubuntu 18.04，確認是不是沒有安裝 java

![](/assets/images/2018-10-22-install-jenkins-agent-on-ubuntu/2018-10-22_21-02-00.png)

確實沒有安裝後，接著透過 apt 安裝 java 套件

```bash
sudo apt update && sudo apt install openjdk-8-jre -y
```

![](/assets/images/2018-10-22-install-jenkins-agent-on-ubuntu/2018-10-22_21-36-56.png)

回到 Jenkins Web 再啟動一次，結果又有錯誤發生

![](/assets/images/2018-10-22-install-jenkins-agent-on-ubuntu/2018-10-22_21-52-49.png)

檢查紀錄原來是 **/data/jenkins** 目錄不存在，這個好處理。建立一下目鍵，別忘了設定權限

```bash
sudo mkdir -p /data/jenkins
sudo chown ubuntu:ubuntu /data -R
```

回到頁面再次啟動 Agent

![](/assets/images/2018-10-22-install-jenkins-agent-on-ubuntu/2018-10-22_21-56-01.png)

終於成功完成 Jenkins Agent 連線
---
title: "使用 Docker 安裝 Jenkins Agent"
tags: 2019-iT-邦幫忙鐵人賽 Docker Jenkins
---

讓 Jenkins Master 專心在 CI Server 的任務，剩下的工作交給 Jenkins Agent 處理，這樣可以降低環境的複雜度，也可以增加維護的方便性。

如果還沒有安裝 Jenkins Master 的話可以先參考 [使用 Docker 安裝 Jenkins](https://twblog.hongjianching.com/2018/10/09/install-jenkins-with-docker-on-ubuntu/)

# Jenkins Master 設定

首先在 Jenkins 網頁選擇 *管理 Jenkins*

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-41-38.png)

接著往下找到 *管理節點*，然後點擊 *Master*

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-44-34.png)

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-45-56.png)

這個節點就是 Jenkins Master，也是目前操作網站所在的位置，選擇左方的 *設定*

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-47-13.png)

為了避免有任何的工作在 Master 上面執行，把 *執行程式數* 設為 **0** 然後儲存

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-49-25.png)

我們可以在左下方看到原本的兩個執行程式狀態消失了，接著點左上方的 *節點* 回到管理節點頁面

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-51-31.png)

這次選擇 *新增節點*

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-53-30.png)


輸入節點名稱為 *agent* 並且按下 *Permanent Agent* 之後按下 OK

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-54-33.png)

在新節點的設定頁面，保持預設值不變，直接按下儲存，然後回到管理節點頁面

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-56-11.png)

在管理節點頁面按下剛剛新增的 *agnet*

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-57-36.png)

在 agent 節點會有一行教你怎麼執行 Jenkins agnet 的指令，這邊我們只要拿 secret 後面的參數就好，這個例子是 **1cdcff34b6ddadf38ca3ca42869ae0ad68e62d0274fbad43798b749e3f840884**

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_21-58-37.png)

# Jenkins Agent 安裝

使用 Docker 啟動 Jenkins Agent，需要三個參數，分別是 Jenkins 的網址、剛剛拿到的 secret token 還有 agent 名稱

```bash
docker run \
    --name jenkins_agent \
    -d --restart always \
    jenkins/jnlp-slave \
    -url http://192.168.5.20:8080 \
    1cdcff34b6ddadf38ca3ca42869ae0ad68e62d0274fbad43798b749e3f840884 \
    agent
```

是的，這樣 Jenkins Agent 就完成啟動，回到剛剛的 Agent 頁面按下 F5 重新更新，會發現 Agent 已經上線並且準備工作了。

![](/assets/images/2018-10-10-install-jenkins-agent-with-docker/2018-10-10_22-12-40.png)


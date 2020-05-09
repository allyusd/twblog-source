---
title: "使用 Docker 安裝 Jenkins"
tags: 2019-iT-邦幫忙鐵人賽 Docker Jenkins
---

Jenkins 是 CI 老牌工具，透過新的 Docker 技術，快速建立自己的 CI 環境。

如果還沒有 Docker 執行環境，可以參考 [安裝 Docker](https://twblog.hongjianching.com/2018/10/02/install-docker/)

第一步先在 host 建立存放 Jenkins 的目錄，放在 /data/jenkins

```bash
sudo mkdir -p /data/jenkins
sudo chown -R $USER:$GROUP /data
```

透過 docker 啟動 jenkins

```
docker run \
    --name jenkins \
    -d --restart always \
    -p 8080:8080 -p 50000:50000 \
    -v /data/jenkins:/var/jenkins_home \
    jenkins/jenkins:lts
```

然後可以在 http://localhost:8080 看到 jenkins 準備上工了

![](/assets/images/2018-10-09-install-jenkins-with-docker/2018-10-09_21-19-05.png)

等一段時候之後，jenkins 就會要求輸入預設管理員密碼，畫面上提示 `/var/jenkins_home/secrets/initialAdminPassword`，但是我們有將容器的 `/var/jenkins_home` 對映到 host 的 `/data/jenkins`，所以我們可以在 `/data/jenkins/secrets/initialAdminPassword` 找到預設密碼

```bash
cat /data/jenkins/secrets/initialAdminPassword
```

按下確認後，選擇 install suggested plugins，plugins 可以之後再依需要安裝

![](/assets/images/2018-10-09-install-jenkins-with-docker/2018-10-09_21-31-09.png)

等待 plugin 安裝完成後，建立第一個管理員帳號，接著輸入 Jenkins URL，如果只是測試用可以保持 losthost 沒關係，但是如果要正式使用，記得改為真實 IP 喔。最後可以看到 **Jenkins is ready**。

![](/assets/images/2018-10-09-install-jenkins-with-docker/2018-10-09_21-51-52.png)

按下 _Start using Jenkins_ 之後就會看到 Jenkins 主頁面了

![](/assets/images/2018-10-09-install-jenkins-with-docker/2018-10-09_21-53-11.png)

Jenkins 建置完成嘍！

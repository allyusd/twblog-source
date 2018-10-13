---
title: "建立擁有 C++ 編譯環境及 Jenkins Agent 的 Docker Image - Part 2"
tags: 2019-iT-邦幫忙鐵人賽 Cpp Docker Jenkins
---

前一篇發現預設的 Jenkins Agent 沒有 C++ 編譯環境，所以我們要來解決這個問題。

在 [使用 Docker 安裝 Jenkins Agent](https://twblog.hongjianching.com/2018/10/10/install-jenkins-agent-with-docker/) 中提到使用的 agent docker image 是 jenkins/jnlp-slave，所以我們先參考一下原本的 Dockerfile 是怎麼寫的 [(source)](https://github.com/jenkinsci/docker-jnlp-slave/blob/3.26-1/Dockerfile)

```
FROM jenkins/slave:3.26-1
MAINTAINER Oleg Nenashev <o.v.nenashev@gmail.com>
LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="3.23"

COPY jenkins-slave /usr/local/bin/jenkins-slave

ENTRYPOINT ["jenkins-slave"]
```
從中可以知道，就是復製了 slave 檔案以及設定啟動 slave，因為複製做一次就好，所以我們只需要啟動 slave。

利用 [使用 GitHub 在 DockerHub 自動建置 Docker Image](https://twblog.hongjianching.com/2018/10/08/create-dockerhub-automated-build/) 的方法，建立一個 [docker-jenkins-jnlp-slave-cpp](https://github.com/allyusd/docker-jenkins-jnlp-slave-cpp) github 專案並且建立一個 Dockerfile 檔案，內容就是以 jenkins/jnlp-slave 為基底，加上安裝 C++ 編譯環境，最後記得啟動 slave

```
FROM jenkins/jnlp-slave:3.26-1

RUN apt update && apt install build-essential -y

ENTRYPOINT ["jenkins-slave"]
```

接著在 dockerhub 建立 [jenkins-jnlp-slave-cpp](https://hub.docker.com/r/allyusd/jenkins-jnlp-slave-cpp/) 自動建置專案，並且手動觸發一次，結果失敗了，查詢一下 [Log](https://hub.docker.com/r/allyusd/jenkins-jnlp-slave-cpp/builds/baavigxpyfscewc3e63nbvh/) 居然是 `List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)`

權限不足？這沒道理啊，docker 預設是 root，怎麼會有權限問題呢？等等，剛剛是不是提到了`預設`兩個字。嗯，既然如此，那有可能是被改掉，但是剛剛參考的 Dockerfile 很乾淨，難道是再上一層繼承的 image？

從 Dockerfile 可以看到 jenkins/jnlp-slave 是繼承 jenkins/slave來的，那來看一下 Dockerfile [(source)](https://github.com/jenkinsci/docker-slave/blob/3.26-1/Dockerfile)

```
FROM openjdk:8-jdk
MAINTAINER Oleg Nenashev <o.v.nenashev@gmail.com>

ARG user=jenkins
ARG group=jenkins
ARG uid=10000
ARG gid=10000

ENV HOME /home/${user}
RUN groupadd -g ${gid} ${group}
RUN useradd -c "Jenkins user" -d $HOME -u ${uid} -g ${gid} -m ${user}
LABEL Description="This is a base image, which provides the Jenkins agent executable (slave.jar)" Vendor="Jenkins project" Version="3.23"

ARG VERSION=3.26
ARG AGENT_WORKDIR=/home/${user}/agent

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

USER ${user}
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}
```

抓到了！其中有一行是 `USER ${user}`，這個指令改變了目前的使用者為 jenkins，造成權限不足以安裝套件。既然如此，那我們就把使用者改回來試試看。

```
FROM jenkins/jnlp-slave:3.26-1

USER root
RUN apt update && apt install build-essential -y
USER jenkins

ENTRYPOINT ["jenkins-slave"]
```

這 Github 更新 Dockerfile 之後，Dockerhub 自動開始了建置映像檔的動作，我們可以上個廁所、泡泡茶再回來看看建置結果。

很好，這次成功了！

![](/assets/images/2018-10-13-create-cpp-compiler-with-jenkins-agent-docker-image-part-2/2018-10-13_21-07-50.png)

接下來就是啟動一個新的 agent，如果忘記的話可以參考 [使用 Docker 安裝 Jenkins Agent](https://twblog.hongjianching.com/2018/10/10/install-jenkins-agent-with-docker/)

這次不同的是，標籤設定為 `cpp`，使用方式設為`只保留給限定節點的作業`，因為有些專案不需要 C++ 環境，所以我們為了區隔，讓這個 agent 只跑需要 C++ 的專案。

![](/assets/images/2018-10-13-create-cpp-compiler-with-jenkins-agent-docker-image-part-2/2018-10-13_21-10-33.png)

接著啟動 C++ Agent

```bash
docker run \
    --name jenkins_agent_cpp \
    -d --restart always \
    allyusd/jenkins-jnlp-slave-cpp \
    -url http://192.168.43.140:8080 \
    951ac478b69131e43fb2cfb6d201ecf789ba388a759ea946d7ab62aac55227a7 \
    agent-cpp
```

接著修改上一篇建立的 `test_cpp` 專案設定，選取`限制專案執行節點`，在`標籤表示式`輸入 `cpp`，按下儲存之後點擊`馬上建置`

![](/assets/images/2018-10-13-create-cpp-compiler-with-jenkins-agent-docker-image-part-2/2018-10-13_22-28-48.png)

這一次順利的建置成功啦！

![](/assets/images/2018-10-13-create-cpp-compiler-with-jenkins-agent-docker-image-part-2/2018-10-13_22-31-40.png)


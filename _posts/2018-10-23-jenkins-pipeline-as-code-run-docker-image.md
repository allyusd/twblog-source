---
title: "Jenkins - Pipeline as Code - 啟動 Docker Image"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins Docker
---

這篇要介紹透過 Jenkinsfile 直接啟動 Docker Image 來執行

早前介紹過[使用 Docker 安裝 Jenkins Agent](https://twblog.hongjianching.com/2018/10/10/install-jenkins-agent-with-docker/)，但是這個方法，每個環境都要建立一次該環境的 agent docker image，其實有點麻煩，難道不能讓我直接拿 docker image 來執行呢？

答案是可以的，所以前一篇介紹[在 Ubuntu 安裝 Jenkins Agent](https://twblog.hongjianching.com/2018/10/22/install-jenkins-agent-on-ubuntu/)，目的是使用該 ubuntu 上的 docker 執行環境。如果還沒有安裝 docker 的話，請參考這篇完成[安裝 Docker](https://twblog.hongjianching.com/2018/10/02/install-docker/)

首先將 ubuntu agent 加上 **docker** 標籤，避免跑到其它沒有 docker 環境的 agent 上，那就會不能執行了喔

![](/assets/images/2018-10-23-jenkins-pipeline-as-code-run-docker-image/2018-10-23_21-21-51.png)

接著修改 Jenkinsfile 關於 agent 的宣告，原本是限制執行在有 **cpp** 標籤上的像這樣

```
agent {
    label 'cpp'
}
```

改為限制執行在 **docker** 標籤上，而且要啟動 docker image **maven:3-alpine**

```
agent {
    docker {
        label 'docker'
        image 'maven:3-alpine'
    }
}
```

為了展示在不同 docker image 上執行的能力，我們顯示執行環境的版本資訊

```
steps {
    sh 'cat /etc/*-release'
}
```

除了 alpine 之外，我們額外新增 ubuntu 及 archlinux 來示範

完整的 Jenkinsfile 如下

```
pipeline {
    agent none
    stages {
        stage('alpine') {
            agent {
                docker {
                    label 'docker'
                    image 'maven:3-alpine'
                }
            }
            steps {
                sh 'cat /etc/*-release'
            }
        }
        stage('ubuntu') {
            agent {
                docker {
                    label 'docker'
                    image 'ubuntu:18.04'
                }
            }
            steps {
                sh 'cat /etc/*-release'
            }
        }
        stage('archlinux') {
            agent {
                docker {
                    label 'docker'
                    image 'base/archlinux'
                }
            }
            steps {
                sh 'cat /etc/*-release'
            }
        }
    }
}
```

要使用預建立的檔案，同樣在 **https://github.com/allyusd/jenkins-pipeline.git**，branch 是 **different-agent-docker**

成功建置之後會出現三個 stage

![](/assets/images/2018-10-23-jenkins-pipeline-as-code-run-docker-image/2018-10-23_21-31-20.png)

alpine 執行結果

![](/assets/images/2018-10-23-jenkins-pipeline-as-code-run-docker-image/2018-10-23_21-32-40.png)

ubuntu 執行結果

![](/assets/images/2018-10-23-jenkins-pipeline-as-code-run-docker-image/2018-10-23_21-33-15.png)

archlinux 執行結果

![](/assets/images/2018-10-23-jenkins-pipeline-as-code-run-docker-image/2018-10-23_21-34-24.png)

透過 docker image 啟動不同環境是不是很有彈性呢？

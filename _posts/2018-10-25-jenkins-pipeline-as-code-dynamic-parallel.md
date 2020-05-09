---
title: "Jenkins - Pipeline as Code - 動態平行工作"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

前一篇介紹[平行工作](https://twblog.hongjianching.com/2018/10/24/jenkins-pipeline-as-code-parallel/)，但是每個 stage 其實是一樣的東西，明明重覆的事情要寫好幾遍很討厭，能不能動態產生呢？

先消除重覆的部份，透過 script 來執成

宣告兩個變數，分別是存放平行工作的 tasks 及存放 image 列表的 imagelist

```
def tasks = [:]
def imagelist = ['maven:3-alpine', 'ubuntu:18.04', 'base/archlinux']
```

接著透過 for 迴圈將 imagelist 都執行一遍，內容是定義每個 task 要做的事情

```
for (image in imagelist) {
    def image_inside = "${image}"
    tasks["${image}"] = {
        node('docker') {
            stage("${image_inside}") {
                docker.image("${image_inside}").inside {
                    sh "echo ${image_inside}"
                    sh 'cat /etc/*-release'
                }
            }
        }
    }
}
```

上面這段程式要特別注意的是其中 **def image_inside = "\${image}"**，這是不能拿掉的喔！另外 **docker.image** 這段是為了執行在 docker image 內，如果是一般的 agent 是不需要這段的。

雖然這樣已經達到目的了，但是之後要增加 image 還要需要修改 Jenkinsfile，可能的話當然是希望將可能變動的部份抽離出來。

要讓 Jenkinfile 不需要修改，可以透過外部檔案來設定 imagelist，所以我們要讀取檔案，並且設定到 imagelist 陣列中

```
def imagelist = readFile('imagelist').replace("\n", "").split(',')
```

上面的指令，先是讀取 imagelist 檔案，移除換行符號之後，依照逗號分隔項目，最後存進 imagelist

而 imagelist 檔案的內容則是

```
maven:3-alpine,ubuntu:18.04,base/archlinux
```

完整的檔案在 [這裡](https://github.com/allyusd/jenkins-pipeline/tree/agent-docker-dynamic-parallel)

# ref

[jenkins - How to properly achieve dynamic parallel action with a declarative pipeline? - DevOps Stack Exchange](https://devops.stackexchange.com/questions/3073/how-to-properly-achieve-dynamic-parallel-action-with-a-declarative-pipeline/3090#3090)

[Limiting Jenkins pipeline to running only on specific nodes - Stack Overflow](https://stackoverflow.com/questions/42652533/limiting-jenkins-pipeline-to-running-only-on-specific-nodes?rq=1)

[[JENKINS-44086] Parallel nodes for scripted pipelines cannot be clicked - Jenkins JIRA](https://issues.jenkins-ci.org/browse/JENKINS-44086)

[jenkins - Why an each loop in a Jenkinsfile stops at first iteration - Stack Overflow](https://stackoverflow.com/questions/37594635/why-an-each-loop-in-a-jenkinsfile-stops-at-first-iteration)

[Reading file from Workspace in Jenkins with Groovy script - Stack Overflow](https://stackoverflow.com/questions/22917491/reading-file-from-workspace-in-jenkins-with-groovy-script)

[Using Docker with Pipeline](https://jenkins.io/doc/book/pipeline/docker/)

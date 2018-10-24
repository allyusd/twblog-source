---
title: "Jenkins - Pipeline as Code - 平行工作"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

在之前的範例中，我們都是使用連續流程 pipeline，當某一個 stage 失敗，則剩餘的 stage 直接跳過不再執行，以流水線來說這是正確的。

一般流水線的基本 stage 是 build, test, deploy，當 build 失敗的時候，意味著下一個 test stage 勢必沒有辦法執行，所以直接跳過這個 stage。而 test 失敗的時候，表示沒有通過測試，不應該進行 deploy。

但是，有個情況是，假如我是一個網頁程式，想要測試時跑在 chrome, firefox, ie 等環境，這時三者之間獨立存在，彼此沒有關聯。假如在 chrome 失敗了，並不代表在 firefox 及 ie 會失敗，所以不應該直接跳過，這時三個 stage 就應該是平行工作。

接下來的測試借用前一篇[Jenkins - Pipeline as Code - 啟動 Docker Image](https://twblog.hongjianching.com/2018/10/23/jenkins-pipeline-as-code-run-docker-image/)的範例來示範，原先執行了三個 docker image，我們現在故意讓第一個失敗，把 image 改為不存在的 **non-exist:fail** 看看結果

(已建立的檔案在 **https://github.com/allyusd/jenkins-pipeline.git**，故意失敗的 branch 為 **agent-docker-fail**)

從 Stage View 來看，只知道三個 stage 都是 failed 的結果

![](/assets/images/2018-10-24-jenkins-pipeline-as-code-parallel/2018-10-24_22-41-14.png)

實際到 Logs 確認後，可以發現第一個 stage 失敗之後，後續兩個 stage 直接跳過了

![](/assets/images/2018-10-24-jenkins-pipeline-as-code-parallel/2018-10-24_22-39-29.png)

為了達到平行工作的目的，我們可以使用 **parallel** 關鍵字，透過平行宣告，讓這三個 stage 不再有上下流的關係。

原本的 Jenkinsfile 修改後如下

(branch 為 **agent-docker-parallel**)

```
pipeline {
    agent none
    stages {
        stage('parallel') {
            parallel {
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
    }
}
```

成功執行的情況跟原本的沒太大差別，只是多了一個 parallel stage，事實上沒有做什麼事情。

![](/assets/images/2018-10-24-jenkins-pipeline-as-code-parallel/2018-10-24_22-47-42.png)

接著把平行版本給弄壞，同樣讓第一個 stage 改成不存在的 image

(branch 為 **agent-docker-parallel-fail**)

執行後的 Stage View 明顯看出只有第一個 stage 是 failed，其它兩個 stage 都有順利執行，如果是在程式除錯的情況下，就會往第一個環境與其它不同的部份去 debug，為開發人員提供很好的判斷資訊

![](/assets/images/2018-10-24-jenkins-pipeline-as-code-parallel/2018-10-24_22-51-23.png)

改成平行工作，除了讓 stage 消除上下流關係，提供開發人員除錯資訊外，因為彼此獨立，所以如果在有多個可使用 agent 的情況下，是真的可以平行進行的喔。

![](/assets/images/2018-10-24-jenkins-pipeline-as-code-parallel/2018-10-24_22-56-02.png)

上圖表示同樣是 #6，但是一個在執行的時候，還有兩個在佇列中等候，如果幫 Jenkins 再安裝兩個 agent，就可以看到同時進行喔！

等等，突然想到目前的執行環境是使用 docker image，環境互不影響，那我只要將 ubuntu-18.04 agent **執行程式數量** 設定為 3 就可以展示效果

![](/assets/images/2018-10-24-jenkins-pipeline-as-code-parallel/2018-10-24_22-59-36.png)
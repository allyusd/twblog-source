---
title: "Jenkins - Pipeline as Code - 封存檔案"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

接續前一篇 [Jenkins - Pipeline as Code - C++ 專案](https://twblog.hongjianching.com/2018/10/16/jenkins-pipeline-as-code-cpp-project/)，這篇的主題是封存檔案

封存檔案功能可以把編譯完成的檔案存起來，這樣之後要用就可以直接使用，不需要再次編譯

在講封存檔案之前，先來講一下 Pipeline 在不同 Agent 之間進行作業的情況吧

這次[使用的環境](https://twblog.hongjianching.com/2018/10/13/create-cpp-compiler-with-jenkins-agent-docker-image-part-2/)加上一點點的修改，在原本的 `agent` 的`設定`的`標籤` 加上 `test`，用來跟 `agent-cpp` 的 `cpp` 標籤作出明確區隔。

首先要在 Build、Test 階段分別指定不同的 Agent，在 Build 使用有 C++ 編釋環境的 `cpp` 標籤，在 Test 則使用沒有 C++ 編釋環境的 `test` 標籤，這樣的設定可以確保編釋完成的檔案可以順利的發佈，避免只能在開發環境執行的情況。

```    
stage('Build') {
    agent {
        label 'test'
    }
    steps {
        ... (略)
    }
}
```

```    
stage('Test') {
    agent {
        label 'cpp'
    }
    steps {
        ... (略)
    }
}
```

除了上面兩個設定之外，別忘了在最一開始[介紹](https://twblog.hongjianching.com/2018/10/14/jenkins-pipeline-as-code-introduction/)的時候說過，當各個 state 使用各自的 agent 宣告時，最頂級的 agent 要宣告為 none

完整的 Jenkinsfile 為下
```
pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                label 'cpp'
            }
            steps {
                echo 'Building..'
                git 'https://github.com/allyusd/helloworld.cpp.git'
                sh 'g++ helloworld.cpp -o helloworld'
            }
        }
        stage('Test') {
            agent {
                label 'test'
            }
            steps {
                echo 'Testing..'
                sh './helloworld'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
```

如果要使用預建立的檔案，同樣在 `https://github.com/allyusd/jenkins-pipeline.git`，這次是 `different-agent` branch。

修改後啟動建置，會發現失敗了。首先檢查我們的設定是否正確生效
首先 Build 是執行在 agent-cpp，接著 Test 是執行在 agent

![](/assets/images/2018-10-17-jenkins-pipeline-as-code-artifacts/2018-10-17_22-04-06.png)

![](/assets/images/2018-10-17-jenkins-pipeline-as-code-artifacts/2018-10-17_22-05-31.png)

從 Logs 來看設定是正確的，那錯誤是什麼呢？

![](/assets/images/2018-10-17-jenkins-pipeline-as-code-artifacts/2018-10-17_22-07-15.png)

發現錯誤訊息是找不到執行檔 helloworld，為什麼之前可以正常執行，現在卻找不到？跟我們剛剛做的變更有關嗎？

原因是原本我們都在同一個 agnet 上執行，所以編釋後可以直接執行。但是現在我們在 agent-cpp 上編釋，當想要在 agent 執行的時候，是沒有檔案可以執行的。該怎麼辦呢？

好的，回到主題，我們可以利用封存檔案的功能來取得 agent-cpp 編譯完成的 helloworld 檔案

首先在 Build 階段將檔案封存，跟建置無關的動作，要在 `post` 區段內宣告，只有成功才進行封存，封存的指令是 `archiveArtifacts`，後面接著 `artifacts` 參數加上檔案名稱

```
post {
    success {
        archiveArtifacts artifacts: 'helloworld'
    }
}
```
同時在 Test 階段要取得已封存的檔案，這裡可以透過 `BUILD_URL` 環境變數來取得要下載的網址。然後將下載後的檔案加上執行的權限，最後才是執行檔案

```
steps {
    echo 'Testing..'
    sh '''#!/bin/bash
    curl -O ${BUILD_URL}artifact/helloworld
    chmod +x helloworld
    ./helloworld
    '''
}
```

要使用預建立的檔案，branch 是 `artifacts`

重新建置之後，這次成功執行了，從 Logs 中可以看到有下載檔案的紀錄及執行的結果

![](/assets/images/2018-10-17-jenkins-pipeline-as-code-artifacts/2018-10-17_22-30-20.png)

對了，當我們成功封存檔案，在 Stage View 也可以找到下載的連結喔！雖然不怎麼明顯呢

![](/assets/images/2018-10-17-jenkins-pipeline-as-code-artifacts/2018-10-17_22-31-31.png)

---
title: "Jenkins - Pipeline as Code"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

Jenkins 是個歷史悠久的 CD 工具，從 Jenkins 2.0 開始正式推展 Pipeline，有別於以往使用 Web UI 操作的特性，導向 Pipeline as Code 的實踐。透過在原始碼專案新增一個 Jenkinsfile 的檔案，將 Pipeline 的流程都寫在檔案內。

Pipeline 就是流水線的意思，在這裡指 CD 流水線，一個完整的 CD 流程可以包含 Build (建置)、 Test (測試)、Deploy (部署) 三個 state (階段)，每個公司或產品的 CD 流程所包含的 state 可能不同，可以依需要各別調整。

簡單 Pipeline 範例 [(source)](https://jenkins.io/doc/book/pipeline/jenkinsfile/)

```Jenkinsfile
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
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

# pipeline
Jenkinsfile 的開頭宣告

# agent
指定什麼條件的 agent 可以執行這個專案，any 表示不指定，任意 agent 都可以執行，這個設定相當於 UI 上的`限制專案執行節點`，可以用 label 指定 agent 標籤，假如指定 `test` 的話
```
agent { 
    label 'test'
}
```
另一種情況，如果在不同 state 要分別指定不同 agent 的時候，最上層的 agent 會指定為 none，然後在各自 state 要指定 agent

# stages、stage
代表流水線的各個階段，範例中為 Build, Test, Deploy，這個設定單純為文字，可以依自己的需要命名。主要用在網頁的視覺化效果，像是流水線失敗是在哪一個階段看一眼就可以掌握。或是流水線需要在不同 agent 上執行的時候，就可以透過 stages 分別設定。

# steps
主要執行步驟，常見的是使用 echo 輸出訊息，或是 sh 執行命令。

# ref
[Using a Jenkinsfile](https://jenkins.io/doc/book/pipeline/jenkinsfile/)

[Pipeline Syntax](https://jenkins.io/doc/book/pipeline/syntax/#stages)
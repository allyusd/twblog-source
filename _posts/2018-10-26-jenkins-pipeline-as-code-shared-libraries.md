---
title: "Jenkins - Pipeline as Code - Shared Libraries"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

[前一篇](https://twblog.hongjianching.com/2018/10/25/jenkins-pipeline-as-code-dynamic-parallel/)將 Jenkinsfile 內共用的部份重構為一份，那如果是不同的專案之間要共用呢？像這一連串文章，Jenkinsfile 改了無數次，如果有十幾個甚至幾十個專案不就要一直復制貼上，重覆這個動作好幾次？

我們可以透過 Jenkins Shared Libraries 機制來達到程式碼共用，這邊我們示範單純把整個 Jenkinsfile 封裝起來的方法

首先將原本的 Jenkinsfile 復制到新的檔案 **vars/commonPipeline.groovy** 並且用 def call() 包起來，像這樣

```
def call() {
    pipeline {
        agent none
        stages {

… 略 …

    }
}
```

接著要把 shared libraries 註冊到 Jenkins，在主頁 > 管理 Jenkins > 設定系統 > Global Pipeline Libraries 新增一組 libary，設定如下
* Name: pipeline-library
* Default version: shared-libraries
* 選擇 Modern SCM
* 選擇 Git
* Project Repository: https://github.com/allyusd/jenkins-pipeline.git

填完之後按下儲存，這樣 Jenkins 就知道要去哪裡取得 libary

接著修改 Jenkinsfile，先載入 libary，再呼叫 commonPipeline

```
@Library('pipeline-library') _

commonPipeline()
```

這麼一來，所有的專案的 Jenkinsfile 就只是轉呼叫 commonPipeline，之後只要修改 commonPipeline，所有的專案都會一起更新的，因為他們使用同一份 libary

# ref
[Extending with Shared Libraries](https://jenkins.io/doc/book/pipeline/shared-libraries/)

[Share a standard Pipeline across multiple projects with Shared Libraries](https://jenkins.io/blog/2017/10/02/pipeline-templates-with-shared-libraries/)
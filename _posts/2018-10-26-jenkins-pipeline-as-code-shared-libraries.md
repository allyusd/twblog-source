---
title: "Jenkins - Pipeline as Code - Shared Libraries"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

[前一篇](https://twblog.hongjianching.com/2018/10/25/jenkins-pipeline-as-code-dynamic-parallel/)將 Jenkinsfile 內共用的部份重構為一份，那如果是不同的專案之間要共用呢？像這一連串文章，Jenkinsfile 改了無數次，如果有十幾個甚至幾十個專案不就要一直復制貼上，重覆這個動作好幾次？

我們可以透過 Jenkins Shared Libraries 機制來達到程式碼共用，這邊我們示範單純把整個 Jenkinsfile 封裝起來的方法
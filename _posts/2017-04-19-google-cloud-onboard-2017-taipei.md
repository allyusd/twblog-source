---
title: "Google Cloud OnBoard 2017 Taipei"
tags: post
---
2017-04-19 Google Cloud OnBoard 活動在台北國際會議中心舉行。

# 活動心得
![](/assets/images/2017-04-19-google-cloud-onboard-2017-taipei/IMG_0291-800.jpg)

## 前言
這次從台中出發，遇到交流道車禍塞車，到會場時已經十點了。

會場人超多超滿的，比想像中還要多很多啊！

唯一可惜的是會場是大會堂，非預期中可以使用筆電的桌子。

預期是因為之前參加 AWSome Day 2014 Taipei 印象所致。

虧我還建議同事帶筆電跟事前申請帳號，方便現場操作，對他們真不好意思。

## 資訊
Google Cloud 在亞洲機房有：日本、**台灣**、新加坡。

台灣的機房在[彰化](https://www.google.com/about/datacenters/inside/locations/changhua-county/)，是目前全球四大雲端平台唯一有台灣機房的平台。

這是網路找到的 ping 值查詢：

[Measure your latency to GCP regions](http://www.gcping.com/)

講者介紹的中文說明 GitBook，是由 GCPUG.TW 社群提供：

[Google Cloud Platform in Practice](https://www.gitbook.com/book/gcpug-tw/google-cloud-platform-in-practice)

## 活動紀錄照片

|本次活動手冊|廠商紀念品|
|:-:|:-:|
|![](/assets/images/2017-04-19-google-cloud-onboard-2017-taipei/IMG_0301-400.jpg)|![](/assets/images/2017-04-19-google-cloud-onboard-2017-taipei/IMG_0304-400.jpg)|
|活動紀念T (正面)|活動紀念T (背面)|
|![](/assets/images/2017-04-19-google-cloud-onboard-2017-taipei/IMG_0308-400.jpg)|![](/assets/images/2017-04-19-google-cloud-onboard-2017-taipei/IMG_0310-400.jpg)|

活動證書

![](/assets/images/2017-04-19-google-cloud-onboard-2017-taipei/IMG_0303-400.jpg)



## Free Resouce
### Cloud Source Repositories
This Beta release of Cloud Source Repositories is free and can be used to store up to 1 GB of source files.[^1]

[^1]:https://cloud.google.com/source-repositories/pricing

跟 GitHub、Bitbucket、GitLab 一樣的 Git 倉庫服務，目前 Beta，免費提供 1 GB 的空間。
	
### Cloud Shell
Google Cloud Shell is free for customers of Google Cloud Platform.[^2]

[^2]:https://cloud.google.com/shell/pricing

Cloud Shell 其實是一台已經預裝很多程式套件的 Linux 虛擬機，可以用來進行 Cloud API 測試，還提供網頁檢視，拿來寫個簡單程式也可以。重點是，免費，而且有 5 G 的持久性硬碟儲存空間，限制是 20 分鐘沒有動作就會關閉此環境，不能拿來當服務端使用。

註：如果要一個真正免費 Linux VM，Google 也有提供：

[Always Free Usage Limits](https://cloud.google.com/free/docs/always-free-usage-limits)

# Google Cloud Platform 介紹
接下來依自己關注的部份進行筆記，非完整列表。大部份是簡報內容。

## IAM
關於權限控管的部份，因為遲到，這部份沒有聽到。

## Google Cloud SDK
* CLI tool
* Docker Image: google/clound-sdk
* Cloud Shell 使用
* RESTful APIs
* APIs Explorer

完整的工具，完全符合開發者的需求。

## App Engine

* 建構可擴充的 Web 應用程式或行動通訊後端平台 (Platform as a Service)
* 簡化開發、維護及擴充等作業，專注於應用程式的開發

App Engine is PaaS (完全受管理的服務 NoOps)
Compute Engine is IaaS (受管理的基礎架構 DevOps)

## 儲存裝置

### Cloud Datastore

* NoSQL
* 自動擴充並提供完全的管理
* 內建備援能力
* 支援 ACID 交易

### Cloud Storage
* BLOB (Binary Large Object)
* Not filesystem, but can use tool access like filesystem
* Object, Not Block, No space limit

### Cloud BigTable
* ???

### Cloud SQL
* MySQL 5.5, 5.6
* PostgreSQL BETA
* 垂直擴充、水平擴充

### Cloud Spanner
* 新服務
* 看起來結合所有資料庫的優勢
* ???

## Google Container Engine
Kubernetes，容器管理叢集系統。

* 透過 Deployment 與 Service 提供行型服務管理
* Blue Green Deployment
* Rolling Update

## Google Compute Engine
就是 VM，虛擬機，擁有完整 OS 的控制權

## 網路
* 負載平衡 Load balancing
* Clound CDN

## 運用與工具

### Google Stackdrive
* 整合監控、登入、診斷
* 橫跨 Google Clound Platform 與 Amazone Web Srvices 提供服務
* Open source agent 的整合
* 強大的資料蒐集、分析工具
* 與 PagerDuty、BMC、Splunk 等的協同合作

### Deployment Manager
* 基礎架構管理服務
* 產生記載環境的 .yaml 範本，為了建立資源而使用 Deployment Manager
* 提供可重複執行的部署

## Big Data
???

## Machine Learning
???

最後兩個 Big Data 跟 Machine Learning 已經脫離學習的範圍。

# 結語
這次活動讓我下定決心申請 Google Cloud Platform 帳號，之後應該會好好利用一下免費測試的機會。

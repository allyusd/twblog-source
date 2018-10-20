---
title: "Jenkins - Pipeline as Code - 測試報告"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

這次要讓 Jenkins 可以顯示程式碼的變更

這個功能要透過 plugin 來完成，所以要先安裝 plugin，在 Jenkins 首頁選擇`管理 Jenkins`

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_22-33-28.png)

在管理 Jenkins 頁面，選擇`管理外掛程式`，這邊的外掛程式指的就是 Jenkins plugin

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_22-36-41.png)

在管理外掛程式頁面，會有四個分頁
* 更新
代表你已安裝的 plugin 有更新的版本可以安裝
* 可用的
代表你未安裝的 plugin
* 已安裝
代表你已安裝的 plugin
* 進階
關於 plugin 安裝的相關設定，HTTP Proxy設定、上傳外掛程式、更新網址等等

在這裡我們選擇`可用的`分頁

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_22-39-00.png)

接著在一大堆的 plugin 中找到 `Last Changes`，可以透過 Ctrl + F 之類的機制會比較快找到喔

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_22-40-16.png)

接著選擇下方的`下載並於重新啟動後安裝`

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_22-45-39.png)

正在安裝/升級 Plugins 頁面，把下方的`當安裝完成且沒有工作正在執行時，重啟 Jenkins`打勾，這樣 Jenkins 就會自動重啟喔

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_22-49-20.png)

Jenkins 重啟之後，plugin 就可以使用了，接下來修改 Jenkinsfile。關鍵字是 `lastChanges`，`format` 選擇 `side-by-side`，會將兩個版本分別顯示在左邊跟右邊，個人習慣這種方式。因為差異不論建置成功或失敗都會想看，所以我們放在 `always` 宣告內，有別於 archiveArtifacts 的 `success` 宣告只有在建置成功才執行，在 always 內的動作無論如何都會執行。

```
always {
    lastChanges format:'SIDE', matching: 'LINE'
}
```

這次的程式碼同樣在 `https://github.com/allyusd/jenkins-pipeline.git`，branch 是 `last-changes`

執行後，在左邊選單列會出現 `View Last Changes`

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_23-06-40.png)

View Last Changes 的結果如下

![](/assets/images/2018-10-20-jenkins-pipeline-as-code-last-changes/2018-10-20_23-11-50.png)

從上圖可以明顯的知道這次的程式碼修改了什麼，幫助判斷是什麼部份可以造成建置的錯誤
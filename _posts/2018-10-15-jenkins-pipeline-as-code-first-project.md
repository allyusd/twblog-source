---
title: "Jenkins - Pipeline as Code - 第一個專案"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

[Jenkins - Pipeline as Code - 簡介](https://twblog.hongjianching.com/2018/10/14/jenkins-pipeline-as-code-introduction/)說明完簡單範例，接著來實際建立專案執行看看

以[使用 Docker 安裝 Jenkins Agent](https://twblog.hongjianching.com/2018/10/10/install-jenkins-agent-with-docker/)為執行環境

在左邊功能列點擊`新增作業`，然後名稱輸入 `jenkins-pipeline`，下方選擇 `Pipeline` 後按下 `OK`

![](/assets/images/2018-10-15-jenkins-pipeline-as-code-first-project/2018-10-15_21-09-42.png)

然後在 `Pipeline` 的 `Definition` 選擇 `Pipeline script from SCM`，接荖輸入 Jenkinsfile 所在的 Git 網址，單純想測試的話可以用已經建立好的這個路徑 `https://github.com/allyusd/jenkins-pipeline.git`，下方的 branch 選擇 `sample`，最後按下儲存。

![](/assets/images/2018-10-15-jenkins-pipeline-as-code-first-project/2018-10-15_21-15-41.png)

在左方功能列選擇`馬上建置`，等他執行一會兒，會看到專案主頁會出現 `Stage View`

![](/assets/images/2018-10-15-jenkins-pipeline-as-code-first-project/2018-10-15_21-20-10.png)

從畫面可以看出來我們在 Jenkinsfile 定義的 Pipeline 流程，除了一開始要 Checkout SCM 才能讀取 Jenkinsfile 這一步驟外，就是 Build、Test、Deploy 三個階段。

接下來我們故意讓 Pipeline 失敗看看結果是什麼。在 Test 這一個階段故意以非 0 結束 shell，讓 Jenkins 判定此階段執行失敗

```
stage('Test') {
    steps {
        echo 'Testing..'
        sh 'exit 1'
    }
}
```

如果要使用建立好的檔案，請把 branch 改為 `sample-fail`，按下建置後，同樣等結果執行完成。

從執行的結果可以看到，Test、Deploy 是 failed 的狀態，基於 Pipeline 的概念，實際上 Deploy 是因為前一個 Test 階段失敗，所以跳過沒有執行。

![](/assets/images/2018-10-15-jenkins-pipeline-as-code-first-project/2018-10-15_21-38-11.png)

在真實場景中，Test 階段失敗是 Unit Test fail 的關係，要去檢查程式碼的邏輯是否正確，或是 Unit Test 已經過時該修正了。如果 fail 在 Build 階段，正常是程式碼寫錯，但是如果有使用 IDE 的話，大多數則是有程式碼忘記上傳造成建置失敗。

總結來說，Pipeline 視覺化的 Stage View 可以提供開發者第一時間要往哪個方向去解決問題做出提示。

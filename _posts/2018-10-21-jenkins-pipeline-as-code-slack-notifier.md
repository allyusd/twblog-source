---
title: "Jenkins - Pipeline as Code - Slack Notifier"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

希望在 Pipeline 異常的時候通知你？透過 Slack Notifier 完成目的

# Jenkins Slack Integration

首先要到 slack 的 apps 管理頁面，`https://xxx.slack.com/apps/manage`，其中 xxx 請代入自己的組織名稱，接著在上方搜尋的地方輸入 `jenkins` 會出現 `Jenkins CI`

![](/assets/images/2018-10-21-jenkins-pipeline-as-code-slack-notifier/2018-10-21_21-46-24.png)

點選進入 Jenkins CI Apps 頁面，左方有個 `Install` 按下去

![](/assets/images/2018-10-21-jenkins-pipeline-as-code-slack-notifier/2018-10-21_21-46-46.png)

接著會問你想要發訊息到哪一個 Channel，其實隨便選都可以，之後可以在 Jenkins 修改，這邊我選了 `#general` 頻道

![](/assets/images/2018-10-21-jenkins-pipeline-as-code-slack-notifier/2018-10-21_21-47-30.png)

按下之後會有完整的圖文教學，首先要到 Jenkins 管理頁面安裝 **Slack Notification Plugin**，我使用的 Jenkins 版本跟教學的圖片不一樣，會省略 Plugin 文字，所以要搜尋的話最好只用前面的 **Slack Notification** 會比較好找到。

安裝完外掛之後，要到**管理 Jenkins**，**設定系統**的**Global Slack Notifier Settings** 貼上從 Jenkins CI App 教學頁面給的設定

- 設定 Base URL 為https://xxx.slack.com/services/hooks/jenkins-ci/
- 設定 Integration Token 為 Mursq71aDfDJke4cvUWx9n2f
- 設定 Channel 為 general

設定後可以按一下 **Test Connection**，成功時 Slack 會出現測試訊息

![](/assets/images/2018-10-21-jenkins-pipeline-as-code-slack-notifier/2018-10-21_22-46-03.png)

# Jenkinsfile

因為訊息的發佈應該是跨越 stage 的，所以我們在 stages 平行新增一個 post 宣告。當 pipeline 失敗的時候，使用 **failure** 宣告發送失敗的訊息

**color** 可以定義發佈訊息旁的顏色標示，失敗時用紅色
**message** 就是發佈的訊息內容，為了提醒所有人注意到東西壞掉了，可以加上 @channel，太吵的話可以拿掉，或是討論一下為什麼常常壞掉。還可以透過 Jenkins 的變數提供有用的訊息，像是 **env.JOB_BASE_NAME** 可以提供專案名稱，**env.BUILD_URL** 則是提供本次建置的網址

```
failure {
    slackSend color: '#FF0000',
    message: "@channel ${env.JOB_BASE_NAME} failure. (${env.BUILD_URL})"
}
```

除了壞掉的時候發出訊息通知外，我們也可以發送一些好消息，像是 **fixed** 代表東西修好了，也就是原先建置失敗的專案，第一次建置成功的時候發出通知。這次的顏色用綠色，訊息則簡單的說明哪個專案回到建置成功的狀態

```
fixed {
    slackSend color: '#00FF00',
    message: "@channel ${env.JOB_BASE_NAME} back to success."
}
```

因為完整的 Jenkinsfile 很長，這次不貼到文章上，直接給[連結](https://github.com/allyusd/jenkins-pipeline/blob/slack-notifier/Jenkinsfile)

因為成功的建置不會發送訊息，所以我們先故意用一個壞掉的來建置

同樣是 **https://github.com/allyusd/jenkins-pipeline.git**，branch 是 **slack-notifier-fail**

建置失敗，slack 收到了失敗通知

![](/assets/images/2018-10-21-jenkins-pipeline-as-code-slack-notifier/2018-10-21_22-52-10.png)

接著換成正確的 branch **slack-notifier** 然後再建置一次

這次建置成功，因為前一個建置失敗，所以 slack 收到修復通知

![](/assets/images/2018-10-21-jenkins-pipeline-as-code-slack-notifier/2018-10-21_22-57-32.png)

# ref

[Slack Notification Plugin](https://jenkins.io/doc/pipeline/steps/slack/#slack-notification-plugin)

[Cleaning up and notifications](https://jenkins.io/doc/pipeline/tour/post/)

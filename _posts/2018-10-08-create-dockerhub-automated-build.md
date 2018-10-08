---
title: "使用 GitHub 在 DockerHub 自動建置 Docker Image"
tags: 2019-iT-邦幫忙鐵人賽 Docker
---

今天要談論如何使用 GitHub 和 DockerHub 建立自動建置 Image，功能強大，但是反而非常的簡單喔！

前一篇 [將 Image 發佈到 Docker Hub](https://twblog.hongjianching.com/2018/10/07/push-image-to-dockerhub/) 已經學會手動將做好的 Image 放到 DockerHub 上，但是製作的動作很多，而且如果是想給別人用會有疑慮，因為不知道你的映像檔做了哪些修改，或者會不會加什麼料進去呢？

為了 ~~世界和平~~ 讓其它人可以安心下載你製作的 image，也為了節省自己的時間，我們就利用 GitHub 和 DockerHub 來自動建置映像檔吧。

# GitHub
首先要有 GitHub 帳號，接著建立一個 git 倉庫，這邊命名為 docker-ithelp-webserver-auto，命名沒有規範，叫什麼都可以，個人為了跟一般程式碼專案區隔，所以會加上 docker 前缀字，或者可以考慮單獨申請一個獨立帳號來集中 docker 專案。

重要的一點，為了直接在 GitHub 網頁操作，請將 *Initialize this repository with a README* 打勾喔！(想直接用 git 操作的人就可以無視沒關係)

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-30-16.png)

然後就有一個 Git 倉庫了，接著按下右上角的 *Create new file*

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-32-44.png)

輸入檔名 Dockerfile，和前一篇 Dockerfile 的內容，接著按下 *Commit new file* 就完成 Git 倉庫的準備了。

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-34-47.png)

# DockerHub
接著到 DockerHub，選擇右上角的 *Create* 及 *Create Automated Build*

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-37-44.png)

第一次因為還沒有連結 GitHub，所以會需要授權，按下 *Link Accounts* 及 *Link Github* 及 *Select*，完成授權後，重覆 *Create Automated Build* 的動作會看到 *Create Auto-build Github*

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-41-52.png)

然後就會出現你 Github 所有的專案，選擇剛剛建立的 docker-ithelp-webserver-auto，接著給 Dockerhub 的倉庫命名，個人習慣會把 docker 前缀字拿掉，這個例子為 ithelp-webserver-auto，輸入 Description 後按下 *Cretae*

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-43-32.png)

這麼一來 DockerHub 倉庫也建立完成了，從首頁可以看完最大的不同是會顯示這個 image 的來源，還有選單多了 *Dockerfile*、*Build Details* 和 *Build Settings*，這邊有兩個網頁可以比較一下 [allyusd/ithelp-webserver](https://hub.docker.com/r/allyusd/ithelp-webserver/) 和 [allyusd/ithelp-webserver-auto](https://hub.docker.com/r/allyusd/ithelp-webserver-auto/)

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-46-47.png)

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-48-42.png)

選擇 *Build Settings* 按下 *Trigger* 之後 Dockerhub 就會依照 Github 上面的 Dockerfile 開始建置嘍！建置的狀態或 Logs 可以在 *Build Details* 查詢。

![](/assets/images/2019-10-08-create-dockerhub-automated-build/2018-10-08_21-55-15.png)

而且之後只要 Github 有 push 的動作，就會自動觸發建置喔，這麼一來我們只要專心寫好 Dockerfile，就可以等著使用自動建置好的 image 嘍！
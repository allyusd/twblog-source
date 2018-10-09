---
title: "將 Image 發佈到 Docker Hub"
tags: 2019-iT-邦幫忙鐵人賽 Docker Dockerhub
---

這篇會說明如何將 Image 發佈到 Docker Hub。

在前一篇 [使用 Dockerfile 建立自己的 Docker Image](https://twblog.hongjianching.com/2018/10/06/using-dockerfile-build-docker-image/) 已經知道如何建立自己的 image，但是建立的 image 只能本機使用，除非手動復製，否則不能在其它電腦使用。

在這之前有個疑問，那之前我們使用的 image，像是 hello-world、ubuntu:18.04 是從哪裡來的呢？

# Docker Hub
來源其實就是 [Docker Hub](https://hub.docker.com/)，目前是 Docker 預設的 image 來源，像是 [hello-world](https://hub.docker.com/_/hello-world/)、[ubuntu](https://hub.docker.com/_/ubuntu/)。從網站上可以找看看自己有興趣的 image，或者上傳自己的 image。

我們建立好 Docker Hub 帳號之後，就可以建立 image repository，按右上角的 Create，然後選擇 Create Repository

![](/assets/images/2018-10-07-push-image-to-dockerhub/2018-10-07_21-28-11.png)

接著在 name 的欄位輸入想要的 image 名稱，這個範例中命名為 ithelp-webserver，在下面的 description 可以輸入想要說明的資訊。Visibility 決定這個 image 是不是公開的，公開的話每個人都可以使用，私有的話只有自己能用，但是免費帳號只能有個一個私有倉庫，想要多一些的話就要付費。選擇後按下 Create。

![](/assets/images/2018-10-07-push-image-to-dockerhub/2018-10-07_21-32-50.png)

完成後就會看到這個畫面，這樣一個映像檔倉庫就建立完成了，左上方就是這個 image 的名稱，因為 docker hub 是全球的人共用的，所以個人建立的 image 都會放在該帳號下，這個例子中就是 allyusd/ithelp-webserver。

![](/assets/images/2018-10-07-push-image-to-dockerhub/2018-10-07_21-37-31.png)

然後回到 console，利用 build 指令重新命名 allyusd/ithelp-webserver 映像檔，因為跟前一個完全一樣，所以動作很快完成。

```bash
docker build . -t allyusd/ithelp-webserver
```

在將做好的 image 發佈到 docker hub 之前，需要先證明自己是這個倉庫的擁有者，需要透過 login 指令登入，接著輸入帳號、密碼

```bash
docker login
```

完成登入後，就可以使用 push 指令發佈 image 到 docker hub

```bash
docker push allyusd/ithelp-webserver
```
![](/assets/images/2018-10-07-push-image-to-dockerhub/2018-10-07_22-11-55.png)

完成後可以回到 dockerhub 專案的位置，選擇 Tags 就可以看到剛剛上傳的資訊

![](/assets/images/2018-10-07-push-image-to-dockerhub/2018-10-07_22-13-23.png)

最後我們可以先用 rmi 指令刪除本地的 image，然後再用新的指令啟動 webserver

```bash
docker rmi allyusd/ithelp-webserver
```

```bash
docker run \
    --restart=always \
    -d \
    -it \
    -p 80:80 \
    -v ~/www:/var/www/html \
    allyusd/ithelp-webserver
```
![](/assets/images/2018-10-07-push-image-to-dockerhub/2018-10-07_22-18-26.png)

這麼一來，我們就可以在任何電腦啟動我們自己做的映像檔
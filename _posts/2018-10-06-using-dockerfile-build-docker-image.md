---
title: "使用 Dockerfile 建立自己的 Docker Image"
tags: 2019-iT-邦幫忙鐵人賽 Docker
---

這篇寫簡單 Dockerfile 來建立自己的 Docker Image

在前一篇 [使用 Docker - Port 及 Volume](https://twblog.hongjianching.com/2018/10/05/run-docker-port-volume/)中，如果有照著每個動作來做的話，一定會發現一件事。

那就是，安裝 nginx 的動作重覆很多次而且很久(因為每次都要重新下載)

```
apt update && apt install nginx -y
service nginx start
```

就是上面兩行指令，一再的重覆

# Dockerfile
在 [安裝 Docker](https://twblog.hongjianching.com/2018/10/02/install-docker/) 時有提過，使用 Docker 其中一個優勢就是繼承，這個特性在 Dockerfile 可以體現出來。

Dockerfile 最基本的指令是 FROM，也就是這個 Dockerfile 是繼承哪個 image 的。有一行就可以視為合格的 Dockerfile，像是我們用 ubuntu 當基底。

```
FROM ubuntu:18.04
```

當然，這樣產生的 image 會跟 ubuntu:18.04 一模一樣，所以我們要加上我們想要的，安裝 nginx 動作。透過 RUN 指令，可以幫我們做到這件事

```
FROM ubuntu:18.04

RUN apt update && apt install nginx -y
```

最後，別忘了啟動 nginx，畢竟能自動完成的事情，又何必自己來呢？透過 CMD 指令，告訴 Docker 啟動容器後應該做什麼事情。

這邊特別說明一下，如果 CMD 後面指定的是不會結束的程式，那就沒有問題，但是之前是透過 service 命令啟動的，因為這個命令一執行就結束了，接著容器就結束了，為了避免這種情況，後面加上了 /bin/bash 維持運作。(當然也可以直接執行 nginx 就不用這個動作)

```
FROM ubuntu:18.04

RUN apt update && apt install nginx -y

CMD service nginx start && /bin/bash
```

# build - 建置映像檔

寫完 Dockerfile，就可以建置 image 了，透過 build 指令，後面接 Dockerfile 所在的路徑，最好加上 -t 參數給個名字

```bash
docker build . -t webserver
```

等他建置完，我們可以透過 images 指令來查詢本機目前有哪些 image

```bash
docker images
```
![](/assets/images/2018-10-06-using-dockerfile-build-docker-image/2018-10-06_22-09-13.png)

從圖片中可以看到，除了我們之前用到的 hello-wrold 和 ubuntu:18.04 之外，還多了一個 webserver 的 image，這就是剛剛建立好的映像檔。這麼一來我們把之前的指令改用 webserver 來啟動吧。

```bash
docker run \
    --restart=always \
    -d \
    -it \
    -p 80:80 \
    -v ~/www:/var/www/html \
    webserver
```

這次不再需要進入容器，也不用啟動 nginx，直接可以在 http://localhost 出現網頁嘍！
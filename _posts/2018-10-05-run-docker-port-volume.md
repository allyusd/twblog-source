---
title: "使用 Docker - Port 及 Volume"
tags: 2019-iT-邦幫忙鐵人賽 Docker
---

這篇講一下設定 Port 及 Volume，也是網路及硬碟最簡單的用法

上一篇 [使用 Docker - 背景服務](https://twblog.hongjianching.com/2018/10/04/run-docker-service/) 已經提到如何啟動背景服務執行的方法，這次直接進到容器內，安裝並啟動 nginx。

```
apt update && apt install nginx -y
service nginx start
```

然後在 chrome 上面輸入 localhost，就會出現
![](/assets/images/2018-10-05-run-docker-port-volume/2018-10-05_22-33-14.png)

這是因為容器是個獨立的環境，預設是沒有任何 Port 對外開放的。

# -p Port 對映

使用 -p 參數，左邊是 host 的 port 號，右邊是 container 的 port 號。在這個例子中都是 80 port，完整的指令如下(這串指串越來越長了呢…)

```bash
docker run --restart=always -d -it -p 80:80 ubuntu:18.04
```

執行後可以用 ps 看一下，會發現在 PORTS 欄位多了剛剛加上的設定喔
![](/assets/images/2018-10-05-run-docker-port-volume/2018-10-05_22-27-42.png)

接著再次安裝並啟動 nginx，並且在 chrome 按下 F5 更新，這次成功出現網頁了

![](/assets/images/2018-10-05-run-docker-port-volume/2018-10-05_22-32-34.png)

# -v Volume 對映

接著，我們想要修改網頁，但是容器內沒有編輯器而且不想安裝，能不能直接在 Host 上面修改，然後直接反應在容器呢？

接著利用 Volume 對映，就好像前面講到可以指定 Port 一樣，只是這次換成了硬碟路徑對映，使用 -v 參數，左邊是 Host 路徑，右邊是 container 路徑。在這個例子中，設定在家目錄的 www，對應到 container 內 nginx 的預設路徑 /usr/share/nginx/html，完整的指令如下

```bash
docker run --restart=always -d -it -p 80:80 -v ~/www:/var/www/html ubuntu:18.04
```

已經變得超級長了，這時候在 script 或 Dockerfile 中為了方便閱讀，可能會寫成這樣，意思是一樣的

```
docker run \
    --restart=always \
    -d \
    -it \
    -p 80:80 \
    -v ~/www:/var/www/html \
    ubuntu:18.04
```

安裝並啟動 nginx，退出容器並且修改 host 的 html 檔案，在 chrome 按下 F5 更新後可以看到網頁已經是修改後的樣子了

![](/assets/images/2018-10-05-run-docker-port-volume/2018-10-05_23-35-16.png)

---
title: "使用 Docker - 基本操作"
tags: 2019-iT-邦幫忙鐵人賽 Docker
---

上一篇講[安裝 Docker](https://twblog.hongjianching.com/2018/10/02/install-docker/)，

這篇進入正題，開始使用 Docker

# ps - 顯示容器清單
首先是 ps，列出目前執行中的容器。雖然沒有明確說明，猜想是 linux 的 ps 指令，也就是 process status

```bash
docker ps
```

如果想要看到全部，包含已停止的，加上 -a 參數，代表 all 全部
```bash
docker ps -a
```
如果有照著之前執行過 hello-world，就會發現他出現在清單上，而且是 Exit 狀態。

![](/assets/images/2018-10-03-run-docker/2018-10-03_20-50-15.png)

# rm - 刪除容器
使用 rm 指令，代表 remove 移除，可以使用 id 或者 name 來刪除
```bash
docker rm trusting_wozniak
```
執行成功會顯示被刪除的名字，再用 ps -a 查詢會發現之前的容器已經消失嘍

![](/assets/images/2018-10-03-run-docker/2018-10-03_20-58-52.png)

預設 rm 指令只能刪除停止的容器，如果要強制刪除執行中的容器，就要使用 -f 參數，代表 force 強制
```bash
docker rm -f running_container
```

# run - 執行容器

## hello-wrold
使用 run 執行容器，上一篇已經偷跑執行 hello world
```bash
docker run hello-world
```

如果確認是跑完就不再使用的，可以在執行時加上 --rm 參數，當容器終止時會自動刪除，很方便
```bash
docker run --rm hello-world
```

![](/assets/images/2018-10-03-run-docker/2018-10-03_21-07-43.png)

## ubuntu
只能跑 hello world 絕對不夠，接著來執行 ubuntu 吧。沒錯，在 ubuntu 上面執行 ubuntu 容器，這次 ubuntu 18.04 版本的 image 只有 [30.3 MB](https://microbadger.com/images/ubuntu:18.04)，比前一版 16.04 還少了 11 MB
```bash
docker run --rm ubuntu:18.04
```
執行後，docker 開始下載 ubuntu 18.04 的 image，然後，沒有然後，什麼事都沒發生。這是一開始容易卡關的地方，實際上，容器執行後因為沒事做就終止了，然後被自動刪除 (--rm)。

如果想要跟容器互動，可以加上 -it
```bash
docker run --rm -it ubuntu:18.04
```

![](/assets/images/2018-10-03-run-docker/2018-10-03_21-25-43.png)

這次因為 image 已經在本機了，所以馬上就進入容器內，可以開始大玩特玩喔。雖然 ubuntu docker image 為了最小化，所以很多套件都沒有預裝，但是有 apt-get 可以使用，不用太擔心，想要什麼自己裝就好了。

如果玩膩了，只要輸入 exit 就會退出容器，同時容器就會終止，然後自動刪除嘍。
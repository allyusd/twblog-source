---
title: "安裝 Docker"
tags: 2019-iT-邦幫忙鐵人賽 Docker
---

# Docker 的優勢
Docker 的介紹就跳過了，~~因為我也不懂~~

不只常聽到的 DevOps 還是 CI / CD 會用到 Docker，平常拿來玩一些有的沒的東西時也很好用。不像 VM 還要作快照跟還原，用 docker 可以做完實驗後直接登出就消失，不留痕跡。

簡單來說，使用他的優點就是~~趕流行~~、**快**、**封裝**、**繼承**、~~多型~~

* 快
啟動非常快速，不算下載 Image 的時間，啟動一個 container 只是幾秒鐘的事情。

* 封裝
將開發或執行環境封裝在 Image 裡面，不用擔心沒安裝或少設定什麼。如果是實驗用的環境，就不用擔心會汙染 Host，可以隨心所欲，想安裝什麼就安裝什麼，想改什麼設定就改什麼設定。

* 繼承
別人建好的 Image 可以直接繼承使用，或者自己建立 Base Image，然後一直疊加上去。

# 安裝 Docker
環境我選擇最新的 Ubuntu LTS 18.04 來當 Host，如果手邊沒有多的電腦安裝的話可以用 VirtualBox 裝起來跑。

透過懶人指令安裝 Docker
```bash
sudo sh -c "$(curl -fsSL https://get.docker.com)"
sudo usermod -aG docker $USER
```
[script/docker.sh at master · allyusd/script](https://github.com/allyusd/script/blob/master/docker.sh)

第一行用 docker 官方提供的 script 快速安裝

第二行則是將現有的使用者加入 docker 群組，否則會沒有權限操作 docker 指令

ref: [Get Docker CE for Ubuntu | Docker Documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-convenience-script)

記得重新登入取得新的權限，然後接著執行一下 hello world
```bash
docker run hello-world
```

看到訊息就代表成功執行 docker 嘍
![](/assets/images/2018-10-02-install-docker/2018-10-02_22-06-01.png)
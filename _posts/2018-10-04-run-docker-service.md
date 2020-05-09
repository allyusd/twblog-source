---
title: "使用 Docker - 背景服務"
tags: 2019-iT-邦幫忙鐵人賽 Docker
---

接著[使用 Docker - 基本操作](https://twblog.hongjianching.com/2018/10/03/run-docker-basic/)

# run - 執行容器

之前提到使用 run 及 -it 參數可以進入容器內操作，這時候如果輸入 exit 離開就會結束容器執行。但如果不想結束容器運作，單純想退出 shell 怎麼辦？

直接關閉 shell 或是按下 `Ctrl + p` 及 `Ctrl + q` 就可以保持容器運作

那能不能一開始就想讓容器保持運作，像一個背景服務一樣單獨執行而不進入 shell 介面呢？

可以，使用 -d，代表 detach

```bash
docker run --rm -d -it ubuntu:18.04
```

![](/assets/images/2018-10-04-run-docker-service/2018-10-04_21-43-15.png)

# attach

好的，雖然我剛剛是這麼要求的，但是我反悔想進入容器內操作，能不能不要啟動新的容器直接進入目前執行中的容器呢？

可以，剛剛是 detach，反過來是 attach，一樣可以透過 id 或 name 指定要進入的容器

```bash
docker attach running_container
```

![](/assets/images/2018-10-04-run-docker-service/2018-10-04_21-47-55.png)

記得要離開的時候要透過 `Ctrl + p` 及 `Ctrl + q` 進行 detach，否則容器會終止運行喔。

# stop, start - 停止、啟動容器

既然我們的目標是一個背景服務，萬一不小心直接輸入 exit 關掉的話就不好了，所以我們可以把之前為了方便測試的 --rm 參數拿掉，這樣容器在終止時還會保留下來。

```bash
docker run -d -it ubuntu:18.04
```

這裡同時介紹一下，運行中的容器想要停止的話可以透過 stop 指令，並且透過 start 重新啟動

```bash
docker stop running_container
```

```bash
docker start running_container
```

![](/assets/images/2018-10-04-run-docker-service/2018-10-04_21-58-47.png)

# --restart - 重新啟動

要作為背景服務，別忘了自動重新啟動的功能，透過 --restart 加上 always 讓 docker 自動幫容器重新啟動

重新啟動包含下列情境

- Host 開機時自動啟動容器 (是的，預設開機時是不會啟動的喔)
- 在容器中不小心輸入 exit 退出運行時自動重啟
- 容器運行中的程式當掉了，自動重啟

這邊要注意，自動重啟 **不包含** 上面提到的 stop 指令喔，透過 stop 指令還是會停止面前容器運作，不會自動重啟的，不過也因為這樣才能進行維謢作業

```bash
docker run --restart=always -d -it ubuntu:18.04
```

![](/assets/images/2018-10-04-run-docker-service/2018-10-04_22-09-23.png)

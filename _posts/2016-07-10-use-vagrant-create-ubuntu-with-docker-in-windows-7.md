---
title: "在 Windows 7 使用 Vagrant 建立 Docker VM 環境"
tags: Vagrant Windows7 Ubuntu Docker VirtualBox
---

需要安裝兩個軟體

一、VirtualBox

https://www.virtualbox.org/wiki/Downloads

二、Vagrant

https://www.vagrantup.com/downloads.html

在下載的過程中，簡單介紹一下 Vagrant。

Vagrant 官方定義為 「建立及設定輕量性、可重覆性及可攜性的開發環境」，主要是透過設定檔使用 VirtualBox 來建立一個虛擬機器 (Virtual Machine, VM)，是達成 「Infrastructure As Code」的一種方式。

Vagrant 包裝好的環境，稱為 Vagrant Box，本來在 Vagrant Cloud 提供上傳下載，但是現在被 Atlas 合併後不開放新帳號註冊了，所以只能下載 Box，不能上傳，除非你有原本 Vagrant Cloud 的帳號，幸好主要是要用 Docker，以後有 DockerHub，這些事情就不重要嘍。

下載安裝完 VirutalBox 及 Vagrant 之後，就可以開啟命令提示字元 (cmd.exe) 來操作嘍。首先建立這次要使用的資料夾，會用來放 vagrant 設定檔

```bat
mkdir vagrant\ubuntu
cd vagrant\ubuntu
```

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/001.png)

目標版本為 Ubuntu 14.04 LTS ，直接用已經存在的 Box 來進行初始化。

```bat
vagrant init ubuntu/trusty64
```

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/002.png)

初始化會在資料夾產生一個 Vagrantfile，是 Vagrant 主要的設定檔，目前只有指定 Box 名稱，如果想要設定 cpu, memory 等等，也在這裡設定，目前先用預設值來啟動 VM。

```bat
vagrant up
```

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/003.png)

如果是第一次使用這個 Box，會從 Atlas 網站下載，時間視檔案大小及網路速度而定，第二次之後就會省去這個動作，順便一提，下載後 Box 存放的路徑在 %USERPROFILE%\.vagrant.d\boxes。等進度條跑完，Vagrant 就會依照設定把 VM 開起來嘍。

接著使用 ssh 登入 VM吧。

```
vagrant ssh
```

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/004.png)

這樣已經可以開始玩新建立的 VM 嘍，但是習慣用 PieTTY 連線的話怎麼辦呢？這時候就要回頭看一下啟動的訊息，其中最重要的是 22 (guest) => 2222 (host) 的 Forwading ports 設定，代表連到本機的 2222 port 就可以連到 VM 的 22 ssh port 喔。

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/005.png)

預設的帳密是 vagrant / vagrant

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/006.png)

因為 Ubuntu 14.04 還沒有預裝 Docker，所以我們要先安裝，

透過官方提供的指令可以快速完成相關安裝及設定。

```bash
curl -sSL https://get.docker.com/ | sudo sh
```

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/007.png)

可以看到安裝的 Docker 版本是 1.11.2，且提示要使用非 root 操作 docker 的話，將該 user 加入 docker 群組中。

```bash
sudo usermod -aG docker ${USER}
```

輸入後重新登入，使用指令測試一下 docker

![](/assets/images/2016-07-10-use-vagrant-create-ubuntu-with-docker-in-windows-7/008.png)

回過頭來看一下 Vagrant 的效果，

只需要兩行指令，達到輕量性。

(init 指令可改為從 GitHub 取得 Vagrantfile)

直接使用 Box，為可重覆性。

可以在 Windows, Linux, Max 使用，算是可攜性。

以後就不需要苦惱要設定 VirtualBox 的 Image 要怎麼辦了，大大減少從 OS 安裝開始的流程，也不必靠文件的 SOP 來建立想要的環境，接下來就可以開始放心玩 Docker 嘍！

## Udpate

* 2016-07-16 因為 williamyeh/ubuntu-trusty64-docker 除了安裝 docker 之外有其它客製化，為了保持環境單純，改用 ubuntu/trusty64 當範例
* 2017-12-12 搬移網站，調整為 markdown

## 資料來源

[Vagrant Tutorial（2）跟著流浪漢把玩虛擬機](http://www.codedata.com.tw/social-coding/vagrant-tutorial-2-playing-vm-with-vagrant/)

[Vagrant Tutorial（3）細說虛擬機生滅狀態](http://www.codedata.com.tw/social-coding/vagrant-tutorial-3-vm-lifecycle/)

[Vagrant box: can't login with password from VirtualBox GUI](http://stackoverflow.com/questions/26524691/vagrant-box-cant-login-with-password-from-virtualbox-gui)

[《Docker —— 從入門到實踐­》正體中文版 - Ubuntu 系列安裝 Docker](https://philipzheng.gitbooks.io/docker_practice/content/install/ubuntu.html)

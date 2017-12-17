---
title: "Linux command netcat"
tags: post
---

Netcat 是 Linux 下的網路工具，這裡用來進行網路頻寬測試。

# Ubuntu Install

Ubuntu 16.04.2 LTS 版本已預裝 netcat, 如果你的環境沒有可以自行安裝
```bash
sudo apt-get install netcat
```

# Server Side

Netcat 開啟 port 12345 進行偵聽, 等待 client 連線

```bash
nc -vvlnp 12345 >/dev/null
```

如果想要使用系統 port 像是 80 的話需要 root

```bash
sudo nc -vvlnp 80 >/dev/null
```

# Client Side

使用 dd 產生資料，並透過 netcat 傳送到 server
此範例會產生 1GM 的資料量 (1MB * 1K)

```bash
dd if=/dev/zero bs=1M count=1K | nc -vvn 13.75.44.147 80
```

# Demo Result

```bash
Connection to 13.75.44.147 80 port [tcp/*] succeeded!
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 14.2554 s, 75.3 MB/s
```

# Infinite Loop Server

如果需要進行連續測試的話可以使用 shell 進行迴圈

```bash
#!/bin/bash

while true
do
    sudo nc -vvlnp 80 >/dev/null
done
```

# Ref
[How do you test the network speed betwen two boxes?](https://askubuntu.com/questions/7976/how-do-you-test-the-network-speed-betwen-two-boxes)

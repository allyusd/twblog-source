---
title: "使用 Nginx 建立 Reverse Proxy Server"
tags: w3HexSchool Nginx
---

使用 Nginx 建立一個反向代理伺服器

以前使用 Web Server，同一個 VM 需要多個網域對應的時候，在 Apache 會使用 VirtualHost 設定，而 Nginx 實現的功能叫 Server Blocks，詳細可以參考[官網範例](https://www.nginx.com/resources/wiki/start/topics/examples/server_blocks/)

## 使用 Server Blocks 的問題

其實單純使用 Nginx 的 Server Blocks 是沒有問題的，但是在使用 Docker 時，就會出現多個網站使用同一個容器的情況，失去容器化的優勢。

## Reverse Proxy Server

解決的方法很簡單，就是建立反向代理伺服器 (Reverse Proxy Server)

原本的 WebSite A 獨立運作在一個容器 A

另外的 WebSite B 獨立運作在一個容器 B

最後建立一個 Reverse Proxy Server 運作在 容器 C，負責將各自的流量導到容器 A 跟 B。

## 實作

事實上透過 Nginx 建立 Reverse Proxy 非常簡單，首先透過 nginx docker 複製一份預設的設定檔

```shell
docker run --name tmp-nginx-container -d nginx
docker cp tmp-nginx-container:/etc/nginx/nginx.conf nginx.conf
docker rm -f tmp-nginx-container
```

修改 config，在 http 中加上

```json
    server {
      listen       80;
      server_name  domain1.com;

      location / {
        proxy_pass      http://127.0.0.1:8080;
      }
    }

    server {
      listen       80;
      server_name  domain2.com;

      location / {
        proxy_pass      http://127.0.0.1:8081;
      }
    }
```

修改 config 之後，使用自定義的 config 啟動 nginx

```shell
docker run --name proxy-server -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d -p 80:80 nginx
```

這麼一來，當使用者透過 domain1.com 及 domain2.com 存取網站時，就會分別導到不同的地方嘍。
即可以在同一個 VM 中使用同一個 port 處理不同的網站，又不會失去容器化的功能。

### Ref

[nginx - Docker Hub](https://hub.docker.com/_/nginx)
[Full Example Configuration | NGINX](https://www.nginx.com/resources/wiki/start/topics/examples/full/)

---
title: "啟用 Nginx 狀態功能並且使用 Grafana"
tags: w3HexSchool Nginx Grafana
---

從 Grafana 看到的結果

![](/assets/images/2020-06-07/2020-06-07_20-13-21.png)

## 開啟 Nginx 狀態

預設的 docker image 已經有內建 ngx_http_stub_status_module，
可以透過設定檔開啟這個功能

nginx.conf

```conf
server {
  location = /basic_status {
    stub_status;
  }
}
```

可以查詢目前的狀態

![](/assets/images/2020-06-07/2020-06-07_20-12-48.png)

### Ref

[Module ngx_http_stub_status_module](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html)

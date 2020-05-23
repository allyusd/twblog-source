---
title: "使用 Grafana Influxdb Telegraf 監控系統"
tags: w3HexSchool Grafana Influxdb Telegraf monitor
---

系統運作一段時間之後，想要知道最近狀況是否正常，卻沒有紀錄可以查詢跟比較。為了解決這個情況，需要一套監控系統，這裡使用 Grafana Influxdb Telegraf 解決方案。

## 成果

擁有一個可以查詢系統狀態的儀表板

![](/assets/images/2020-05-23/2020-05-23_23-53-18.png)
![](/assets/images/2020-05-23/2020-05-23_23-53-41.png)

## Grafana

Grafana 主要的 Web UI 介面，透過 Influxdb 讀取紀錄資料畫出各種視覺化圖表顯示在 Web 上。

```shell
docker run -d --name=grafana -p 3000:3000 grafana/grafana
```

啟動後使用 chrome 連到該主機的 3000 port，即可看到 Grafana 畫面
http://ip:3000/

![](/assets/images/2020-05-23/2020-05-23_22-21-25.png)

第一次登入預設帳號密碼是 admin / admin，登入後會要求設定新密碼，記得存起來

Note: 這個設定缺少 Grafana 的資料保存，當容器刪除後，相關資料將會遺失

## Influxdb

Influxdb 主要是時間序的資料庫，用來存放 Telegraf 收集的紀錄，提供給 Grafana 查詢。

```shell
docker run -d --name=influxdb -p 8086:8086 \
      -e INFLUXDB_DB=defaultdb \
      -e INFLUXDB_ADMIN_USER=admin \
      -e INFLUXDB_ADMIN_PASSWORD=adminpass \
      -e INFLUXDB_USER=user \
      -e INFLUXDB_USER_PASSWORD=userpass \
      -v /data/influxdb:/var/lib/influxdb \
      influxdb:latest
```

## Telegraf

Telegraf 用來收集相關資料，傳送給 Influxdb。

如果是第一次設定，可以從 docker image 取得預設設定檔

```shell
docker run --rm telegraf telegraf config > telegraf.conf
```

接著修改設定檔，其中 influxdb 的 urls 跟 hostname 要修改，hostname 預設會取 VM 名稱，但是因為跑在容器內，會取到容器的名稱，識別性太低，所以記得設定。

```conf
[agent]
  ...
  hostname = "sgp1"

[[outputs.influxdb]]
  urls = ["http://127.0.0.1:8086"]
  ...
```

除了預設的 cpu, mem 之後，也把一些預設關閉的功能開啟

```conf
[[inputs.interrupts]]
  # no configuration
  
[[inputs.linux_sysctl_fs]]
  # no configuration

[[inputs.net]]
  # collect data only about specific interfaces
  # interfaces = ["eth0"]

[[inputs.netstat]]
  # no configuration
```

接著使用 docker 啟動

```shell
docker run -d --name=telegraf \
  --network host \
	-v /:/hostfs:ro \
	-v /etc:/hostfs/etc:ro \
	-v /proc:/hostfs/proc:ro \
	-v /sys:/hostfs/sys:ro \
	-v /var:/hostfs/var:ro \
	-v /run:/hostfs/run:ro \
	-e HOST_ETC=/hostfs/etc \
	-e HOST_PROC=/hostfs/proc \
	-e HOST_SYS=/hostfs/sys \
	-e HOST_VAR=/hostfs/var \
	-e HOST_RUN=/hostfs/run \
	-e HOST_MOUNT_PREFIX=/hostfs \
  -v /data/telegraf/telegraf.conf:/etc/telegraf/telegraf.conf:ro \
  telegraf
```

Note: 為了收集網路資料，使用 host mode 網路模式，需要注意相關安全性問題

## 新增 DataSource

DataSource 選擇 InfluxDB

HTTP 的 URL 記得設定能從容器中連的到的 InfluxDB IP

InfluxDB Details 輸入 telegraf

最後按下 Save & Test

出現綠底白字表示設定成功

![](/assets/images/2020-05-23/2020-05-23_23-44-10.png)

## 新增 Dashboard

在 Dashboard 管理頁面，選擇右上角的 Import

![](/assets/images/2020-05-23/2020-05-23_23-46-18.png)

然後使用 grafana.com 上建好的設定，輸入 928

![](/assets/images/2020-05-23/2020-05-23_23-47-15.png)

這麼一來就有一些基本的資料可以查詢啦

### Ref

[grafana/grafana - Docker Hub](https://hub.docker.com/r/grafana/grafana)
[Launching a InfluxDB container in docker with a default database name - Stack Overflow](https://stackoverflow.com/questions/49066607/launching-a-influxdb-container-in-docker-with-a-default-database-name)
[telegraf - Docker Hub](https://hub.docker.com/_/telegraf)
[telegraf/FAQ.md at master · influxdata/telegraf · GitHub](https://github.com/influxdata/telegraf/blob/master/docs/FAQ.md#q-how-can-i-monitor-the-docker-engine-host-from-within-a-container)
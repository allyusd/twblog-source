---
title: "Run GitLab Runner in a container and support docker in docker"
tags: w3HexSchool GitLab CI CD DevOps Docker
---

使用 GitLab Runner，可以選擇直接安裝，或者使用 Docker Image，也是這次範例的方式。一般設定的話，不能在這個 Runner 執行 docker in docker 的操作，下面是需要的設定。

## Register

首先是註冊 Runner，記得要準備好你的 TOKEN。

```shell
docker run --rm -v /srv/gitlab-runner/runner-01/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --description "The runner support docker in docker" \
  --docker-image alpine:latest \
  --url "https://gitlab.com/" \
  --registration-token "YOUR_TOKEN" \
  --tag-list "dind" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected" \
  --docker-privileged \
  --docker-volumes "/certs/client"
```

其中的重點在最後兩個參數，分別是 `--docker-privilleged` 提供 docker in docker 的權限，另一個是 `--docker-volumes` 設定 TLS 的憑證儲存位置

在指令一開始就有指定 `-v /srv/gitlab-runner/runner-01/config:/etc/gitlab-runner` 所以註冊後的資料會保留在 host 的 `/srv/gitlab-runner/runner-01/config` 位置

## Run

有了註冊後的 config，就可以啟動 Runner 了，跟一般的啟動方式一樣。

```shell
docker run -d --name gitlab-runner-runner-01 --restart always \
  -v /srv/gitlab-runner/runner-01/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
```

同樣因為有指定 `-v` 參數，所以會從指定的 Host 路徑讀取設定檔執行 runner。


## Ref
[Registering Runners | GitLab](https://docs.gitlab.com/runner/register/index.html#docker)
[Run GitLab Runner in a container | GitLab](https://docs.gitlab.com/runner/install/docker.html)



## TODO 如果有機會再補充的資料
.gitlab-ci-yml 範例
配合的 .gitlab-ci-yml 範例
真實的 gitlab project 範例？
可能的錯誤訊息

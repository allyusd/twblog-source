---
title: "在 GitLab 不使用 Docker-in-Docker 模式建立 Docker Image"
tags: w3HexSchool GitLab Docker
---

## 問題

當需要在 docker 中使用 docker 指令，像是建立 image 時，就會碰到 Docker-in-Docker 模式。
但是 Docekr-in-Docker 有兩個主要問題：

- 需要 privileged 權限，這會帶來安全性問題
- 效能下降

## 結果

透過 GitLab 執行，成功

![](/assets/images/2020-12-12/2020-12-13-001210.png)

## 使用 kaniko

kaniko 是 google 開發用來在 Kubernets 下建立 image 的工具。

[GoogleContainerTools/kaniko: Build Container Images In Kubernetes](https://github.com/GoogleContainerTools/kaniko)

## 在 GitLab 中的使用

GitLab 提供了整合範例，這個例子會依照該專案下的 Dockerfile 建立 Image 並且上傳到 GitLab 的 Container Registry。

```yml
build:
  stage: build
  image:
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  script:
    - mkdir -p /kaniko/.docker
    - echo "{\"auths\":{\"$CI_REGISTRY\":{\"username\":\"$CI_REGISTRY_USER\",\"password\":\"$CI_REGISTRY_PASSWORD\"}}}" > /kaniko/.docker/config.json
    - /kaniko/executor --context $CI_PROJECT_DIR --dockerfile $CI_PROJECT_DIR/Dockerfile --destination $CI_REGISTRY_IMAGE:$CI_COMMIT_TAG
  rules:
    - if: $CI_COMMIT_TAG
```

[Building images with kaniko and GitLab CI/CD - GitLab](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html)

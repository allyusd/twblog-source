---
title: "GitLab CI/CD 使用 Cache 和 artifacts"
tags: w3HexSchool GitLabCI CD DevOps
---

cache 跟 artifacts 字面上都有保存檔案供以後使用的意思，在 GitLab 使用要特別留意他們的定義

## 簡答

跨 pipeline 時使用 cache，同 pipeline 跨 job 時使用 artifacts

## 介紹

提醒一點，當你同時使用 caches 和 artifacts 在同一個路徑時，會被覆蓋

不要使用 caches 在一個 pipeline 中不同的 job 之間傳遞檔案

### Caches

caches 是設計來保存編譯或建置用所需要的依賴庫或第三方工具，像是 npm package 之類的，只要下載過一次，就可以保存，加速下次的 pipeline。

專案需要使用獨立的 caches 時，可以使用 `key`，利用像是環境變數 `CI_COMMIT_REF_SLUG` 是 branch / tag 名稱，取 63 長度，全小寫，而且只保留英數其它換成`-`，可以用在 domain 等其它地方。

舉例：

```yml
cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/
```

### Artifacts

如果是要用在同一個 pipeline, 不同 stage / job 之間傳遞的檔案，則應該使用 artifacts。使用 artifacts 時，會自動把檔案傳遞到後續的 job。

關於 cache，可以指定 `key` 讓每個 branch 有各自的 cache。

```yml
artifacts:
  paths:
    - dist/
```

[Cache dependencies in GitLab CI/CD | GitLab](https://docs.gitlab.com/ee/ci/caching/)
[Predefined environment variables reference | GitLab](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html)
[cache - GitLab CI/CD Pipeline Configuration Reference | GitLab](https://docs.gitlab.com/ee/ci/yaml/README.html#cache)
[artifacts - GitLab CI/CD Pipeline Configuration Reference | GitLab](https://docs.gitlab.com/ee/ci/yaml/README.html#artifacts)

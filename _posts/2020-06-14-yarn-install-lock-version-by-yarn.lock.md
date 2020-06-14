---
title: "使用 yarn install 指令安裝套件時鎖定 yarn.lock 版本"
tags: w3HexSchool yarn
---

## `--frozen-lockfile` 參數

當想要完全依照 yarn.lock 中指定版本安裝時，像是 CI 的時候，使用 `--frozen-lockfile` 參數

```shell
yarn install --frozen-lockfile
```

## 指定 cache 目錄

在 CI 使用的時候，可能會需要指定 yarn 的 cache 目錄，可以透過 `--cache-folder` 參數

```shell
yarn <command> --cache-folder <path>
```

## 從 npm 轉為 yarn

如果本來專案使用的是 npm，要改為 yarn 的話，必需將 package-lock.json 轉為 yarn.lock

```
yarn import
rm -rf node_modules
yarn install
```

### Ref

[yarn install | Yarn](https://classic.yarnpkg.com/en/docs/cli/install/)
[yarn cache | Yarn](https://classic.yarnpkg.com/en/docs/cli/cache)
[yarn install changes yarn.lock file · Issue #4379 · yarnpkg/yarn](https://github.com/yarnpkg/yarn/issues/4379)
[`yarn install --frozen-lockfile` should be the default behavior · Issue #4147 · yarnpkg/yarn](https://github.com/yarnpkg/yarn/issues/4147)

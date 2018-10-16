---
title: "Jenkins - Pipeline as Code - C++ 專案"
tags: 2019-iT-邦幫忙鐵人賽 Jenkins
---

接續前一篇 [Jenkins - Pipeline as Code - 第一個專案](https://twblog.hongjianching.com/2018/10/15/jenkins-pipeline-as-code-first-project/)，這次來建立 C++ 專案

因為要編譯 C++，使用 [建立擁有 C++ 編譯環境及 Jenkins Agent 的 Docker Image - Part 2](https://twblog.hongjianching.com/2018/10/13/create-cpp-compiler-with-jenkins-agent-docker-image-part-2/) 這篇所建立的環境

首先要修改的是 agent 的部份，這次要指定有 `cpp` 標籤的 agent 才能執行這個 pipeline，所以修改原本的 `agent any` 為

```
agent {
    label 'cpp'
}
```

接著是透過 `git` 指令取得原始碼，這邊同樣以 `https://github.com/allyusd/helloworld.cpp.git` 為例，然後透過 `sh` 執行編譯，修改後的 Build 階段為

```
stage('Build') {
    steps {
        echo 'Building..'
        git 'https://github.com/allyusd/helloworld.cpp.git'
        sh 'g++ helloworld.cpp -o helloworld'
    }
}
```

因為這個簡單的範例沒有 unit test，所以透過執行結果代替一下

```
stage('Test') {
    steps {
        echo 'Testing..'
        sh './helloworld'
    }
}
```

如果要使用建立好的檔案，直接把 branch 改為 `cpp`，按下建置後，會看到所有階段都成功完成

![](/assets/images/2018-10-16-jenkins-pipeline-as-code-cpp-project/2018-10-16_22-00-34.png)

接著把滑鼠移到 Build 的區域，也就是顯示 Build 花費時間 5s 的地方，會出現 Success，下方有個 `Logs` 可以點選

![](/assets/images/2018-10-16-jenkins-pipeline-as-code-cpp-project/2018-10-16_22-04-33.png)

點擊後會發現紀錄依據 Jenkinsfile 所描述的三個步驟分別折疊起來，可以依自己有興趣的部份去檢視

![](/assets/images/2018-10-16-jenkins-pipeline-as-code-cpp-project/2018-10-16_22-06-02.png)

像是 Test 階段我們有執行程式，從這裡就可以看到有輸出 `Hello World` 的結果。

![](/assets/images/2018-10-16-jenkins-pipeline-as-code-cpp-project/2018-10-16_22-08-08.png)

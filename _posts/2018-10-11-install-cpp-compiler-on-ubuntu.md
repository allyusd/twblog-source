---
title: "在 Ubuntu 安裝 C++ 編譯環境"
tags: 2019-iT-邦幫忙鐵人賽 Cpp Ubuntu
---

Ubuntu 預設沒有 C++ 編譯環境，但是可以自己安裝

不想影響現有的 host，所以叫 docker 建一個 ubuntu 出來

```bash
docker run -it ubuntu:18.04
```

安裝 C++ 編譯環境套件

```bash
apt update
apt install build-essential -y
```

可以選擇手動建立一個檔案存為 helloworld.cpp

```cpp
#include <iostream>

int main(int argc, char* argv[])
{
    std::cout << "Hello World" << std::endl;

    return 0;
}
```

或是直接透過 git clone 一份

```bash
git clone https://github.com/allyusd/helloworld.cpp.git
cd helloworld.cpp
```

如果要使用 git 的話，因為 docker 版本的 ubuntu 預設沒有安裝，記得先安裝 git 套件。

```bash
apt install git -y
```

程式碼內容很單純，就是顯示 **Hello World** 文字而己，只是驗證我們的 C++ 環境已經準備好了

接著透過 C++ 的編譯器 g++ 來編譯

```bash
g++ helloworld.cpp -o helloworld
```

建置後會產生一個 **helloworld** 的檔案，就可以執行了

```bash
./helloworld
```

看到 Hello Wolrd 就代表我們完成環境建置啦！

![](/assets/images/2018-10-11-install-cpp-compiler-on-ubuntu/2018-10-11_22-31-48.png)

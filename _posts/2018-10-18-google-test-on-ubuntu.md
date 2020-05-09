---
title: "在 Ubuntu 使用 Google Test"
tags: 2019-iT-邦幫忙鐵人賽 Google-Test Ubuntu
---

要使用 Google Test，首先要取得程式碼

原始碼可以在 [Releases · google/googletest](https://github.com/google/googletest/releases) 下載，在 Ubuntu 則可以透過 libgtest-dev 套件取得

```bash
apt install libgtest-dev -y
```

套件會安裝在 `/usr/src/gtest` 目錄下

```bash
cd /usr/src/gtest
```

透過 cmake 進行建置設定，產生 makefile

```bash
cmake CMakeLists.txt
```

最後進行建置

```bash
make
```

成功建置後會產生 libgtest.a 及 libgtest_main.a 兩個檔案

接著建立一個檔案測試一下

unittest.cpp

```cpp
#include <gtest/gtest.h>

#define HELLOWORLD "Hello World"

TEST(GoogleTest, HelloWorld) {
    ASSERT_EQ("Hello World", HELLOWORLD);
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
```

第一行引用 gtest 的 header，接著定義 HELLOWORLD 代表實際結果

Test 代表一個測試案例，HelloWorld 代表此測試案例的名稱，GoogleTest 則為多個測試案例的群組名稱，常見用法是以測試對象的 class 名稱命名。測試案例的內容可以用 ASSERT_EQ 來判斷期望值與實際值是否相等

最後一段是初始化 Google Test 及執行所有的測試案例。

寫好測試檔案，就可以進行測試程式的建置

```bash
g++ unittest.cpp -o unittest -Igtest/include -Lgtest/lib -lgtest -lpthread
```

建置成功後，執行測試程式

```bash
./unittest
```

測試結果

![](/assets/images/2018-10-18-google-test-on-ubuntu/2018-10-18_22-46-15.png)

---
title: "在 Ubuntu 安裝 SDL2 和 C++"
tags: Cpp SDL2 Ubuntu
---

# Install SDL2 on Ubuntu

可以簡單的從套件安裝或是自行編譯[^1].

[^1]: [HOW TO SET UP SDL2 ON LINUX](http://gigi.nullneuron.net/gigilabs/how-to-set-up-sdl2-on-linux/)

```shell
sudo apt-get install libsdl2-dev
```

# SDL2 example code with C++

這段範例程式基於 SDL2 文件，額外加上了 C++ 函式庫。

[^2]: [SDL2 document - SDL_Init](https://wiki.libsdl.org/SDL_Init)

```cpp
#include "SDL.h"
#include <iostream>

int main(int argc, char* argv[])
{
    if (SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO) != 0) {
        SDL_Log("Unable to initialize SDL: %s\n", SDL_GetError());
        return 1;
    }

    std::cout << "Hello SDL2 with C++" <<std::endl;

    SDL_Quit();

    return 0;
}
```

# Build example code

```shell
g++ -I /usr/include/SDL2 main.cpp -o sdl-test -lSDL2 -lSDL2main
```

Note: [See Where a Package is Installed on Ubuntu](https://www.howtogeek.com/howto/ubuntu/see-where-a-package-is-installed-on-ubuntu/)

# Run the exmaple

```shell
./sdl-test
```

如果執行正確的話，你會看到如下所示：

![demo image](/assets/images/2017-04-03-install-sdl2-and-build-example-with-c++-on-ubuntu/demo.png)

# Other

如果你在 Ubuntu Server 下執行的話，可能會出現錯誤：

```
Unable to initialize SDL: Failed to connect to the Mir Server
```

因為這段範例有初始化 SDL_INIT_VIDEO 子系統，如果你不需要用到可以移除他。
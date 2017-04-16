---
title: "Install SDL2 with Cpp on Ubuntu"
tags: post
---

# Install SDL2 on Ubuntu

You can easy install from package or build self[^1].

[^1]: [HOW TO SET UP SDL2 ON LINUX](http://gigi.nullneuron.net/gigilabs/how-to-set-up-sdl2-on-linux/)

```shell
sudo apt-get install libsdl2-dev
```

# SDL2 example code with C++

The example code base on SDL2 document[^2], add C++ libary.

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

If the process is correct, you will see that:

![demo image](/assets/images/2017-04-03-install-sdl2-and-build-example-with-c++-on-ubuntu/demo.png)

# Other

If you running it on ubuntu server, maybe show error:

```
Unable to initialize SDL: Failed to connect to the Mir Server
```

Because example have init SDL_INIT_VIDEO subsystem, you can remove it if you don't need it.

# imgui-pack

Just a quikly made repository created to package imgui library into DEB (but _should_ work on other systems / packages too, with emscripten you need to disable PIC flag I suppose).
Checkout this repo with submodules (or clone and execute in repository `git submodule update -f --init` to fetch imgui code).
You can use `create_deb.sh` script to compile & package it.

Manualy you need to copy/link CMakeLists.txt file inside and then you can use cmake && make to build and `cpack -G "DEB"` to generate debian package
that you can install with `sudo dpkg -i imgui*.deb`. Note I don't include imgui demo code.

After installation you should be able to use cmake to find imgui and link `imgui::imgui`.


# jianplayer

> JianPlayer ——  A simple player ——  简播放器

#### Build Setup

# install libmpv1(must to be installed first)

Choose your system:

    Windows: download [mpv-dev](https://mpv.srsfckn.biz/mpv-dev-latest.7z), unpack, put corresponding `mpv-1.dll` to `C:\Windows\system32`
    macOS: `brew install mpv`
    Linux: `apt-get install libmpv1`

If libmpv1 is not in your apt, on latest ubuntu version(see 16.04+), do:

    sudo add-apt-repository ppa:mc3man/mpv-tests
    sudo apt-get update
    sudo apt-get install libmpv1

On old ubuntu,

From

https://github.com/u8sand/Baka-MPlayer/issues/125

and

https://launchpad.net/~mc3man/+archive/ubuntu/testing6

We known this:

    sudo add-apt-repository ppa:mc3man/testing6
    sudo apt-get update
    sudo apt-get install libmpv1 libmpv-dev

Or build it yourself: https://github.com/mpv-player/mpv-build#instructions-for-debian-and-ubuntu

mpv related install over.

# install mpv.js dependency

The official mpv.js use its prebuild mpvjs.node, but this doesn't work on my ubuntu:(

So, we should build mpvjs node bindings myself.

From index.cc, we known:

```
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <string>
#include <vector>
#include <unordered_map>
#define GL_GLEXT_PROTOTYPES
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <ppapi/cpp/module.h>
#include <ppapi/cpp/instance.h>
#include <ppapi/cpp/var.h>
#include <ppapi/cpp/var_dictionary.h>
#include <ppapi/cpp/graphics_3d.h>
#include <ppapi/lib/gl/gles2/gl2ext_ppapi.h>
#include <ppapi/utility/completion_callback_factory.h>
#include <mpv/client.h>
#include <mpv/opengl_cb.h>
```

So, first for GLES2:

    sudo apt-get install libgles2-mesa-dev

Second, ppapi:

Download nacl_sdk:

go：https://developer.chrome.com/native-client/sdk/download

or download directly：

    wget https://storage.googleapis.com/nativeclient-mirror/nacl/nacl_sdk/nacl_sdk.zip

BUT!BUT!BUT! My google is blocked by China GFW.

So, we should use proxy, so change some code of nacl_sdk tool:

add your proxy to this line: `sdk_tools/download.py:22` (keyword search: Proxy):

```
fancy_urllib.FancyProxyHandler({'http': 'http://127.0.0.1:4411', 'https': 'http://127.0.0.1:4411'})
```


``` bash
# install dependencies
yarn

# serve with hot reload at localhost:9080
yarn run dev

# build electron application for production
yarn run build

# run unit & end-to-end tests
yarn test

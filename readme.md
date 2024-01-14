##  Easylang

Easylang is a simple open-source programming language with built-in graphical features and a user-friendly browser IDE that can be used also offline. It was developed to make learning to program as easy and accessible as possible. You can also use Easylang to write simple graphical programs that can be embedded in a web page.

~~~
# animate a pendulum
ang = 45
on animate
   clear
   move 50 50
   circle 1
   x = 50 + 40 * sin ang
   y = 50 + 40 * cos ang
   line x y
   circle 6
   vel += sin ang / 5
   ang += vel
end
~~~

## Website

**[easylang.dev](https://easylang.dev/)**

**[easylang.online](https://easylang.online/)**

**[chkas.github.io](https://chkas.github.io/)**

## Build in Linux and MacOS

### Dependencies

MacOS: Xcode Command Line Tools

JDK, Emscripten

Download Emscripten WASM SDK and install it

~~~
curl -L https://github.com/emscripten-core/emsdk/archive/refs/heads/main.zip -o main.zip
unzip -q main.zip
mv emsdk-main emsdk
~~~

Install and activate a tested version

~~~
source emsdk/emsdk_env.sh
emsdk update ; emsdk list
# vers=latest
vers=3.1.51
emsdk install $vers ; emsdk activate $vers
~~~

### Build and test

~~~
curl -L https://github.com/chkas/easylang/archive/refs/heads/main.zip -o main.zip
unzip -q main.zip
mv easylang-main easylang
~~~

The destination folder is ~/out/easylang. Needs Java for the *closure-compiler*.

~~~
source emsdk/emsdk_env.sh
( cd easylang/main ; make )
~~~

Test it locally

~~~
(cd ~/out/easylang/;python3 -m http.server)
~~~

[localhost:8000/ide/](http://localhost:8000/ide/)

## Build with Github Actions

[github.com/chkas/chkas.github.io](https://github.com/chkas/chkas.github.io)

## Build native version

~~~
easylang/native/readme.md
~~~


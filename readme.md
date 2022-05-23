##  easylang.online

An easy programming language that runs in the browser

### Website

**[easylang.online](https://easylang.online/)**

## Build in Linux

### Dependencies

Download Emscripten SDK and install it

~~~
rm -f main.zip
wget https://github.com/emscripten-core/emsdk/archive/refs/heads/main.zip
unzip main.zip
mv emsdk-main emsdk
~~~

Install and activate latest SDK version

~~~
source emsdk/emsdk_env.sh
emsdk update ; emsdk list
emsdk install latest ; emsdk activate latest
~~~

### Build

~~~
rm -f main.zip
wget https://github.com/chkas/easylang/archive/refs/heads/main.zip
unzip main.zip
mv easylang-main easylang
~~~

The destination folder is ~/out/easylang

~~~
source emsdk/emsdk_env.sh
cd easylang/main/web 
make
~~~

Test it locally

~~~
(cd ~/out/easylang/;python3 -m http.server)
~~~

~~~
firefox localhost:8000/ide.html
~~~

### Build release

Uses the *closure-compiler* (needs *Java*).

~~~
cd easylang/main/web ; make ide
~~~

~~~
firefox localhost:8000/ide/
~~~

### Native version

~~~
easylang/main/native/readme.md
~~~


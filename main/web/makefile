# source $HOME/emsdk/emsdk_env.sh

v = 257

#--------------------------------------------------------------------

#CC = emcc -g -gsource-map -s -Wall 
#LD = emcc -g -gsource-map --source-map-base=http://localhost:8000/ -s WASM=1 -s EXPORTED_FUNCTIONS="['_parse','_exec','_format', '_errstr', '_k_free', '_caret', '_evt_mouse', '_evt_func', '_main']" -s EXPORTED_RUNTIME_METHODS="['ccall']" -s ALLOW_MEMORY_GROWTH=1
CC = emcc -O3 -Wall
LD = emcc -O3 -s WASM=1 -s EXPORTED_FUNCTIONS="['_parse','_exec','_format', '_errstr', '_k_free', '_caret', '_evt_mouse', '_evt_func', '_main']" -s EXPORTED_RUNTIME_METHODS="['ccall']" -s ALLOW_MEMORY_GROWTH=1
CLOSURE = java -jar ~/emsdk/upstream/emscripten/node_modules/google-closure-compiler-java/compiler.jar

o = $(HOME)/out/easylang

all: $(o) main tut csrc
csrc: $(o)/kafunc.h $(o)/kalex.h $(o)/kalib.h $(o)/kabasw.h $(o)/kabas.c

$(o):
	mkdir -p $(o)

main: $(o)/easy_ide.js $(o)/easyw.js $(o)/easy.js $(o)/ide.html
tut: $(o)/tut_id.js $(o)/tut_docu.js $(o)/tut_learn.js $(o)/tut_mcarlo.js $(o)/tut_game.js $(o)/tut_sorting.js $(o)/tut_func.js

$(o)/%.o: $(o)/%.c $(o)/kalib.h $(o)/kalex.h $(o)/kafunc.h $(o)/kabasw.h
	$(CC) -c $< -o $@

$(o)/easyw.js: $(o)/kabas.o kabasw.js
	$(LD) --post-js kabasw.js $(o)/kabas.o -o $@

$(o)/%.c: ../%.c
	cp -p $< $@

$(o)/%.h: ../web/%.h
	cp -p $< $@

$(o)/%.h: ../%.h
	cp -p $< $@

$(o)/%: %
	cp -p $< $@

#--------------------------------------------------------------------

or = $(o)/ide

clean:
	rm -rf $(or)/2 $(or)/tmp $(o)/apps/* $(o)/run/*
	rm -f $(o)/*.* $(or)/*

ide: all $(or)/2 apps mainr tutr extr
release: ide
rel: ide

$(or)/2:
	mkdir -p $(or) $(or)/2

apps: $(or)/easyw.js $(or)/easy.js
mainr: $(or)/index.html $(or)/2/index.html $(or)/icon.png $(or)/sw.js $(or)/mfst.json $(or)/easyw$(v).js $(or)/wvers
tutr: $(or)/tut_id$(v).js $(or)/tut_docu$(v).js $(or)/tut_learn$(v).js $(or)/tut_mcarlo$(v).js $(or)/tut_game$(v).js $(or)/tut_sorting$(v).js $(or)/tut_func$(v).js
extr: $(or)/vers_easy.js

$(or)/easyw.js: $(o)/easyw.js
	cp -p $(o)/easyw.wasm  $(or)/
	$(CLOSURE) --js $< --js_output_file $@ --jscomp_off "*"

$(or)/easy.js: easy.js
	$(CLOSURE) --compilation_level ADVANCED --js $< --js_output_file $@

$(or)/%: %
	cp -p $< $@

$(or)/tut_%$(v).js: tut_%.js
	cp -p $< $@

$(or)/tut_id$(v).js: tut_id.js
	echo "const VERS = '$v'" >$@
	tail +2 $< >>$@

#$(or)/easyw$(v).js: $(o)/kabas.o kabasw.js
$(or)/easyw$(v).js: $(o)/kabas.o kabasw.js makefile
	echo "console.log('easylang.online v$v - free to use - christof.kaser@gmail.com')" >$(o)/tmp_kabasw.js
	cat kabasw.js >>$(o)/tmp_kabasw.js
	$(LD) --post-js $(o)/tmp_kabasw.js $(o)/kabas.o -o $@
	rm $(o)/tmp_kabasw.js

$(or)/wvers: makefile
	echo $v > $(or)/wvers

#$(or)/tmp_ide.js: easy_ide.js easy.js
$(or)/tmp_ide.js: easy_ide.js easy.js makefile
	echo "const WORKER = 'easyw$v.js'" >$(or)/tmp.js
	tail +2 easy.js >>$(or)/tmp.js
	cat easy_ide.js >>$(or)/tmp.js
	$(CLOSURE)  --compilation_level ADVANCED --js $(or)/tmp.js --js_output_file $@


$(or)/index.html: $(or)/ide.html $(or)/tmp_ide.js
	head -n -5 $(or)/ide.html >$@
	echo "<script src=tut_id$(v).js></script>" >>$@
	echo "<script>" >>$@
	cat swreg.js >>$@
	cat $(or)/tmp_ide.js >>$@
	echo "</script>" >>$@

$(or)/2/index.html: $(or)/ide.html $(or)/tmp_ide.js
	head -n -3 $(or)/ide.html >$@
	echo "<script>" >>$@
	cat $(or)/tmp_ide.js >>$@
	echo "</script>" >>$@

$(or)/sw.js: sw.js $(or)/index.html $(or)/easyw$(v).js makefile
	echo "const CACHE = 'd$(shell date +%y%m%d-%H%M)'" >$@
	echo "const VERS = '$v'" >>$@
	tail +3 sw.js >>$@

#--------------------------------------------------------------------
$(or)/vers_easy.js: easy.js makefile
	echo "const WORKER = 'easyw$v.js'" >$(or)/tmp.js
	tail +2 easy.js >>$(or)/tmp.js
	$(CLOSURE) --compilation_level ADVANCED --js $(or)/tmp.js --js_output_file $@



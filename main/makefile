# source $HOME/emsdk/emsdk_env.sh

include ../vers.txt

#--------------------------------------------------------------------
# DBG = true

CC = emcc -O3 -Wall

LDOPT := -sSTACK_SIZE=2MB
ifeq ($(shell echo $(shell cd /tmp;emcc -sSTACK_SIZE=2MB 2>&1 | wc -l)), 4)
	LDOPT := ""
endif

LD = emcc -O3 -s WASM=1 -s EXPORTED_FUNCTIONS="['_parse','_exec','_format', '_errstr', '_k_free', '_caret', '_evt_mouse', '_evt_func', '_main']" -s EXPORTED_RUNTIME_METHODS="['ccall']" -s ALLOW_MEMORY_GROWTH=1 $(LDOPT)

ifeq ($(DBG), true)
	CC := $(CC) -g -gsource-map
	LD := $(LD) -g -gsource-map --source-map-base=http://localhost:8000/
endif

ifeq ($(origin EMSDK),undefined)
	CLOSURE = java -jar $(HOME)/closure-compiler.jar
else
	CLOSURE = java -jar $(EMSDK)/upstream/emscripten/node_modules/google-closure-compiler-java/compiler.jar
endif

#CLOSOPT = --language_in=ECMASCRIPT5_STRICT --compilation_level ADVANCED
CLOSOPT = --compilation_level ADVANCED

out := $(HOME)/out/easylang
wrk := $(out)/wrk
csrcf := $(wrk)/kabas.c $(wrk)/kafunc.h $(wrk)/kalex.h $(wrk)/kalib.h $(wrk)/kabasw.h $(wrk)/kaparse.h $(wrk)/kawasm.h

all: ide

basic: $(wrk) main tut csrc

csrc: $(csrcf)

$(wrk):
	mkdir -p $(wrk)

main: $(wrk)/easy_ide.js $(wrk)/easyw.js $(wrk)/easy.js $(wrk)/ide.html
tut: $(wrk)/tut_id.js $(wrk)/tut_docu.js $(wrk)/tut_learn.js $(wrk)/tut_game.js $(wrk)/tut_func.js

$(wrk)/kabas.o: $(csrcf)
	$(CC) -c $< -o $@

$(wrk)/easyw.js: $(wrk)/kabas.o kabasw.js
	$(LD) --post-js kabasw.js $(wrk)/kabas.o -o $@

$(wrk)/%: %
	cp -p $< $@

#--------------------------------------------------------------------

or = $(out)/ide
apps = $(out)/apps

clean:
	rm -rf $(out)/wrk $(out)/ide $(out)/apps $(out)/run

ide: basic dirs apps mainr tutr extr
release: ide
rel: ide

dirs: $(apps) $(or)

$(apps):
	mkdir -p $@

$(or):
	mkdir -p $@

apps: $(apps)/easyw.js $(apps)/easy.js $(apps)/easy_code2.js

mainr: $(or)/index.html $(or)/icon.png $(or)/sw.js $(or)/mfst.json $(or)/easyw$(v).js $(wrk)/wvers
tutr: $(or)/tut_id$(v).js $(or)/tut_docu$(v).js $(or)/tut_learn$(v).js $(or)/tut_game$(v).js $(or)/tut_func$(v).js
extr: $(wrk)/vers_easy.js $(wrk)/vers_easy_code.js

$(apps)/easyw.js: $(wrk)/easyw.js
	cp -p $(wrk)/easyw.wasm  $(apps)/
	$(CLOSURE) --js $< --js_output_file $@ --jscomp_off "*"

$(apps)/easy.js: easy.js
	$(CLOSURE)  $(CLOSOPT) --js $< --js_output_file $@

$(apps)/easy_code2.js: easy.js ../apps/easy_code.js
	cat easy.js >$(wrk)/tmp.js
	cat ../apps/easy_code.js >>$(wrk)/tmp.js
	$(CLOSURE)  $(CLOSOPT) --js $(wrk)/tmp.js --js_output_file $@

$(or)/%: %
	cp -p $< $@

$(or)/tut_%$(v).js: tut_%.js
	cp -p $< $@

$(or)/tut_id$(v).js: tut_id.js
	echo "const VERS = '$v'" >$@
	tail +2 $< >>$@

$(or)/easyw$(v).js: $(wrk)/kabas.o kabasw.js
#$(or)/easyw$(v).js: $(wrk)/kabas.o kabasw.js ../vers.txt
	echo "console.log('Easylang v$v - free to use - christof.kaser@gmail.com')" >$(wrk)/tmp_kabasw.js
	cat kabasw.js >>$(wrk)/tmp_kabasw.js
	$(LD) --post-js $(wrk)/tmp_kabasw.js $(wrk)/kabas.o -o $@
	rm $(wrk)/tmp_kabasw.js

$(wrk)/wvers: ../vers.txt
	echo $v > $(wrk)/wvers

#$(or)/tmp_ide.js: easy_ide.js easy.js
$(wrk)/tmp_ide.js: easy_ide.js easy.js ../vers.txt
	echo "const WORKER = 'easyw$v.js'" >$(wrk)/tmp.js
	tail +2 easy.js >>$(wrk)/tmp.js
	cat easy_ide.js >>$(wrk)/tmp.js
	$(CLOSURE) $(CLOSOPT) --js $(wrk)/tmp.js --js_output_file $@


$(or)/index.html: $(wrk)/ide.html $(wrk)/tmp_ide.js
	# head -n -5 $(wrk)/ide.html >$@
	head -n $(shell expr $(shell wc -l<$(wrk)/ide.html) - 5) $(wrk)/ide.html | sed s:/apps/:/apps/?v=$(v):g >$@
	#head -n $(shell expr $(shell wc -l<$(wrk)/ide.html) - 5) $(wrk)/ide.html >$@
	echo "<script src=tut_id$(v).js></script>" >>$@
	echo "<script>" >>$@
	cat swreg.js >>$@
	cat $(wrk)/tmp_ide.js >>$@
	echo "</script>" >>$@

$(or)/sw.js: sw.js $(or)/index.html $(or)/easyw$(v).js ../vers.txt
	echo "const CACHE = 'd$(shell date +%y%m%d-%H%M)'" >$@
	echo "const VERS = '$v'" >>$@
	tail +3 sw.js >>$@

#--------------------------------------------------------------------
$(wrk)/vers_easy.js: easy.js ../vers.txt
	echo "const WORKER = 'easyw$v.js'" >$(or)/tmp.js
	tail +2 easy.js >>$(or)/tmp.js
	$(CLOSURE) $(CLOSOPT) --js $(or)/tmp.js --js_output_file $@

$(wrk)/vers_easy_code.js: easy.js ../apps/easy_code.js ../vers.txt
	echo "const WORKER = 'easyw$v.js'" >$(or)/tmp.js
	tail +2 easy.js >>$(or)/tmp.js
	cat ../apps/easy_code.js >>$(or)/tmp.js
	$(CLOSURE) $(CLOSOPT) --js $(or)/tmp.js --js_output_file $@



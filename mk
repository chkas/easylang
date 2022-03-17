#!/bin/sh
cd main/web
if test "$1" = clean; then
	make clean
else
	test "$1" = new && make clean
	make ide
	cd ../../apps
	./mk
	cd ../run
	./mk
	./mk_list
fi
cd ..
rm -f /u/out/easylang/main_src.zip
zip -r /u/out/easylang/main_src.zip main run >/dev/null
rm -f /u/out/easylang/apps_src.zip
zip -r /u/out/easylang/apps_src.zip apps >/dev/null


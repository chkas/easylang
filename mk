#!/bin/sh
if test "$1" = fast -o "$1" = f; then
	(cd main; make basic)
	exit 0
fi
if test "$1" = clean; then
	(cd main; make clean)
	exit 0
fi
if test "$1" = new; then
	(cd main; make clean)
	shift
fi
if test $# = 0; then
	set main apps games sky
	emcc --version >$HOME/out/easylang/emcc_vers.txt
fi
while test $# != 0; do
	if test $1 = main; then
		(cd main; make)
		(cd run; ./mk)
		rm -f $HOME/out/easylang/src.zip
		zip -r $HOME/out/easylang/src.zip ide run native misc/emcc_vers.txt >/dev/null
	elif test $1 = apps; then
		(cd main; make)
		(cd apps; ./mk)
		rm -f $HOME/out/easylang/apps_src.zip
		zip -r $HOME/out/easylang/apps_src.zip apps >/dev/null
	elif test $1 = games; then
		(cd run; ./mk_games)
	elif test $1 = sky; then
		(cd misc/sky; ./mk)
	fi
	shift
done


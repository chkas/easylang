#!/bin/sh
if test "$1" = fast -o "$1" = f; then
	(cd ide; make)
	exit 0
fi
if test "$1" = clean; then
	(cd ide; make clean)
	exit 0
fi
if test "$1" = new; then
	(cd ide; make clean)
	shift
fi
if test $# = 0; then
	set ide apps games sky
fi
while test $# != 0; do
	if test $1 = ide; then
		(cd ide; make ide)
		(cd run; ./mk)
		rm -f /u/out/easylang/src.zip
		zip -r /u/out/easylang/src.zip ide run native >/dev/null
	elif test $1 = apps; then
		(cd ide; make ide)
		(cd apps; ./mk)
		rm -f /u/out/easylang/apps_src.zip
		zip -r /u/out/easylang/apps_src.zip apps >/dev/null
	elif test $1 = games; then
		(cd run; ./mk_games)
	elif test $1 = sky; then
		(cd misc/sky; ./mk)
	fi
	shift
done


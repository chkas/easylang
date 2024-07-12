./tasks.py | while read n; do
	test "$n" = "" && break
	echo "$n" >&2
	expr "$n" : '.$' >/dev/null && continue
	expr "$n" : '#' >/dev/null && continue
	test "$n" = "Hello world/Newbie" && continue
	test "$n" = "Here document" && continue
	x=$(echo $n|tr " " _)
	dest=$(echo $n|tr " /" _+)
	dest=~/easylang/misc/ros/"$dest.el"
	if test ! -e "$dest"; then
		echo "..." >&2
		curl -s "https://rosettacode.org/wiki/$x" | ./rosget.awk > "$dest"
		if test $(du "$dest" | cut -f1) = 0; then
			echo " -> 0 bytes"
			rm "$dest"
			echo ""
		fi
	fi
done


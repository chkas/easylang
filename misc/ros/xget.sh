./tasks.py | while read n; do
	test "$n" = "" && break
	echo "$n" >&2
	x=$(echo $n|tr " " _)

	curl -s "https://rosettacode.org/wiki/$x" | grep "<syntaxhighlight>" 
done


./tasks.py | while read n; do
	test "$n" = "Hello world/Newbie" && continue
	test "$n" = "Here document" && continue
	x=$(echo $n|tr " " _)
	dest=$(echo $n|tr " /" _+)
	echo $dest.el >> /tmp/_tasks_$$.txt
done
sort </tmp/_tasks_$$.txt >_tasks.txt
rm /tmp/_tasks_$$.txt

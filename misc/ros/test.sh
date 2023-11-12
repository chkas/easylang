for i in *.el; do
	echo "$i" >&2
	echo "-------------------   $i  ---------------"
	if grep input $i >/dev/null; then
		if ! grep input_data $i >/dev/null; then
			continue
		fi
	fi
	test "$i" = "Find_limit_of_recursion.el" && continue
	test "$i" = "Loops+Infinite.el" && continue
	r $i
done
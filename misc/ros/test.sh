#!/bin/sh

for i in *.el; do
	echo "-------  $i  -------"
	echo "-------  $i  -------" >&2
	test $i = 99_bottles_of_beer.el && continue
	test $i = Cuban_primes.el && continue
	test $i = Execute_HQ9+.el && continue
	test $i = Find_limit_of_recursion.el && continue
	test $i = Humble_numbers.el && continue
	test $i = Loops+Infinite.el && continue
	test $i = Ormiston_triples.el && continue
	test $i = Rare_numbers.el && continue
	test $i = Self_numbers.el && continue

	grep "gline " $i >/dev/null && continue
	grep "on mouse" $i >/dev/null && continue
	grep "on animation" $i >/dev/null && continue
	grep "on timer" $i >/dev/null && continue
	grep "gcircle " $i >/dev/null && continue
	grep "grect " $i >/dev/null && continue
	grep "gtext " $i >/dev/null && continue
	grep "gpolygon " $i >/dev/null && continue
	grep "keybkey " $i >/dev/null && continue
	if grep " input" $i >/dev/null; then
 		grep input_data $i >/dev/null || continue
	fi
	grep " random" $i >/dev/null && continue
	r $i
done

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

	if grep " input" $i >/dev/null; then
 		grep input_data $i >/dev/null || continue
	fi
	grep " random" $i >/dev/null && continue
	r $i
done

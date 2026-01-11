inf = 1 / 0
minus_inf = -1 / 0
minus_zero = -1 / inf
nan = 0 / 0
#
# -0 becomes to "0" when converting it to a string
#
print "positive  infinity: " & inf
print "negative infinity: " & minus_inf
print "negative zero: " & minus_zero
print "not a number: " & nan
print ""
print "+inf + 2 = " & inf + 2
print "+inf - 10.1 = " & inf - 10.1
print "+inf + -inf = " & inf + minus_inf
print "0 * +inf = " & 0 * inf
print "1/-0 = " & 1 / minus_zero
print "nan + 1 = " & nan + 1
print "nan + nan = " & nan + nan
print ""
print "nan == nan = " & if nan = nan
print "0 = -0 = " & if 0 = minus_zero

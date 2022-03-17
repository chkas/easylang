# AoC-15 - Day 25: Let It Snow
# 
s$[] = strsplit input " "
trow = number s$[16]
tcol = number s$[18]
row0 = 1
row = 1
cod = 20151125
repeat
  if row = 1
    row0 += 1
    row = row0
    col = 1
  else
    row -= 1
    col += 1
  .
  cod = cod * 252533 mod 33554393
  until row = trow and col = tcol
.
print cod
# 
input_data
To continue, please consult the code grid in the manual.  Enter the code at row 2978, column 3083.


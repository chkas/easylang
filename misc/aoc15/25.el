# AoC-15 - Day 25: Let It Snow
# 
s$[] = strsplit input " "
xrow = number s$[17]
xcol = number s$[19]
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
   until row = xrow and col = xcol
.
print cod
# 
input_data
To continue, please consult the code grid in the manual.  Enter the code at row 100, column 100.


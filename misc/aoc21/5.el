# AoC-21 - Day 5: Hydrothermal Venture
# 
# Make a point grid and and add up the
# points as you draw lines. To avoid
# having to distinguish between vertical,
# horizontal, diagonal and direction,
# calculate the horizontal and vertical
# steps.
# 
len m[] 1000 * 1000
len m2[] 1000 * 1000
repeat
   s$ = input
   until s$ = ""
   a$[] = strsplit s$ " "
   a[] = number strsplit a$[1] ","
   b[] = number strsplit a$[3] ","
   x = a[1]
   y = a[2]
   incx = sign (b[1] - a[1])
   incy = sign (b[2] - a[2])
   repeat
      if incx = 0 or incy = 0
         m[x + 1000 * y + 1] += 1
      .
      m2[x + 1000 * y + 1] += 1
      until x = b[1] and y = b[2]
      x += incx
      y += incy
   .
.
for m in m[]
   sum += if m >= 2
.
print sum
sum = 0
for m in m2[]
   sum += if m >= 2
.
print sum
# 
# 
input_data
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2



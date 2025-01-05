# AoC-20 - Day 5: Binary Boarding
#
len ids[] 1024
repeat
   s$ = input
   until s$ = ""
   s$[] = strchars s$
   id = 0
   for i to 10
      id *= 2
      if s$[i] = "B" or s$[i] = "R" : id += 1
   .
   if id > max_id : max_id = id
   ids[id + 1] = 1
.
id = 2
print max_id
repeat
   if id > len ids[]
      print "error not found"
      break 1
   .
   until ids[id] = 0 and ids[id - 1] = 1 and ids[id + 1] = 1
   id += 1
.
print id - 1
#
input_data
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
FFFBBBFRLR


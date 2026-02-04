# AoC-17 - Day 12: Digital Plumber
#
len r[][] 2000
#
repeat
   s$ = input
   until s$ = ""
   s$[] = strsplit s$ " "
   for i = 3 to len s$[]
      r[number s$[1]][] &= number s$[i]
   .
   n += 1
.
len con[] n
for i range0 n
   if con[i] = 0
      groups += 1
      todo[] = [ i ]
      while len todo[] > 0
         ind = len todo[]
         n = todo[ind]
         len todo[] ind - 1
         if con[n] = 0
            con[n] = 1
            for h in r[n][]
               if con[h] = 0
                  todo[] &= h
               .
            .
         .
      .
   .
   if i = 0
      for v in con[] : sum += v
      print sum
   .
.
print groups
#
input_data
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5


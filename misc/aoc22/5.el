# AoC-22 - Day 5: Supply Stacks
# 
s$ = input
n = (len s$ + 1) div 4
len st$[][] n
while substr s$ 2 1 <> "1"
   for i = 1 to n
      h$ = substr s$ 4 * i - 2 1
      if h$ <> " "
         st$[i][] &= h$
      .
   .
   s$ = input
.
for i = 1 to n
   l = len st$[i][]
   for j = 1 to l div 2
      h$ = st$[i][j]
      st$[i][j] = st$[i][l - j + 1]
      st$[i][l - j + 1] = h$
   .
.
st0$[][] = st$[][]
# 
s$ = input
repeat
   s$ = input
   until s$ = ""
   a[] = number strsplit s$ " "
   m[] &= a[1] ; m[] &= a[2] ; m[] &= a[3]
   #kc m[] &= a[2] ; m[] &= a[4] ; m[] &= a[6]
.
for part = 1 to 2
   for k = 1 step 3 to len m[]
      n = m[k] ; a = m[k + 1] ; b = m[k + 2]
      for i = 1 to n
         h = len st$[a][] - i + 1
         if part = 2
            h = len st$[a][] - n + i
         .
         h$ = st$[a][h]
         st$[b][] &= h$
      .
      len st$[a][] -n
   .
   for i = 1 to len st$[][]
      write st$[i][len st$[i][]]
   .
   print ""
   swap st$[][] st0$[][]
.
# 
input_data
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2


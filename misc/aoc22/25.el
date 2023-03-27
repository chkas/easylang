# AoC-22 - Day 25:  Full of Hot Air
# 
repeat
   a$[] = strchars input
   until len a$[] = 0
   n = 0
   for c$ in a$[]
      if c$ = "-"
         c = -1
      elif c$ = "="
         c = -2
      else
         c = number c$
      .
      n = n * 5 + c
   .
   sum += n
.
while sum > 0
   d = sum mod 5
   if d = 3
      o$[] &= "="
   elif d = 4
      o$[] &= "-"
   else
      o$[] &= d
   .
   if d >= 3
      sum += 5
   .
   sum = sum div 5
.
for i = len o$[] downto 1
   write o$[i]
.
print ""
# 
input_data
1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122



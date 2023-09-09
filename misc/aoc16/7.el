# AoC-16 - Day 7: Internet Protocol Version 7 
# 
proc test1 s$ . in .
   in = 0
   s$[] = strchars s$
   for i to len s$[]
      c4$ = c3$
      c3$ = c2$
      c2$ = c1$
      c1$ = s$[i]
      if c1$ = "["
         insqu = 1
      elif c1$ = "]"
         insqu = 0
      .
      if c4$ & c3$ = c1$ & c2$ and c1$ <> c2$
         if insqu = 0
            in = 1
         else
            in = 0
            break 1
         .
      .
   .
.
proc test2 s$ . ret .
   ret = 0
   len f1[] 26 * 26
   len f2[] 26 * 26
   s$[] = strchars s$
   for i to len s$[]
      c1$ = c2$
      c2$ = c3$
      c3$ = s$[i]
      if c3$ = "[" or c3$ = "]"
         if c3$ = "["
            insqu = 1
         else
            insqu = 0
         .
      .
      if c1$ = c3$ and c1$ <> c2$
         h1 = strcode c1$ - 97
         h2 = strcode c2$ - 97
         if h1 >= 0 and h2 >= 0
            if insqu = 0
               f1[h1 * 26 + h2 + 1] = 1
            else
               f2[h2 * 26 + h1 + 1] = 1
            .
         .
      .
   .
   for i to 26 * 26
      if f1[i] = 1 and f2[i] = 1
         ret = 1
      .
   .
.
repeat
   s$ = input
   until s$ = ""
   test1 s$ r
   sum1 += r
   test2 s$ r
   sum2 += r
.
print sum1
print sum2
# 
input_data
abba[mnop]qrst
abcd[bddb]xyyx
aaaa[qwer]tyui
ioxxoj[asdfgh]zxcvbn
aba[bab]xyz
xyx[xyx]xyx
aaa[kek]eke
zazbz[bzb]cdb




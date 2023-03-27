# AoC-20 - Day 6: Custom Customs
# 
repeat
   s$ = input
   until s$ = "" and sp$ = ""
   inp$[] &= s$
   sp$ = s$
.
# 
# Part 1 
# 
len a[] 26
inp = 1
while inp <= len inp$[]
   repeat
      s$ = inp$[inp]
      until s$ = ""
      for c$ in strchars s$
         a[strcode c$ - strcode "a" + 1] = 1
      .
      inp += 1
   .
   for i to 26
      sum1 += a[i]
      a[i] = 0
   .
   inp += 1
.
print sum1
# 
# Part 2 
# 
len b[] 26
for i to 26
   a[i] = 1
.
inp = 1
while inp <= len inp$[]
   repeat
      s$ = inp$[inp]
      until s$ = ""
      for c$ in strchars s$
         b[strcode c$ - strcode "a" + 1] = 1
      .
      for i to 26
         a[i] *= b[i]
         b[i] = 0
      .
      inp += 1
   .
   for i to 26
      sum2 += a[i]
      a[i] = 1
   .
   inp += 1
.
print sum2
# 
input_data
abc

a
b
c

ab
ac

a
a
a
a

b


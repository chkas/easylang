# AoC-15 - Day 17: No Such Thing as Too Much
# 
repeat
   s$ = input
   until s$ = ""
   n[] &= number s$
.
destsum = 150
if len n[] <= 5
   destsum = 25
.
global n_comb nmin .
minsel = 1 / 0
proc gsum pos sum sel . .
   if sum = destsum
      n_comb += 1
      if sel <= minsel
         if sel < minsel
            minsel = sel
            nmin = 0
         .
         nmin += 1
      .
   elif pos <= len n[]
      if sum + n[pos] <= destsum
         gsum pos + 1 sum + n[pos] sel + 1
      .
      gsum pos + 1 sum sel
   .
.
gsum 1 0 0
print n_comb
print nmin
# 
input_data
20
15
10
5
5



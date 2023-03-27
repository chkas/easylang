# AoC-16 - Day 10: Balance Bots
# 
n = 256
len bh[] n
len bl[] n
len bv[] n
len out[] 24
arrbase bh[] 0
arrbase bl[] 0
arrbase bv[] 0
arrbase out[] 0
# 
repeat
   inp$ = input
   until inp$ = ""
   inp$[] = strsplit inp$ " "
   if inp$[1] = "value"
      h = number inp$[6]
      bv[h] *= 100
      bv[h] += number inp$[2]
   else
      h = number inp$[2]
      bl[h] = number inp$[7]
      if inp$[6] = "output"
         bl[h] = -bl[h] - 1
      .
      bh[h] = number inp$[12]
      if inp$[11] = "output"
         bh[h] = -bh[h] - 1
      .
   .
.
repeat
   for i range0 n
      if bv[i] > 100
         lo = bv[i] mod 100
         hi = bv[i] div 100
         if lo > hi
            swap lo hi
         .
         # if hi = 5 and lo = 2
         #   print i
         # .
         if hi = 61 and lo = 17
            print i
         .
         bv[i] = 0
         h = bl[i]
         if h >= 0
            bv[h] *= 100
            bv[h] += lo
            h = bh[i]
         else
            out[-h - 1] = lo
         .
         h = bh[i]
         if h >= 0
            bv[h] *= 100
            bv[h] += hi
         else
            out[-h - 1] = hi
         .
      .
   .
   m = out[0] * out[1] * out[2]
   until m > 0
.
print m
# 
# 
input_data
value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2




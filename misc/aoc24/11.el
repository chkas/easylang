# AoC-24 - Day 11: Plutonian Pebbles
#
hashsz = 9973
global hashind[] hashv[] .
#
proc hadd ind val .
   hi = ind mod hashsz + 1
   while hashind[hi] <> -1 and hashind[hi] <> ind
      hi = hi mod hashsz + 1
   .
   hashind[hi] = ind
   hashv[hi] += val
.
proc hinit .
   hashind[] = [ ]
   hashv[] = [ ]
   len hashind[] hashsz
   len hashv[] hashsz
   for i to len hashind[] : hashind[i] = -1
.
func ndigs n .
   return floor log10 n + 1
.
proc split n &a &b .
   m = pow 10 (ndigs n div 2)
   a = n div m
   b = n mod m
.
inp[] = number strsplit input " "
proc go nblinks .
   hinit
   for v in inp[] : hadd v 1
   #
   for blink to nblinks
      swap hashvp[] hashv[]
      swap hashindp[] hashind[]
      hinit
      #
      for i to hashsz
         cnt = hashvp[i]
         if cnt > 0
            n = hashindp[i]
            if n = 0
               hadd 1 cnt
            elif ndigs n mod 2 = 0
               split n a b
               hadd a cnt
               hadd b cnt
            else
               hadd (n * 2024) cnt
            .
         .
      .
   .
   for cnt in hashv[] : sum += cnt
   print sum
.
go 25
go 75
#
input_data
125 17

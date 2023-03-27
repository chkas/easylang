# AoC-16 - Day 4: Security Through Obscurity
# 
repeat
   s$ = input
   until s$ = ""
   cnt[] = [ ]
   len cnt[] 26
   id = 0
   len most[] 5
   mi = 1
   word[] = [ ]
   for i to len s$
      h = strcode substr s$ i 1
      if h >= 97 and h <= 123
         if id = 0
            cnt[h - 96] += 1
            word[] &= h - 96
         else
            most[mi] = h - 96
            mi += 1
         .
      elif h = 45 and id = 0
         word[] &= 0
      elif h >= 48 and h <= 57
         id = id * 10 + h - 48
      .
   .
   for i to 5
      max = 0
      for j to 26
         if cnt[j] > max
            max = cnt[j]
            maxi = j
         .
      .
      if most[i] <> maxi
         break 1
      .
      cnt[maxi] = 0
   .
   if i > 5
      sum += id
      w$ = ""
      for i to len word[] - 1
         if word[i] = 0
            w$ &= " "
         else
            h = (word[i] - 1 + id) mod 26
            w$ &= strchar h + 97
         .
      .
      if w$ = "northpole object storage" or w$ = "very encrypted name"
         nosid = id
      .
   .
.
print sum
print nosid
# 
input_data
aaaaa-bbb-z-y-x-123[abxyz]
a-b-c-d-e-f-g-h-987[abcde]
not-a-real-room-404[oarel]
totally-real-room-200[decoy]
qzmt-zixmtkozy-ivhz-343[zimth]



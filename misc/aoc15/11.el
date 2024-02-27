# AoC-15 - Day 11: Corporate Policy
#
for c$ in strchars input
   pw[] &= strcode c$ - 97
.
n = len pw[]
for part to 2
   repeat
      pos = n
      repeat
         pw[pos] += 1
         until pw[pos] < 26 or pos = 1
         pw[pos] = 0
         pos -= 1
      .
      if pos = 1
         print "overflow"
         break 1
      .
      #
      ok = 1
      for i to n
         if pw[i] = 8 or pw[i] = 11 or pw[i] = 14
            ok = 0
            break 1
         .
      .
      if ok = 1
         ok = 0
         for i to n - 2
            if pw[i] + 1 = pw[i + 1] and pw[i] + 2 = pw[i + 2]
               ok = 1
               break 1
            .
         .
         if ok = 1
            i = 1
            while i < n
               if pw[i] = pw[i + 1]
                  ok += 1
                  i += 1
               .
               i += 1
            .
         .
      .
      until ok >= 3
   .
   pw$ = ""
   for v in pw[]
      pw$ &= strchar (v + 97)
   .
   print pw$
.
#
input_data
ghijklmn



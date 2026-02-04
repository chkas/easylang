# AoC-16 - Day 21: Scrambled Letters and Hash
#
repeat
   ii$ = input
   until ii$ = ""
   inp$[] &= ii$
.
proc tostr pw[] &pw$ .
   pw$ = ""
   for i range0 len pw[]
      pw$ &= strchar (pw[i] + 97)
   .
.
proc hash pw[] &hash$ .
   np = len pw[]
   len pwn[] np
   for inp$ in inp$[]
      s$[] = strsplit inp$ " "
      if s$[1] = "swap"
         if s$[2] = "position"
            a = number s$[3]
            b = number s$[6]
         else
            ai = strcode s$[3] - 97
            bi = strcode s$[6] - 97
            for i range0 np
               if pw[i] = ai
                  a = i
               .
               if pw[i] = bi
                  b = i
               .
            .
         .
         swap pw[a] pw[b]
      elif s$[1] = "reverse"
         a = number s$[3]
         b = number s$[5]
         for i range0 (b - a + 1) div 2
            swap pw[a + i] pw[b - i]
         .
      elif s$[1] = "rotate"
         if s$[2] = "right"
            h = number s$[3]
         elif s$[2] = "left"
            h = -number s$[3]
         elif s$[2] = "based"
            ai = strcode s$[7] - 97
            for h range0 np
               if pw[h] = ai
                  break 1
               .
            .
            if h >= 4
               h += 1
            .
            h += 1
         .
         for i range0 np
            pwn[(i + h) mod np] = pw[i]
         .
         swap pw[] pwn[]
      elif s$[1] = "move"
         a = number s$[3]
         b = number s$[6]
         i = 0
         for in range0 np
            if in = b
               pwn[in] = pw[a]
            elif in = a
               if a < b
                  i += 1
                  pwn[in] = pw[i]
                  i += 1
               else
                  pwn[in] = pw[i]
                  i += 2
               .
            else
               pwn[in] = pw[i]
               i += 1
            .
         .
         swap pw[] pwn[]
      .
   .
   tostr pw[] hash$
.
func[] arr s$ .
   len r[] len s$
   for i range0 len r[]
      r[i] = strcode substr s$ (i + 1) 1 - 97
   .
   return r[]
.
hash arr "abcdefgh" h$
print h$
#
perm[] = [ 0 1 2 3 4 5 6 7 ]
#
global permlist[][] .
proc mk_permlist k .
   for i = k to len perm[]
      swap perm[i] perm[k]
      mk_permlist k + 1
      swap perm[k] perm[i]
   .
   if k = len perm[]
      permlist[][] &= perm[]
   .
.
mk_permlist 1
#
for i to len permlist[][]
   hash permlist[i][] hash$
   if hash$ = "fbgdceah"
      tostr permlist[i][] pw$
      print pw$
      break 1
   .
.
#
input_data
swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1 step
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d

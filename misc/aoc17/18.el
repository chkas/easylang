# AoC-17 - Day 18: Duet
#
repeat
   s$ = input
   until s$ = ""
   m$[] &= s$
.
#
subr run
   while 1 = 1
      if pc > len m$[] : break 1
      i$ = substr m$[pc] 1 3
      r1 = (strcode substr m$[pc] 5 1) - 96
      h = strcode substr m$[pc] 7 1
      if h >= 97
         v = r[h - 96]
      else
         v = number substr m$[pc] 7 9
      .
      if i$ = "set"
         r[r1] = v
      elif i$ = "add"
         r[r1] += v
      elif i$ = "mul"
         r[r1] *= v
      elif i$ = "mod"
         r[r1] = r[r1] mod v
      elif i$ = "jgz"
         if r1 >= 0
            h = r[r1]
         else
            h = strcode substr m$[pc] 6 1
         .
         if h > 0
            pc += v - 1
         .
      elif i$ = "snd"
         if part2 = 1
            if id = 1
               sum += 1
            .
            q1[] &= r[r1]
         else
            snd = r[r1]
         .
      elif i$ = "rcv"
         if part2 = 1
            if len q[] = 0 : break 1
            r[r1] = q[1]
            for i to len q[] - 1
               q[i] = q[i + 1]
            .
            len q[] len q[] - 1
         else
            if r[r1] <> 0 : break 1
         .
      else
         print "error"
      .
      pc += 1
   .
.
len r[] 26
pc = 1
run
print snd
#
part2 = 1
pc = 1
pc1 = 1
id = 0
id1 = 1
r[] = [ ]
len r[] 26
len r1[] 26
r1[16] = 1
#
while 1 = 1
   run
   if len q1[] = 0 or pc > len m$[]
      break 1
   .
   swap id id1
   swap pc pc1
   swap r[] r1[]
   swap q[] q1[]
.
print sum
#
input_data
set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2

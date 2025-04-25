# AoC-17 - Day 5: A Maze of Twisty Trampolines, All Alike
# 
repeat
   in$ = input
   until in$ = ""
   jmp0[] &= number in$
.
# 
proc run part jmp[] .
   i = 1
   repeat
      n += 1
      h = jmp[i]
      if h >= 3 and part = 2
         jmp[i] -= 1
      else
         jmp[i] += 1
      .
      i = h + i
      until i > len jmp[] or i <= 0
   .
   print n
.
run 1 jmp0[]
run 2 jmp0[]
# 
input_data
0
3
0
1
-3



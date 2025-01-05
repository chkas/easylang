# AoC-19 - Day 5: Sunny with a Chance of Asteroids
#
mem0[] = number strsplit input ","
arrbase mem0[] 0
global inp mem[] .
#
proc run . .
   repeat
      oc = mem[pc] mod 100
      ma = mem[pc] div 100 mod 10
      mb = mem[pc] div 1000 mod 10
      until oc < 1 or oc > 8
      a = mem[pc + 1]
      if ma = 0 : a = mem[a]
      if oc <= 2 or oc >= 5
         b = mem[pc + 2]
         if mb = 0 : b = mem[b]
      .
      if oc <= 2 or oc >= 7 and oc <= 8
         h = 0
         if oc = 1
            h = a + b
         elif oc = 2
            h = a * b
         elif oc = 7 and a < b or oc = 8 and a = b
            h = 1
         .
         mem[mem[pc + 3]] = h
         pc += 4
      elif oc = 5 or oc = 6
         pc += 3
         if oc = 5 and a <> 0 or oc = 6 and a = 0
            pc = b
         .
      else
         if oc = 3
            mem[mem[pc + 1]] = inp
         else
            if a <> 0 : print a
         .
         pc += 2
      .
   .
   if oc <> 99 : print "error"
.
mem[] = mem0[]
inp = 1
run
#
mem[] = mem0[]
inp = 5
run
#
input_data
3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99

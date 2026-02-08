# AoC-19 - Day 2: 1202 Program Alarm
#
proc arr0init &a[] .
   h = a[1]
   for i = 1 to len a[] - 1 : a[i] = a[i + 1]
   a[0] = h
.
mem0[] = number strsplit input ","
arr0init mem0[]
global mem[] .
#
proc run .
   repeat
      oc = mem[pc]
      until oc = 99
      a = mem[pc + 1]
      b = mem[pc + 2]
      c = mem[pc + 3]
      if oc = 1
         mem[c] = mem[a] + mem[b]
      elif oc = 2
         mem[c] = mem[a] * mem[b]
      else
         print "error"
      .
      pc += 4
   .
.
#
proc part1 .
   mem[] = mem0[]
   mem[1] = 12
   mem[2] = 2
   run
   print mem[0]
.
#
proc part2 .
   for noun range0 100
      for verb range0 100
         mem[] = mem0[]
         mem[1] = noun
         mem[2] = verb
         run
         if mem[0] = 19690720
            print 100 * noun + verb
            break 2
         .
      .
   .
.
if len mem0[] > 50
   part1
   part2
else
   mem[] = mem0[]
   for i range0 len mem[] : write mem[i] & " "
   print ""
   run
   for i range0 len mem[] : write mem[i] & " "
   print ""
.
#
input_data
1,1,1,4,99,5,6,0,99

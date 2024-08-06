# AoC-21 - Day 24: Arithmetic Logic Unit
# 
# Add digits one by one. Then test if at 
# a certain digit value "z" becomes smaller 
# (like at a bad bicycle lock, if it 
# clicks). If not, then try the previous 
# digits again.  
# 
sysconf topleft
visualization = 1
# 
global cod$[] a1[] a2[] a3[] v[] in[] is_part2 .
proc run . .
   inpos = 1
   v[] = [ 0 0 0 0 ]
   for i = 1 to len cod$[]
      v2 = a3[i]
      if a2[i] <> -1
         v2 = v[a2[i]]
      .
      if cod$[i] = "inp"
         if inpos > len in[]
            break 1
         .
         v[a1[i]] = in[inpos]
         inpos += 1
      elif cod$[i] = "add"
         v[a1[i]] += v2
      elif cod$[i] = "mul"
         v[a1[i]] *= v2
      elif cod$[i] = "div"
         v[a1[i]] = v[a1[i]] div v2
      elif cod$[i] = "mod"
         v[a1[i]] = v[a1[i]] mod v2
      elif cod$[i] = "eql"
         v[a1[i]] = if v[a1[i]] = v2
      .
   .
.
background 000
clear
# 
proc show . .
   if visualization = 0
      break 1
   .
   for d in in[]
      s$ &= d
   .
   move 8 is_part2 * 35 + 15
   color 000
   rect 100 25
   color 555
   textsize 10
   text s$
   move 8 is_part2 * 35 + 30
   textsize 6
   text "z:" & v[4]
   sleep 0.02
.
proc find . .
   in[] = [ ]
   for i = 1 to 14
      run
      min = v[4]
      in[] &= 0
      for d = 1 to 9
         in[i] = d
         run
         show
         if v[4] < min / 10
            break 1
         .
      .
      if d = 10
         if is_part2 = 1
            in[i] = 1
         .
         for j = 1 to i
            ds = in[j]
            for d = 1 to 9
               in[j] = d
               run
               show
               if v[4] < min / 10
                  break 2
               .
            .
            in[j] = ds
         .
      .
   .
   if v[4] <> 0
      print "error: z not 0"
   .
   for d in in[]
      write d
   .
   print ""
.
proc read . .
   repeat
      in$ = input
      until in$ = ""
      a$[] = strsplit in$ " "
      cod$[] &= a$[1]
      a1[] &= strcode a$[2] - strcode "w" + 1
      if len a$[] > 2
         a3[] &= number a$[3]
         if error = 1
            a2[] &= strcode a$[3] - strcode "w" + 1
         else
            a2[] &= -1
         .
      else
         a2[] &= 1
         a3[] &= 1
      .
   .
.
read
if len cod$[] = 0
   print "need input"
else
   find
   is_part2 = 1
   find
.
# 
input_data





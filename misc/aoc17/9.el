# AoC-17 - Day 9: Stream Processing
# 
inp$ = input
global c$ cnt score .
inpos = 1
proc nextc . .
   c$ = substr inp$ inpos 1
   inpos += 1
.
proc garbage . .
   repeat
      nextc
      while c$ = "!"
         nextc
         nextc
      .
      until c$ = ">" or c$ = ""
      cnt += 1
   .
.
proc group lev . .
   repeat
      nextc
      if c$ = "{"
         group lev + 1
         if c$ <> "}"
            print "error " & c$
         .
         nextc
      elif c$ = "<"
         garbage
         nextc
      .
      until c$ <> ","
   .
   score += lev
.
group 0
print score
print cnt
# 
input_data
{{<!>},{<!>},{<!>},{<a>}}


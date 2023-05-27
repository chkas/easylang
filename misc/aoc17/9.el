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
      call nextc
      while c$ = "!"
         call nextc
         call nextc
      .
      until c$ = ">" or c$ = ""
      cnt += 1
   .
.
proc group lev . .
   repeat
      call nextc
      if c$ = "{"
         call group lev + 1
         if c$ <> "}"
            print "error " & c$
         .
         call nextc
      elif c$ = "<"
         call garbage
         call nextc
      .
      until c$ <> ","
   .
   score += lev
.
call group 0
print score
print cnt
# 
input_data
{{<!>},{<!>},{<!>},{<a>}}


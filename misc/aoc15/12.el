# AoC-15 - Day 12: JSAbacusFramework.io
# 
inp$ = input
ipos = 1
c$ = ""
proc nextc . .
   c$ = substr inp$ ipos 1
   ipos += 1
.
procdecl parse . sum red .
tokv$ = ""
proc parse_numb . .
   tokv$ = ""
   if c$ = "-"
      tokv$ &= c$
      call nextc
   .
   while strcode c$ >= 48 and strcode c$ <= 57
      tokv$ &= c$
      call nextc
   .
.
proc parse_str . .
   tokv$ = ""
   while c$ <> "\""
      tokv$ &= c$
      call nextc
   .
   call nextc
.
part2 = 0
proc parse_obj . sum .
   sum = 0
   repeat
      if c$ <> "\""
         print "expected \" - got " & c$
      .
      call nextc
      call parse_str
      if c$ <> ":"
         print "expected : - got " & c$
      .
      call nextc
      call parse s r
      red += r
      sum += s
      until c$ <> ","
      call nextc
   .
   if c$ <> "}"
      print "expected } - got " & c$
   .
   call nextc
   if red >= 1 and part2 = 1
      sum = 0
   .
.
proc parse_arr . sum .
   sum = 0
   repeat
      call parse s red
      sum += s
      until c$ <> ","
      call nextc
   .
   if c$ <> "]"
      print "expected ] - got " & c$
   .
   call nextc
.
proc parse . sum red .
   red = 0
   if c$ = "{"
      call nextc
      call parse_obj sum
   elif c$ = "["
      call nextc
      call parse_arr sum
   elif c$ = "\""
      sum = 0
      call nextc
      call parse_str
      if tokv$ = "red"
         red = 1
      .
   elif c$ = "-" or strcode c$ >= 48 and strcode c$ <= 57
      call parse_numb
      sum = number tokv$
   else
      print "expected [\"-0-9 - got " & c$
   .
.
call nextc
call parse sum red
print sum
# 
part2 = 1
ipos = 1
call nextc
call parse sum red
print sum
# 
input_data
{"a":{"b":4},"c":-1,"d":[1,{"c":"red","b":2},3]}




# AoC-22 - Day 13: Distress Signal
# 
func ntok . s$ tok .
   c$ = substr s$ 1 1
   h = 2
   if c$ = ","
      c$ = substr s$ 2 1
      h = 3
   .
   if c$ = "["
      tok = -1
   elif c$ = "]"
      tok = -2
   else
      tok = strcode c$ - 48
      c$ = substr s$ h 1
      v = strcode c$ - 48
      if v >= 0 and v <= 9
         tok = tok * 10 + v
         h += 1
      .
   .
   s$ = substr s$ h -1
.
func cmp . s1$ s2$ win .
   repeat
      call ntok s1$ tok1
      call ntok s2$ tok2
      if tok1 = -2 and tok2 = -2
         done = 1
      elif tok1 = -2
         win = 1
      elif tok2 = -2
         win = 2
      elif tok1 = -1 or tok2 = -1
         if tok1 <> -1
            s1$ = tok1 & "]" & s1$
         elif tok2 <> -1
            s2$ = tok2 & "]" & s2$
         .
         call cmp s1$ s2$ win
      else
         if tok1 < tok2
            win = 1
         elif tok2 < tok1
            win = 2
         .
      .
      until done = 1 or win <> 0
   .
.
func compare s1$ s2$ . ok .
   call ntok s1$ h
   call ntok s2$ h
   win = 0
   call cmp s1$ s2$ win
   ok = 2 - win
.
func run . .
   repeat
      swap spp$ sp$
      swap s$ sp$
      s$ = input
      if s$ = ""
         ind += 1
         call compare spp$ sp$ ok
         sum += ind * ok
         s$ = input
      .
      until s$ = ""
      call compare s$ "[[2]]" ok
      ind1 += ok
      call compare s$ "[[6]]" ok
      ind2 += ok
   .
   print sum
   print (ind1 + 1) * (ind2 + 2)
.
call run
# 
input_data
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]



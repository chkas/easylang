# AoC-22 - Day 13: Distress Signal
#
proc ntok &s$ &tok .
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
   s$ = substr s$ h 999
.
proc cmp &s1$ &s2$ &win .
   repeat
      ntok s1$ tok1
      ntok s2$ tok2
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
         cmp s1$ s2$ win
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
proc compare s1$ s2$ &ok .
   ntok s1$ h
   ntok s2$ h
   win = 0
   cmp s1$ s2$ win
   ok = 2 - win
.
proc run .
   repeat
      swap spp$ sp$
      swap s$ sp$
      s$ = input
      if s$ = ""
         ind += 1
         compare spp$ sp$ ok
         sum += ind * ok
         s$ = input
      .
      until s$ = ""
      compare s$ "[[2]]" ok
      ind1 += ok
      compare s$ "[[6]]" ok
      ind2 += ok
   .
   print sum
   print (ind1 + 1) * (ind2 + 2)
.
run
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



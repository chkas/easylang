# AoC-20 - Day 19: Monster Messages
# 
repeat
   s$ = input
   until s$ = ""
   in$[] &= s$
.
repeat
   s$ = input
   until s$ = ""
   in2$[] &= s$
.
# 
len rule[][] len in$[] + 20
global a b .
# 
proc init . .
   for i to len in$[]
      l$[] = strsplit in$[i] " "
      ind = 1 + number substr l$[1] 1 -1
      if l$[2] = "\"a\""
         a = ind
      elif l$[2] = "\"b\""
         b = ind
      else
         for j = 2 to len l$[]
            s$ = l$[j]
            if s$ = "|"
               rl[] &= -1
            else
               rl[] &= number l$[j] + 1
            .
         .
      .
      swap rule[ind][] rl[]
   .
.
init
# 
proc match s$ . nr[] res .
   #  pr s$
   #  pr nr[]
   res = 1
   i = 1
   while i <= len nr[] and (nr[i] = a or nr[i] = b)
      c$ = substr s$ 1 1
      if nr[i] = a and c$ <> "a"
         res = 0
         break 2
      elif nr[i] = b and c$ <> "b"
         res = 0
         break 2
      .
      s$ = substr s$ 2 99
      i += 1
   .
   if i > len nr[]
      if s$ <> ""
         res = 0
      .
      break 1
   .
   double = 0
   ind = nr[i]
   i += 1
   for j = 1 to len rule[ind][]
      h = rule[ind][j]
      if h = -1
         for j = j + 1 to len rule[ind][]
            nnr2[] &= rule[ind][j]
         .
         double = 1
         break 1
      .
      nnr[] &= h
   .
   while i <= len nr[]
      h = nr[i]
      nnr[] &= h
      if double = 1
         nnr2[] &= h
      .
      i += 1
   .
   match s$ nnr[] res
   if res = 0 and double = 1
      match s$ nnr2[] res
   .
.
nr0[] = [ 1 ]
# 
for i to len in2$[]
   match in2$[i] nr0[] res
   sum += res
.
print sum
# 
rule[9][] = [ 43 -1 43 9 ]
rule[12][] = [ 43 32 -1 43 12 32 ]
# 
sum = 0
for i to len in2$[]
   match in2$[i] nr0[] res
   sum += res
.
print sum
# 
input_data
42: 9 14 | 10 1
9: 14 27 | 1 26
10: 23 14 | 28 1
1: "a"
11: 42 31
5: 1 14 | 15 1
19: 14 1 | 14 14
12: 24 14 | 19 1
16: 15 1 | 14 14
31: 14 17 | 1 13
6: 14 14 | 1 14
2: 1 24 | 14 4
0: 8 11
13: 14 3 | 1 12
15: 1 | 14
17: 14 2 | 1 7
23: 25 1 | 22 14
28: 16 1
4: 1 1
20: 14 14 | 1 15
3: 5 14 | 16 1
27: 1 6 | 14 18
14: "b"
21: 14 1 | 1 14
25: 1 1 | 1 14
22: 14 14
8: 42
26: 14 22 | 1 20
18: 15 15
7: 14 5 | 1 21
24: 14 1

abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
bbabbbbaabaabba
babbbbaabbbbbabbbbbbaabaaabaaa
aaabbbbbbaaaabaababaabababbabaaabbababababaaa
bbbbbbbaaaabbbbaaabbabaaa
bbbababbbbaaaaaaaabbababaaababaabab
ababaaaaaabaaab
ababaaaaabbbaba
baabbaaaabbaaaababbaababb
abbbbabbbbaaaababbbbbbaaaababb
aaaaabbaabaaaaababaa
aaaabbaaaabbaaa
aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
babaaabbbaaabaababbaabababaaab
aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba


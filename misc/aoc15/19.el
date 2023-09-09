# AoC-15 - Day 19: Medicine for Rudolph
# 
global name$[] .
proc add_name n$ . .
   for id to len name$[]
      if name$[id] = n$
         break 2
      .
   .
   name$[] &= n$
.
global na$[] r$[][] .
proc getid n$ . id .
   for id to len na$[]
      if na$[id] = n$
         break 2
      .
   .
   na$[] &= n$
   r$[][] &= [ ]
.
global na2$[] id2[] .
proc add n$ s$ . id .
   getid n$ id
   r$[id][] &= s$
   na2$[] &= s$
   id2[] &= id
.
# 
repeat
   s$ = input
   until s$ = ""
   h$[] = strsplit s$ " "
   add h$[1] h$[3] id
.
targ$ = input
# 
for i to len targ$
   s1$ = substr targ$ 1 i - 1
   h$ = substr targ$ i 1
   if i + 1 <= len targ$ and strcode substr targ$ i + 1 1 >= 97
      h$ = substr targ$ i 2
      i += 1
   .
   s2$ = substr targ$ i + 1 999
   getid h$ id
   for r$ in r$[id][]
      add_name s1$ & r$ & s2$
   .
.
print len name$[]
# 
# 
repeat
   for i to len targ$
      for j to len na2$[]
         s$ = na2$[j]
         l = len s$
         if substr targ$ i l = s$
            h$ = na$[id2[j]]
            if h$ <> "e" or targ$ = s$
               steps += 1
               t$ &= h$
               i += l - 1
               break 1
            .
         .
      .
      if j > len na2$[]
         t$ &= substr targ$ i 1
      .
   .
   targ$ = t$
   until targ$ = "e"
   t$ = ""
.
print steps
# 
input_data
e => H
e => O
H => HO
H => OH
O => HH

HOHOHO




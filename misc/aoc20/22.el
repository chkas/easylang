# AoC-20 - Day 22: Crab Combat
# 
s$ = input
len deck1[] 2
repeat
   s$ = input
   until s$ = ""
   deck1[] &= number s$
.
s$ = input
len deck2[] 2
repeat
   s$ = input
   until s$ = ""
   deck2[] &= number s$
.
deck1[2] = 3
deck2[2] = 3
deck1[1] = len deck1[] - 2
deck2[1] = len deck2[] - 2
nc = len deck1[] + len deck2[] + 2
len deck1[] nc
len deck2[] nc
deck1_copy[] = deck1[]
deck2_copy[] = deck2[]
# 
proc take . d[] c .
   s = d[2]
   c = d[s]
   d[s] = 0
   s += 1
   if s > nc
      s = 3
   .
   d[2] = s
   d[1] -= 1
.
proc put c . d[] .
   s = d[2]
   e = s + d[1]
   if e > nc
      e = e - nc + 2
   .
   d[e] = c
   d[1] += 1
.
proc score . d[] res .
   res = 0
   s = d[2]
   i = d[1]
   while i >= 1
      res += i * d[s]
      s += 1
      if s > nc
         s = 3
      .
      i -= 1
   .
.
# 
proc part1 . deck1[] deck2[] .
   while deck1[1] > 0 and deck2[1] > 0
      call take deck1[] card1
      call take deck2[] card2
      if card1 > card2
         call put card1 deck1[]
         call put card2 deck1[]
      else
         call put card2 deck2[]
         call put card1 deck2[]
      .
   .
   if deck1[1] > 0
      call score deck1[] score
   else
      call score deck2[] score
   .
   print score
.
call part1 deck1_copy[] deck2_copy[]
# 
# 
proc deck2str . d[] res$ .
   res$ = ""
   s = d[2]
   for _ to d[1]
      res$ &= strchar d[s]
      s += 1
      if s > nc
         s = 3
      .
   .
.
proc add_seen h$ . h$[] res .
   res = 0
   for i to len h$[]
      if h$[i] = h$
         res = 1
         break 2
      .
   .
   h$[] &= h$
.
proc play . deck1[] deck2[] winner .
   seen1$[] = [ ]
   seen2$[] = [ ]
   while 1 = 1
      if deck1[1] = 0
         winner = 2
         break 1
      .
      if deck2[1] = 0
         winner = 1
         break 1
      .
      call deck2str deck1[] h$
      call add_seen h$ seen1$[] is_in1
      call deck2str deck2[] h$
      call add_seen h$ seen2$[] is_in2
      if is_in1 = 1 or is_in2 = 1
         winner = 1
         break 1
      .
      call take deck1[] card1
      call take deck2[] card2
      if card1 > card2
         win_round = 1
      else
         win_round = 2
      .
      if card1 <= deck1[1] and card2 <= deck2[1]
         d1[] = deck1[]
         d1[1] = card1
         d2[] = deck2[]
         d2[1] = card2
         call play d1[] d2[] win_round
      .
      if win_round = 1
         call put card1 deck1[]
         call put card2 deck1[]
      else
         call put card2 deck2[]
         call put card1 deck2[]
      .
   .
.
call play deck1[] deck2[] winner
if winner = 1
   call score deck1[] score
else
   call score deck2[] score
.
print score
# 
input_data
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10



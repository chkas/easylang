# --- Day 22: Crab Combat ---
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
deck1[1] = 2
deck2[1] = 2
deck1[0] = len deck1[] - 2
deck2[0] = len deck2[] - 2
nc = len deck1[] + len deck2[] + 2
len deck1[] nc
len deck2[] nc
deck1_copy[] = deck1[]
deck2_copy[] = deck2[]
# 
func take . d[] c .
  s = d[1]
  c = d[s]
  d[s] = 0
  s += 1
  if s = nc
    s = 2
  .
  d[1] = s
  d[0] -= 1
.
func put c . d[] .
  s = d[1]
  e = s + d[0]
  if e >= nc
    e = e - nc + 2
  .
  d[e] = c
  d[0] += 1
.
func score . d[] res .
  res = 0
  s = d[1]
  i = d[0]
  while i >= 1
    res += i * d[s]
    s += 1
    if s = nc
      s = 2
    .
    i -= 1
  .
.
# 
func part1 . deck1[] deck2[] .
  while deck1[0] > 0 and deck2[0] > 0
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
  if deck1[0] > 0
    call score deck1[] score
  else
    call score deck2[] score
  .
  print score
.
call part1 deck1_copy[] deck2_copy[]
# 
# 
func addhash h . h[] res .
  res = 0
  for i range len h[]
    if h[i] = h
      res = 1
      break 1
    .
  .
  if res = 0
    h[] &= h
  .
.
func gethash . d[] res .
  res = 0
  s = d[1]
  for _ range d[0]
    res = (res + d[s]) * 65521 mod 137438953447
    s += 1
    if s = nc
      s = 2
    .
  .
.
func play . deck1[] deck2[] winner .
  hash1[] = [ ]
  hash2[] = [ ]
  while 1 = 1
    if deck1[0] = 0
      winner = 2
      break 1
    .
    if deck2[0] = 0
      winner = 1
      break 1
    .
    call gethash deck1[] h
    call addhash h hash1[] is_in1
    call gethash deck2[] h
    call addhash h hash2[] is_in2
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
    if card1 <= deck1[0] and card2 <= deck2[0]
      d1[] = deck1[]
      d1[0] = card1
      d2[] = deck2[]
      d2[0] = card2
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
43
36
13
11
20
25
37
38
4
18
1
8
27
23
7
22
10
5
50
40
45
26
15
32
33

Player 2:
21
29
12
28
46
9
44
6
16
39
19
24
17
14
47
48
42
34
31
3
41
35
2
30
49





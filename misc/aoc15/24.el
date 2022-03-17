# AoC-15 - Day 24: It Hangs in the Balance
# 
global n[] sumall[] inpsum .
func init . .
  repeat
    h = number input
    until error = 1
    inpsum += h
    n[] &= h
    sumall[] &= inpsum
  .
.
call init
# 
global mineq minsel targsum .
# 
func sum pos sum sel eq . .
  if sum = targsum
    if sel < minsel
      mineq = eq
      minsel = sel
    .
    mineq = lower eq mineq
  elif pos > 0 and sel <= minsel and sum + sumall[pos - 1] >= targsum
    pos -= 1
    if sum + n[pos] <= targsum
      call sum pos sum + n[pos] sel + 1 eq * n[pos]
    .
    call sum pos sum sel eq
  .
.
minsel = 1 / 0
targsum = inpsum div 3
call sum len n[] 0 0 1
print mineq
# 
minsel = 1 / 0
targsum = inpsum div 4
call sum len n[] 0 0 1
print mineq
# 
input_data
1
2
3
7
11
13
17
19
23
31
37
41
43
47
53
59
61
67
71
73
79
83
89
97
101
103
107
109
113



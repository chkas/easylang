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
func find pos sum sel eq . .
   if sum = targsum
      if sel < minsel
         mineq = eq
         minsel = sel
      elif sel = minsel
         mineq = lower eq mineq
      .
   elif pos > 1 and sel <= minsel and sum + sumall[pos - 1] >= targsum
      pos -= 1
      if sum + n[pos] <= targsum
         call find pos sum + n[pos] sel + 1 eq * n[pos]
      .
      call find pos sum sel eq
   .
.
minsel = 1 / 0
targsum = inpsum div 3
call find len n[] + 1 0 0 1
print mineq
# 
minsel = 1 / 0
targsum = inpsum div 4
call find len n[] + 1 0 0 1
print mineq
# 
input_data
1
2
3
4
5
7
8
9
10
11




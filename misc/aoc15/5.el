# AoC-15 - Day 5: Doesn't He Have Intern-Elves For This?
# 
repeat
   s$ = input
   until s$ = ""
   nice = 0
   vow = 0
   s$[] = strchars s$
   cp$ = ""
   for c$ in s$[]
      if c$ = "a" or c$ = "e" or c$ = "i" or c$ = "o" or c$ = "u"
         vow += 1
      .
      if c$ = cp$
         nice = 1
      .
      for h$ in [ "ab" "cd" "pq" "xy" ]
         if cp$ & c$ = h$
            nice = 0
            break 2
         .
      .
      cp$ = c$
   .
   if vow < 3
      nice = 0
   .
   sum += nice
   # 
   nice = 0
   for i to len s$[] - 3
      h$ = s$[i] & s$[i + 1]
      for j = i + 2 to len s$[] - 1
         if h$ = s$[j] & s$[j + 1]
            nice = 1
            break 2
         .
      .
   .
   if nice = 1
      nice = 0
      for i to len s$[] - 2
         if s$[i] = s$[i + 2]
            nice = 1
            break 1
         .
      .
   .
   sum2 += nice
.
print sum
print sum2
# 
input_data
ugknbfddgicrmopn
aaa
jchzalrnumimnmhp
haegwjzuvuyypxyu
dvszwmarrgswjxmb
qjhvhtzxzqqjkmpb
xxyxx
uurcxstgmygtbstg


# AoC-15 - Day 17: No Such Thing as Too Much
# 
repeat
  s$ = input
  until s$ = ""
  n[] &= number s$
.
global n_comb nmin .
minsel = 1 / 0
func sum pos sum sel . .
  if sum = 150
    n_comb += 1
    if sel <= minsel
      if sel < minsel
        minsel = sel
        nmin = 0
      .
      nmin += 1
    .
  elif pos < len n[]
    if sum + n[pos] <= 150
      call sum pos + 1 sum + n[pos] sel + 1
    .
    call sum pos + 1 sum sel
  .
.
call sum 0 0 0
print n_comb
print nmin
# 
input_data
50
44
11
49
42
46
18
32
26
40
21
7
18
43
10
47
36
24
22
40


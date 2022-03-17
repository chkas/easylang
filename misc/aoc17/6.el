# AoC-17 - Day 6: Memory Reallocation
# 
hasz = 199999
len haind$[] hasz
len haval[] hasz
# 
func hash ind[] val . ret .
  for i range 16
    ind$ &= strchar ind[i] + 65
  .
  for c$ in strchars ind$
    hi = (hi * 26 + strcode c$ - 26) mod hasz
  .
  while haind$[hi] <> "" and haind$[hi] <> ind$
    hi = (hi + 1) mod hasz
  .
  if haind$[hi] = ""
    haind$[hi] = ind$
    haval[hi] = val
    ret = 0
  else
    ret = haval[hi]
  .
.
# 
in$ = input
m[] = number strsplit in$ "\t"
repeat
  cnt += 1
  max = 0
  for i range 16
    if m[i] > max
      max = m[i]
      mi = i
    .
  .
  m[mi] = 0
  i = mi
  repeat
    i = (i + 1) mod 16
    until max = 0
    m[i] += 1
    max -= 1
  .
  call hash m[] cnt ret
  until ret > 0
.
print cnt
print cnt - ret
# 
input_data
11	11	13	7	0	15	5	5	4	4	1	1	7	1	15	11




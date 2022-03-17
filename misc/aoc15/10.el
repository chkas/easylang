# AoC-15 - Day 10: Elves Look, Elves Say
# 
f[] = number strchars input
func run . .
  fn[] = [ ]
  n = 1
  for i = 1 to len f[] - 1
    if f[i] = f[i - 1]
      n += 1
    else
      fn[] &= n
      fn[] &= f[i - 1]
      n = 1
    .
  .
  fn[] &= n
  fn[] &= f[i - 1]
  swap f[] fn[]
.
for i range 50
  call run
  if i = 39 or i = 49
    print len f[]
  .
.
# 
# 
input_data
1113222113


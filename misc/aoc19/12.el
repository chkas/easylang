# AoC-19 - Day 12: The N-Body Problem
# 
for _ range 4
  inp$[] = strsplit input "="
  p0[] &= number inp$[1]
  p0[] &= number inp$[2]
  p0[] &= number inp$[3]
.
# 
func part_1 . .
  p[] = p0[]
  len v[] 12
  for step range 1000
    for i range 12
      for j = 1 to 3
        if p[(i + j * 3) mod 12] > p[i]
          v[i] += 1
        elif p[(i + j * 3) mod 12] < p[i]
          v[i] -= 1
        .
      .
    .
    for i range 12
      p[i] += v[i]
    .
  .
  for i range 4
    p = 0
    k = 0
    for j range 3
      p += abs p[i * 3 + j]
      k += abs v[i * 3 + j]
    .
    e += p * k
  .
  print e
.
call part_1
# 
func gcd a b . res .
  while b <> 0
    h = b
    b = a mod b
    a = h
  .
  res = a
.
func lcm3 a b c . r .
  call gcd a b h
  r1 = a div h * b
  call gcd r1 c h
  r = r1 div h * c
.
func part_2 . .
  p[] = p0[]
  len v[] 12
  len steps[] 3
  for axis range 3
    repeat
      for moon range 4
        i = 3 * moon + axis
        for j = 1 to 3
          if p[(i + j * 3) mod 12] > p[i]
            v[i] += 1
          elif p[(i + j * 3) mod 12] < p[i]
            v[i] -= 1
          .
        .
      .
      found = 1
      for moon range 4
        i = 3 * moon + axis
        p[i] += v[i]
        if p[i] <> p0[i]
          found = 0
        .
      .
      steps[axis] += 1
      until found = 1
    .
    steps[axis] += 1
  .
  call lcm3 steps[0] steps[1] steps[2] r
  print r
.
call part_2
# 
input_data
<x=0, y=4, z=0>
<x=-10, y=-6, z=-14>
<x=9, y=-16, z=-3>
<x=6, y=-1, z=2>



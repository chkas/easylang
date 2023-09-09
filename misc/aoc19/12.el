# AoC-19 - Day 12: The N-Body Problem
# 
for _ range0 4
   inp$[] = strsplit input "="
   p0[] &= number inp$[2]
   p0[] &= number inp$[3]
   p0[] &= number inp$[4]
.
arrbase p0[] 0
# 
proc part_1 . .
   p[] = p0[]
   len v[] 12
   arrbase p[] 0
   arrbase v[] 0
   for step = 1 to 1000
      for i range0 12
         for j = 1 to 3
            if p[(i + j * 3) mod 12] > p[i]
               v[i] += 1
            elif p[(i + j * 3) mod 12] < p[i]
               v[i] -= 1
            .
         .
      .
      for i range0 12
         p[i] += v[i]
      .
   .
   for i range0 4
      p = 0
      k = 0
      for j range0 3
         p += abs p[i * 3 + j]
         k += abs v[i * 3 + j]
      .
      e += p * k
   .
   print e
.
part_1
# 
proc gcd a b . res .
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   res = a
.
proc lcm3 a b c . r .
   gcd a b h
   r1 = a div h * b
   gcd r1 c h
   r = r1 div h * c
.
proc part_2 . .
   p[] = p0[]
   len v[] 12
   len steps[] 3
   arrbase p[] 0
   arrbase v[] 0
   arrbase steps[] 0
   for axis range0 3
      repeat
         for moon range0 4
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
         for moon range0 4
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
   lcm3 steps[0] steps[1] steps[2] r
   print r
.
part_2
# 
input_data
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>



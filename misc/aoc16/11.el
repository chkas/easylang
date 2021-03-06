# AoC-16 - Day 11: Radioisotope Thermoelectric Generators
# 
hashsz = 1999993
len hashind[] hashsz
# 
func hash ind . ret .
  hi = ind mod hashsz
  while hashind[hi] <> 0 and hashind[hi] <> ind
    hi = (hi + 1) mod hashsz
  .
  if hashind[hi] = 0
    hashind[hi] = ind
    ret = 0
  else
    ret = 1
  .
.
# 
na$[] = [ ]
func id n$ . id .
  for id range len na$[]
    if na$[id] = n$
      break 2
    .
  .
  na$[] &= n$
.
global todo[] todon[] .
global el el0 cod destcod .
len ar[] 16
# 
func init . .
  ob[] = [ ]
  for fl range 4
    s$[] = strsplit input " "
    j = 5
    while j < len s$[] - 1
      if s$[j] = "a"
        j += 1
      .
      n$ = substr s$[j] 0 2
      call id n$ id
      if id * 2 >= len ob[]
        len ob[] id * 2 + 2
      .
      if substr s$[j + 1] 0 3 = "gen"
        ob[id * 2] = fl
      else
        ob[id * 2 + 1] = fl
      .
      j += 3
    .
  .
  nob = len ob[] / 2
  for i range nob
    h = 4 * ob[i * 2] + ob[i * 2 + 1]
    ar[h] += 1
  .
  destcod = nob * 4 + 3
.
call init
# 
func tocod . .
  cod = 0
  for v in ar[]
    cod = cod * 8 + v
  .
  cod = cod * 4 + el
.
call tocod
cod0 = cod
# 
func toarr . .
  h = cod
  el = h mod 4
  h = h div 4
  for i = 15 downto 0
    ar[i] = h mod 8
    h = h div 8
  .
.
# 
func add_check i1 i2 . .
  ar[i1] -= 1
  ar[i2] += 1
  gen = 0
  for i = el * 4 to el * 4 + 3
    gen += ar[i]
  .
  for i range 16
    if ar[i] > 0
      m = i mod 4
      g = i div 4
      if m = el and g <> el and gen > 0
        break 1
      .
    .
  .
  if i = 16
    call tocod
    call hash cod h
    if h = 0
      todon[] &= cod
    .
  .
  ar[i1] += 1
  ar[i2] -= 1
.
func add_todo . .
  # one object
  l1[] = [ ]
  l2[] = [ ]
  for i range 16
    if ar[i] > 0
      g = i div 4
      m = i mod 4
      if g = el0
        l1[] &= i
        l2[] &= el * 4 + m
      .
      if m = el0
        l1[] &= i
        l2[] &= g * 4 + el
      .
    .
  .
  for i range len l1[]
    call add_check l1[i] l2[i]
  .
  # gen+mic
  i = el0 * 4 + el0
  if ar[i] > 0
    call add_check i el * 4 + el
  .
  # 
  # two objects
  for li range len l1[]
    i = l1[li]
    gi = i div 4
    mi = i mod 4
    ii = l2[li]
    ar[i] -= 1
    ar[ii] += 1
    for lj range len l1[]
      j = l1[lj]
      if ar[j] > 0
        gj = j div 4
        mj = j mod 4
        ij = l2[lj]
        if gi = gj or mi = mj
          call add_check j ij
        .
      .
    .
    ar[ii] -= 1
    ar[i] += 1
  .
.
func run . .
  call tocod
  todon[] = [ cod ]
  todo[] = [ ]
  # 
  while len todon[] <> 0
    swap todon[] todo[]
    todon[] = [ ]
    for cod in todo[]
      call toarr
      if cod = destcod
        print step
        break 2
      .
      el0 = el
      for el in [ el + 1 el - 1 ]
        if el >= 0 and el <= 3
          call add_todo
        .
      .
    .
    step += 1
  .
.
call run
# 
cod = cod0
call toarr
el = 0
destcod += 8
ar[0] += 2
call run
# 
# 
input_data
The first floor contains a thulium generator, a thulium-compatible microchip, a plutonium generator, and a strontium generator.
The second floor contains a plutonium-compatible microchip and a strontium-compatible microchip.
The third floor contains a promethium generator, a promethium-compatible microchip, a ruthenium generator, and a ruthenium-compatible microchip.
The fourth floor contains nothing relevant.

The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.



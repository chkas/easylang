# AoC-16 - Day 17: Two Steps Forward
# 
len md5k[] 64
func md5init . .
  for i range 64
    md5k[i] = floor (0x100000000 * abs sin ((i + 1) * 180 / pi))
  .
.
call md5init
# 
func md5 inp$ . s$ .
  subr addinp
    if inp4 = 1
      inp[] &= 0
    .
    inp[len inp[] - 1] += b * inp4
    inp4 *= 0x100
    if inp4 = 0x100000000
      inp4 = 1
    .
  .
  s[] = [ 7 12 17 22 7 12 17 22 7 12 17 22 7 12 17 22 5 9 14 20 5 9 14 20 5 9 14 20 5 9 14 20 4 11 16 23 4 11 16 23 4 11 16 23 4 11 16 23 6 10 15 21 6 10 15 21 6 10 15 21 6 10 15 21 ]
  inp[] = [ ]
  inp4 = 1
  for i range len inp$
    b = strcode substr inp$ i 1
    call addinp
  .
  b = 0x80
  call addinp
  while len inp[] mod 16 <> 14 or inp4 <> 1
    b = 0
    call addinp
  .
  h = len inp$ * 8
  for i range 4
    b = h mod 0x100
    call addinp
    h = h div 0x100
  .
  inp[] &= 0
  # 
  a0 = 0x67452301
  b0 = 0xefcdab89
  c0 = 0x98badcfe
  d0 = 0x10325476
  for chunk = 0 step 16 to len inp[] - 16
    a = a0 ; b = b0 ; c = c0 ; d = d0
    for i range 64
      if i < 16
        h1 = bitand b c
        h2 = bitand bitnot b d
        f = bitor h1 h2
        g = i
      elif i < 32
        h1 = bitand d b
        h2 = bitand bitnot d c
        f = bitor h1 h2
        g = (5 * i + 1) mod 16
      elif i < 48
        h1 = bitxor b c
        f = bitxor h1 d
        g = (3 * i + 5) mod 16
      else
        h1 = bitor b bitnot d
        f = bitxor c h1
        g = 7 * i mod 16
      .
      f = (f + a + md5k[i] + inp[chunk + g])
      a = d
      d = c
      c = b
      h1 = bitshift f s[i]
      h2 = bitshift f (s[i] - 32)
      b = (b + h1 + h2)
    .
    a0 += a
    b0 += b
    c0 += c
    d0 += d
  .
  s$ = ""
  for a in [ a0 b0 c0 d0 ]
    for i range 4
      b = a mod 256
      a = a div 256
      for h in [ b div 16 b mod 16 ]
        h += 48
        if h > 57
          h += 39
        .
        s$ &= strchar h
      .
    .
  .
.
# 
inp$ = input
# 
dir$[] = strchars "UDLR"
todo$[] = [ "" ]
while len todo$[] <> 0
  for p$ in todo$[]
    x = 0 ; y = 0
    for h$ in strchars p$
      if h$ = "U" ; y -= 1
      elif h$ = "D" ; y += 1
      elif h$ = "L" ; x -= 1
      else ; x += 1
      .
    .
    if x = 3 and y = 3
      if long = 0
        print p$
      .
      long = len p$
    else
      call md5 inp$ & p$ h$
      md$[] = strchars substr h$ 0 4
      for i range 4
        open = 0
        if strcode md$[i] > 97
          open = 1
        .
        if i = 0 and y = 0 ; open = 0
        elif i = 1 and y = 3 ; open = 0
        elif i = 2 and x = 0 ; open = 0
        elif i = 3 and x = 3 ; open = 0
        .
        if open = 1
          todon$[] &= p$ & dir$[i]
        .
      .
    .
  .
  swap todo$[] todon$[]
  todon$[] = [ ]
.
print long
# 
input_data
rrrbmfta




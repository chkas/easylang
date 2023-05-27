# AoC-16 - Day 14: One-Time Pad
# 
len md5k[] 64
arrbase md5k[] 0
proc md5init . .
   for i range0 64
      md5k[i] = floor (0x100000000 * abs sin ((i + 1) * 180 / pi))
   .
.
call md5init
# 
proc md5 inp$ . s$ .
   subr addinp
      if inp4 = 1
         inp[] &= 0
      .
      inp[len inp[]] += b * inp4
      inp4 *= 0x100
      if inp4 = 0x100000000
         inp4 = 1
      .
   .
   s[] = [ 7 12 17 22 7 12 17 22 7 12 17 22 7 12 17 22 5 9 14 20 5 9 14 20 5 9 14 20 5 9 14 20 4 11 16 23 4 11 16 23 4 11 16 23 4 11 16 23 6 10 15 21 6 10 15 21 6 10 15 21 6 10 15 21 ]
   arrbase s[] 0
   #
   inp[] = [ ]
   inp4 = 1
   for i to len inp$
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
   for i range0 4
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
   for chunk = 1 step 16 to len inp[] - 15
      a = a0 ; b = b0 ; c = c0 ; d = d0
      for i range0 64
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
      a0 += a ; b0 += b ; c0 += c ; d0 += d
   .
   s$ = ""
   for a in [ a0 b0 c0 d0 ]
      for i range0 4
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
proc md5x in$ . h$ .
   call md5 in$ h$
   for i range0 2016
      call md5 h$ h$
   .
.
# 
inp$ = input
# 
part2 = 0
proc run . .
   for i range0 25000
      if part2 = 1
         call md5x inp$ & i md$
      else
         call md5 inp$ & i md$
      .
      a$[] = strchars md$
      co$ = ""
      for c$ in a$[]
         if c$ <> co$
            s$ = ""
         .
         s$ &= c$
         if len s$ = 3 and i <> iold
            m3$[] &= c$
            m3[] &= i
            iold = i
         elif len s$ = 5
            m5$[] &= c$
            m5[] &= i
         .
         co$ = c$
      .
   .
   for i to len m3[]
      c$ = m3$[i]
      r3 = m3[i]
      for j to len m5[]
         r5 = m5[j]
         if r5 > r3 + 1000
            break 1
         .
         if r5 > r3 and m5$[j] = c$
            cnt += 1
            if cnt = 64
               print r3
               break 2
            .
         .
      .
   .
.
print "That takes some time ..."
call run
part2 = 1
call run
# 
input_data
abc




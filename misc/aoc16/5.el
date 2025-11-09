# AoC-16 - Day 5: How About a Nice Game of Chess?
#
len k[] 64
arrbase k[] 0
s[] = [ 7 12 17 22 7 12 17 22 7 12 17 22 7 12 17 22 5 9 14 20 5 9 14 20 5 9 14 20 5 9 14 20 4 11 16 23 4 11 16 23 4 11 16 23 4 11 16 23 6 10 15 21 6 10 15 21 6 10 15 21 6 10 15 21 ]
arrbase s[] 0
proc init_hash .
   for i range0 64
      k[i] = floor (0x100000000 * abs sin ((i + 1) * 180 / pi))
   .
.
init_hash
#
proc out h[] &s$ .
   s$ = ""
   for a in h[]
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
global inp[] inp4 .
proc addinp b .
   if inp4 = 1
      inp[] &= 0
   .
   inp[len inp[]] += b * inp4
   inp4 *= 0x100
   if inp4 = 0x100000000
      inp4 = 1
   .
.
proc hash inp$ &hash[] .
   inp[] = [ ]
   inp4 = 1
   for i to len inp$
      addinp strcode substr inp$ i 1
   .
   addinp 0x80
   while len inp[] mod 16 <> 14 or inp4 <> 1
      addinp 0
   .
   h = len inp$ * 8
   for _ range0 4
      addinp h mod 0x100
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
         f = (f + a + k[i] + inp[chunk + g])
         a = d
         d = c
         c = b
         h1 = bitshift f s[i]
         h2 = bitshift f (s[i] - 32)
         b = (b + h1 + h2)
      .
      a0 += a ; b0 += b ; c0 += c ; d0 += d
   .
   hash[] = [ a0 b0 c0 d0 ]
.
# hash "abc5017308" h[]
# out h[] s$ ; print s$
#
proc run .
   print "That takes some time ..."
   inp$ = input
   pw1$[] = strchars "........"
   pw2$[] = strchars "........"
   pw1 = 1
   for i range0 9999999999
      hash inp$ & i h[]
      if h[1] mod 65536 = 0
         out h[] s$
         if substr s$ 1 5 = "00000"
            h$ = substr s$ 6 1
            if pw1 <= 8
               pw1$[pw1] = h$
               print "PW1: " & strjoin pw1$[] ""
               pw1 += 1
            .
            h = strcode h$ - 47
            if h <= 8
               if pw2$[h] = "."
                  pw2 += 1
                  pw2$[h] = substr s$ 7 1
                  print "PW2: " & strjoin pw2$[] ""
                  if pw2 = 8
                     print ""
                     print strjoin pw1$[] ""
                     print strjoin pw2$[] ""
                     break 1
                  .
               .
            .
         .
      .
   .
.
run
#
input_data
abc




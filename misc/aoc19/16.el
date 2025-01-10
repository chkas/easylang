# AoC-19 - Day 16: Flawed Frequency Transmission
#
inp$ = input
#
proc part1 . .
   d[] = number strchars inp$
   n = len d[]
   pat[] = [ 0 1 0 -1 ]
   for i = 1 to n
      p[][] &= [ ]
      ip = 1
      is_first = 1
      while len p[i][] <= n
         k = 1
         while k <= i and len p[i][] <= n
            if is_first = 0
               p[i][] &= pat[ip]
            .
            is_first = 0
            k += 1
         .
         ip = ip mod 4 + 1
      .
   .
   len dn[] n
   for k = 1 to 100
      for i = 1 to n
         v = 0
         for j = 1 to n
            v += p[i][j] * d[j]
         .
         dn[i] = abs v mod 10
      .
      swap d[] dn[]
   .
   for i = 1 to 8 : write d[i]
   print ""
.
part1
#
proc part2 . .
   n_in = len inp$
   offs = number substr inp$ 1 7
   len d[] n_in * 10000 - offs
   j = offs mod n_in + 1
   n = len d[]
   for i = 1 to n
      d[i] = number substr inp$ j 1
      j = j mod n_in + 1
   .
   len dn[] n
   for k = 1 to 100
      s = 0
      for i = n downto 1
         s += d[i]
         dn[i] = s mod 10
      .
      swap d[] dn[]
   .
   for i = 1 to 8 : write d[i]
   print ""
.
if len inp$ >= 10
   part2
.
#
input_data
12345678





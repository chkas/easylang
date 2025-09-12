max = 12
#
func factSum n .
   f = 1
   while x < n
      x += 1
      f *= x
      s += f
   .
   return s
.
len cnt[] max
arrbase cnt[] 0
global sp$[] pos .
#
func r n .
   if n = 0 : return 0
   c$ = sp$[pos - n]
   cnt[n] -= 1
   if cnt[n] = 0
      cnt[n] = n
      if r (n - 1) = 0 : return 0
   .
   sp$[pos] = c$
   pos += 1
   return 1
.
proc superperm n .
   pos = n
   le = factSum n
   len sp$[] le
   arrbase sp$[] 0
   for i = 0 to n : cnt[i] = i
   for i = 1 to n : sp$[i - 1] = strchar (48 + i)
   while r n = 1
      #
   .
.
for n = 0 to max - 1
   write "superperm(" & n & ") "
   superperm n
   print "len = " & len sp$[]
.

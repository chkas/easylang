func cntcons s$ .
   len a[] 26
   for c$ in strchars s$
      if strpos "aeiou" c$ = 0
         c = strcode c$ - 96
         if c >= 1
            a[c] = 1
         .
      .
   .
   for h in a[]
      s += h
   .
   return s
.
repeat
   s$ = input
   until s$ = ""
   if len s$ >= 11
      cnt = cntcons s$
      if cnt >= max
         if cnt > max
            max = cnt
            wrds$[] = [ ]
         .
         wrds$[] &= s$
      .
   .
.
print wrds$[] & " (" & max & ")"
# 
# the content of unixdict.txt
input_data
10th
.
1st
ackerman
ackley
acknowledge
bremsstrahlung
handicraftsmen

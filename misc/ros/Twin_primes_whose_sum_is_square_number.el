fastfunc isprimo num .
   i = 3
   while i <= sqrt num
      if num mod i = 0 : return 0
      i += 2
   .
   return 1
.
for n = 3 step 2 to 10000000
   if isprimo n = 1 and isprimo (n + 2) = 1
      if sqrt (n + n + 2) mod 1 = 0
         write "(" & n & " " & n + 2 & ") "
      .
   .
.
print ""

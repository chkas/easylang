fastfunc isprim n .
   if n < 2 : return 0
   i = 2
   while i <= sqrt n
      if n mod i = 0 : return 0
      i += 1
   .
   return 1
.
pri = 1
while nwag <> 10
   pri += 2
   if isprim pri = 1
      wag = (pow 2 pri + 1) / 3
      if isprim wag = 1
         nwag += 1
         print pri & " => " & wag
      .
   .
.

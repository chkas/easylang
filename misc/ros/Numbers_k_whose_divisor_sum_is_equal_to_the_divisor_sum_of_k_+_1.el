fastfunc sigsum n .
   i = 1
   while i <= sqrt n
      if n mod i = 0
         sumdiv += i
         if i <> n div i : sumdiv += n div i
      .
      i += 1
   .
   return sumdiv
.
while cnt < 50
   if sigsum num = sigsum (num + 1)
      cnt += 1
      write num & " "
   .
   num += 1
.

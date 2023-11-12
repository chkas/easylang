maxCount = 65
while count < maxCount
   n += 1
   idoneal = 1
   a = 1
   while a + 2 < n and idoneal = 1
      b = a + 1
      repeat
         ab = a * b
         sum = 0
         if ab < n
            c = (n - ab) div (a + b)
            sum = ab + c * (b + a)
            if c > b and sum = n
               idoneal = 0
            .
            b += 1
         .
         until sum > n or idoneal = 0 or ab >= n
      .
      a += 1
   .
   if idoneal = 1
      count += 1
      write " " & n
   .
.

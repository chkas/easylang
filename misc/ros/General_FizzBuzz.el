max = 20
words$[] = [ "Fizz" "Buzz" "Baxx" ]
keys[] = [ 3 5 7 ]
# 
for n = 1 to max
   prnt = 1
   for j = 1 to len keys[]
      if n mod keys[j] = 0
         write words$[j]
         prnt = 0
      .
   .
   if prnt = 1
      write n
   .
   print ""
.

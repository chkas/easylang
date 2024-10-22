repeat
   s$ = input
   until s$ = ""
   if len s$ >= 9
      w$[] &= s$
   .
.
func search s$ .
   max = len w$[] + 1
   while min + 1 < max
      mid = min + (max - min) div 2
      h = strcmp w$[mid] s$
      if h = 0
         return 1
      elif h < 0
         min = mid
      else
         max = mid
      .
   .
   return 0
.
for i to len w$[] - 8
   s$ = ""
   for j = 0 to 8
      s$ &= substr w$[i + j] (1 + j) 1
   .
   if search s$ = 1
      print s$
   .
.
# the content of unixdict.txt 
input_data
10th
apperception
appertain
applejack
appliance
applicable
applicant
applicate
application
appointee

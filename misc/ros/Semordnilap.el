repeat
   s$ = input
   until s$ = ""
   w$[] &= s$
.
func$ reverse s$ .
   a$[] = strchars s$
   for i = 1 to len a$[] div 2
      swap a$[i] a$[len a$[] - i + 1]
   .
   return strjoin a$[]
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
for w$ in w$[]
   r$ = reverse w$
   if strcmp r$ w$ < 0
      if search r$ = 1
         cnt += 1
         if cnt <= 5
            print w$ & " " & r$
         .
      .
   .
.
print cnt
# the content of unixdict.txt 
input_data
10th
.
avid
diva
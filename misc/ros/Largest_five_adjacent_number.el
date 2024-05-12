for i to 1000
   n$ &= random 10 - 1
.
min = 99999
for i = 1 to 995
   n = number substr n$ i 5
   min = lower min n
   max = higher max n
.
print min & " " & max

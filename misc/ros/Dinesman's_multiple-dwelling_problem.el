proc nextperm &a[] &k .
   n = len a[]
   k = n - 1
   while k >= 1 and a[k + 1] <= a[k] : k -= 1
   if k = 0 : return
   l = n
   while a[l] <= a[k] : l -= 1
   swap a[l] a[k]
   k += 1
   while k < n
      swap a[k] a[n]
      k += 1
      n -= 1
   .
.
for i = 1 to 5 : floors[] &= i
BAKER = 1
COOPER = 2
FLETCHER = 3
MILLER = 4
SMITH = 5
names$[] = [ "Baker" "Cooper" "Fletcher" "Miller" "Smith" ]
#
repeat
   if floors[BAKER] <> 5 and floors[COOPER] <> 1 and floors[FLETCHER] <> 1 and floors[FLETCHER] <> 5
      if floors[MILLER] > floors[COOPER] and abs (floors[SMITH] - floors[FLETCHER]) <> 1 and abs (floors[FLETCHER] - floors[COOPER]) <> 1
         for i to 5
            print names$[i] & " lives on floor " & floors[i]
         .
         break 1
      .
   .
   nextperm floors[] more
   until more = 0
.

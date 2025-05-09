name$[] = [ "map" "compass" "water" "sandwich" "glucose" "tin" "banana" "apple" "cheese" "beer" "suntan cream" "camera" "t-shirt" "trousers" "umbrella" "waterproof trousers" "waterproof overclothes" "note-case" "sunglasses" "towel" "socks" "book" ]
weight[] = [ 9 13 153 50 15 68 27 39 23 52 11 32 24 48 73 42 43 22 7 18 4 30 ]
value[] = [ 150 35 200 160 60 45 60 40 30 10 70 30 15 10 40 70 75 80 20 12 50 10 ]
max_w = 400
#
proc solve i maxw &items[] &wres &vres .
   if i = 0
      wres = 0
      vres = 0
      items[] = [ ]
   elif weight[i] > maxw
      solve i - 1 maxw items[] wres vres
   else
      solve i - 1 maxw items[] wres vres
      solve i - 1 maxw - weight[i] items1[] w1 v1
      if v1 + value[i] > vres
         swap items[] items1[]
         items[] &= i
         wres = w1 + weight[i]
         vres = v1 + value[i]
      .
   .
.
solve len weight[] max_w items[] w v
print "weight: " & w & " value: " & v
write "items:"
for item in items[] : write " " & name$[item]

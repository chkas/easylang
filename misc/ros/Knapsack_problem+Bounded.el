name$[] = [ "map" "compass" "water" "sandwich" "glucose" "tin" "banana" "apple" "cheese" "beer" "suntan cream" "camera" "t-shirt" "trousers" "umbrella" "waterproof trousers" "waterproof overclothes" "note-case" "sunglasses" "towel" "socks" "book" ]
weight[] = [ 9 13 153 50 15 68 27 39 23 52 11 32 24 48 73 42 43 22 7 18 4 30 ]
value[] = [ 150 35 200 60 60 45 60 40 30 10 70 30 15 10 40 70 75 80 20 12 50 10 ]
pieces[] = [ 1 1 2 2 2 3 3 3 1 3 1 1 2 2 1 1 1 1 1 2 1 2 ]
maxweight = 400
#
global valuesum[] maxv .
#
proc solve i maxw v &items[] &wres &vres .
   if i = 0
      wres = 0
      vres = 0
      items[] = [ ]
      maxv = higher maxv v
      return
   .
   if v + valuesum[i] < maxv
      vres = -100000
      return
   .
   if weight[i] > maxw
      solve i - 1 maxw v items[] wres vres
   else
      solve i - 1 maxw - weight[i] v + value[i] items1[] w1 v1
      solve i - 1 maxw v items[] wres vres
      if v1 + value[i] > vres
         swap items[] items1[]
         items[] &= i
         wres = w1 + weight[i]
         vres = v1 + value[i]
      .
   .
.
proc prepare .
   for i to len weight[] : for j to pieces[i]
      n$[] &= name$[i]
      w[] &= weight[i]
      v[] &= value[i]
   .
   swap name$[] n$[]
   swap weight[] w[]
   swap value[] v[]
   #
   n = len weight[]
   for i = 1 to n - 1
      for j = i + 1 to n
         if value[j] < value[i]
            swap value[j] value[i]
            swap weight[j] weight[i]
            swap name$[j] name$[i]
         .
      .
   .
   for i to n
      s += value[i]
      valuesum[] &= s
   .
.
prepare
#
solve len weight[] maxweight 0 items[] wsum vsum
print "weight: " & wsum & " value: " & vsum
print "items:"
for item in items[] : print "  " & name$[item]

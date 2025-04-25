attr$[][] &= [ "one  " "two  " "three" ]
attr$[][] &= [ "solid  " "striped" "open   " ]
attr$[][] &= [ "red   " "green " "purple" ]
attr$[][] &= [ "diamond " "oval    " "squiggle" ]
#
for card = 0 to 80 : pack[] &= card
proc card2attr card &attr[] .
   attr[] = [ ]
   for i to 4
      attr[] &= card mod 3 + 1
      card = card div 3
   .
.
proc prcards cards[] .
   for card in cards[]
      card2attr card attr[]
      for i to 4 : write attr$[i][attr[i]] & " "
      print ""
   .
   print ""
.
ncards = random 5 + 7
print "Take " & ncards & " cards:"
for i to ncards
   ind = random len pack[]
   cards[] &= pack[ind]
   pack[ind] = pack[len pack[]]
   len pack[] -1
.
prcards cards[]
#
for i to len cards[]
   card2attr cards[i] a[]
   for j = i + 1 to len cards[]
      card2attr cards[j] b[]
      for k = j + 1 to len cards[]
         card2attr cards[k] c[]
         ok = 1
         for at to 4
            s = a[at] + b[at] + c[at]
            if s <> 3 and s <> 6 and s <> 9
               # 1,1,1 2,2,2 3,3,3 1,2,3
               ok = 0
            .
         .
         if ok = 1
            print "Set:"
            prcards [ cards[i] cards[j] cards[k] ]
         .
      .
   .
.

sailors$[] = [ "Adrian" "Caspian" "Dune" "Finn" "Fisher" "Heron" "Kai" "Ray" "Sailor" "Tao" ]
ladies$[] = [ "Ariel" "Bertha" "Blue" "Cali" "Catalina" "Gale" "Hannah" "Isla" "Marina" "Shelly" ]
func isnicegirl s$ .
   return if strcode substr s$ 1 1 mod 2 = 0
.
func is_lovable lady$ sailor$ .
   l = strcode substr lady$ len lady$ 1 mod 2
   s = strcode substr sailor$ len sailor$ 1 mod 2
   return if l = s
.
for lady$ in ladies$[]
   if isnicegirl lady$ = 1
      print "Dating service should offer a date with " & lady$
      for sailor$ in sailors$[]
         if is_lovable lady$ sailor$ = 1
            print "    Sailor " & sailor$ & " should take an offer to date her."
         .
      .
   else
      print "Dating service should NOT offer a date with " & lady$
   .
.

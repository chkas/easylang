conds$[][] = [ [ "Printer prints" "nnnnyyyy" ] [ "A red light is flashing" "yynnyynn" ] [ "Printer is recognized by computer" "nynynyny" ] ]
acts$[][] = [ [ "Check the power cable" "nnynnnnn" ] [ "Check the printer-computer cable" "ynynnnnn" ] [ "Ensure printer software is installed" "ynynynyn" ] [ "Check/replace ink" "yynnnynn" ] [ "Check for paper jam" "nynynnnn" ] ]
# 
nc = len conds$[][]
na = len acts$[][]
nr = len conds$[1][2]
np = pow 2 nc
# 
print "Please answer the following questions with a y or n:"
for c to nc
   repeat
      write "  " & conds$[c][1] & " ? "
      in$ = input
      print in$
      until in$ = "y" or in$ = "n"
   .
   answs$[] &= in$
.
print "\nRecommended action(s):"
for r to nr
   for c to nc
      if substr conds$[c][2] r 1 <> answs$[c]
         break 1
      .
   .
   if c > nc
      if r = np
         print "  None (no problem detected)"
      else
         for a = 1 to na
            if substr acts$[a][2] r 1 = "y"
               print "  " & acts$[a][1]
            .
         .
         break 1
      .
   .
.

func run npers nsame .
   len day[] 365
   for i to npers
      r = random 365
      day[r] += 1
      if day[r] = nsame : return 1
   .
   return 0
.
nruns = 10000
npers = 2
for nsame = 2 to 5
   repeat
      ok = 0
      for t to nruns : ok += run npers nsame
      until ok / nruns > 0.5
      npers += 1
   .
   print npers
.

shaved[] = [ 1 5 30 60 300 1800 3600 21600 86400 ]
columns$[] = [ "1 Second  " "5 Seconds " "30 Seconds" "1 Minute  " "5 Minutes " "30 Minutes" "1 Hour    " "6 Hours   " "1 Day     " ]
diy = 365.25
minute = 60
hour = minute * 60
day = hour * 24
week = day * 7
month = day * diy / 12
year = day * diy
freq[] = [ 50 * diy, 5 * diy, diy, diy / 7, 12, 1 ]
mult = 5
proc fmt t interval$ .
   t = floor t
   if t <> 1 : pl$ = "s"
   s$ = t & " " & interval$ & pl$
   while len s$ < 11 : s$ &= " "
   write s$
.
print "           |                How Often You Do the Task"
print "Shaved-off | 50/Day     5/Day      Daily      Weekly     Monthly    Yearly"
print "-----------------------------------------------------------------------------"
for y to 9
   write columns$[y] & " | "
   for x to 6
      t = freq[x] * shaved[y] * mult
      if t < minute
         fmt t "Second"
      elif t < hour
         fmt t / minute, "Minute"
      elif t < day
         fmt t / hour, "Hour"
      elif t < 14 * day
         fmt t / day, "Day"
      elif t < 9 * week
         fmt t / week, "Week"
      elif t < year
         fmt t / month, "Month"
      else
         write "           "
      .
   .
   print ""
.

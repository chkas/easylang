func dayOfTheWeek year month day .
   # Based on Conway's doomsday algorithm
   century = floor (year / 100)
   if century mod 4 = 0
      centuryDoomsday = 2
   elif century mod 4 = 1
      centuryDoomsday = 0
   elif century mod 4 = 2
      centuryDoomsday = 5
   elif century mod 4 = 3
      centuryDoomsday = 3
   .
   mainYear = year mod 100
   yearDoomsday = (floor (mainYear / 12) + mainYear mod 12 + floor (mainYear mod 12 / 4) + centuryDoomsday) mod 7
   if mainYear = 0
      if century mod 4 = 0
         leap = 1
      else
         leap = 0
      .
   else
      if mainYear mod 4 = 0
         leap = 1
      else
         leap = 0
      .
   .
   if leap = 1
      januaryOne = (yearDoomsday + 4) mod 7
   else
      januaryOne = (yearDoomsday + 5) mod 7
   .
   monthDays[] = [ 0 31 59 90 120 151 181 212 243 273 304 334 ]
   nthDay = monthDays[month]
   if month > 2
      nthDay += leap
   .
   nthDay += day
   return (januaryOne + nthDay - 1) mod 7 + 1
.
days$[] = [ "Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" ]
# 
print "2021-12-25 is on " & days$[dayOfTheWeek 2021 12 25]
print "2022-1-1 is on " & days$[dayOfTheWeek 2022 1 1]

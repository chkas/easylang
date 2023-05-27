# AoC-18 - Day 4: Repose Record
# 
repeat
   s$ = input
   until s$ = ""
   s$[] &= s$
.
for i = 1 to len s$[] - 1
   for j = i + 1 to len s$[]
      h = strcmp s$[j] s$[i]
      if h < 0
         swap s$[j] s$[i]
      .
   .
.
global gids[] .
global tm[][] gid .
proc gid g . .
   for gid = 1 to len gids[]
      if g = gids[gid]
         break 2
      .
   .
   gids[] &= g
   tm[][] &= [ ]
   len tm[len tm[][]][] 60
.
for s$ in s$[]
   h$[] = strsplit s$ " "
   if substr h$[2] 1 2 <> "00"
      tm = 0
   else
      tm = number substr h$[2] 4 2
   .
   if h$[4] = "asleep"
      tm0 = tm
   elif h$[4] = "up"
      for j = tm0 + 1 to tm
         tm[gid][j] = tm[gid][j] + 1
      .
   else
      g = number substr h$[4] 2 99
      call gid g
   .
.
# 
for g = 1 to len gids[]
   m = 0
   for j to 60
      m += tm[g][j]
   .
   if m > max
      max = m
      gid = g
   .
.
max = 0
for m to 60
   if tm[gid][m] > max
      max = tm[gid][m]
      mmin = m - 1
   .
.
print gids[gid] * mmin
# 
max = 0
for gid to len gids[]
   for m to 60
      if tm[gid][m] > max
         max = tm[gid][m]
         mmin = m - 1
         mgid = gid
      .
   .
.
print gids[mgid] * mmin
# 
# 
input_data
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up


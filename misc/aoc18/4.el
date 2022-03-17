# AoC-18 - Day 4: Repose Record
# 
repeat
  s$ = input
  until s$ = ""
  s$[] &= s$
.
for i = 0 to len s$[] - 2
  for j = i + 1 to len s$[] - 1
    h = strcmp s$[j] s$[i]
    if h < 0
      swap s$[j] s$[i]
    .
  .
.
global gids[] .
global tm[][] gid .
func gid g . .
  for gid range len gids[]
    if g = gids[gid]
      break 1
    .
  .
  if gid = len gids[]
    gids[] &= g
    tm[][] &= [ ]
    len tm[len tm[][] - 1][] 60
  .
.
for i range len s$[]
  #  pr s$[i]
  h$[] = strsplit s$[i] " "
  if substr h$[1] 0 2 <> "00"
    tm = 0
  else
    tm = number substr h$[1] 3 2
  .
  if h$[3] = "asleep"
    tm0 = tm
  elif h$[3] = "up"
    for j = tm0 to tm - 1
      tm[gid][j] = tm[gid][j] + 1
    .
  else
    g = number substr h$[3] 1 99
    call gid g
  .
.
# 
for g range len gids[]
  m = 0
  for j range 60
    m += tm[g][j]
  .
  if m > max
    max = m
    gid = g
  .
.
max = 0
for m range 60
  if tm[gid][m] > max
    max = tm[gid][m]
    mmin = m
  .
.
print gids[gid] * mmin
# 
max = 0
for gid range len gids[]
  for m range 60
    if tm[gid][m] > max
      max = tm[gid][m]
      mmin = m
      mgid = gid
    .
  .
.
print gids[mgid] * mmin
# 
# 
input_data
[1518-05-12 00:39] wakes up
[1518-05-09 00:21] falls asleep
[1518-11-16 00:07] falls asleep
[1518-02-06 23:51] Guard #2081 begins shift
[1518-03-22 00:53] falls asleep
[1518-09-11 23:58] Guard #1699 begins shift
[1518-02-23 00:02] Guard #1913 begins shift
[1518-05-07 00:22] wakes up
[1518-07-23 00:26] wakes up
[1518-10-07 00:40] wakes up
[1518-02-18 00:02] Guard #263 begins shift
[1518-06-08 00:18] falls asleep
[1518-04-28 00:00] Guard #3301 begins shift
[1518-02-04 00:49] wakes up
[1518-09-08 00:13] falls asleep
[1518-05-27 23:56] Guard #2689 begins shift
[1518-06-17 00:53] wakes up
[1518-03-27 00:00] Guard #1913 begins shift
[1518-04-27 00:00] Guard #2017 begins shift
[1518-11-14 00:05] falls asleep
[1518-03-30 00:37] wakes up
[1518-11-04 00:01] Guard #2521 begins shift
[1518-11-06 00:00] Guard #3137 begins shift
[1518-07-14 00:46] falls asleep
[1518-06-08 23:52] Guard #2689 begins shift
[1518-01-29 23:58] Guard #617 begins shift
[1518-09-14 00:08] falls asleep
[1518-04-19 23:59] Guard #1699 begins shift
[1518-10-17 00:15] falls asleep
[1518-10-17 00:41] falls asleep
[1518-09-01 00:41] falls asleep
[1518-07-08 00:50] wakes up
[1518-04-14 00:48] wakes up
[1518-02-11 00:34] falls asleep
[1518-06-01 00:54] falls asleep
[1518-04-01 00:55] wakes up
[1518-08-13 00:41] falls asleep
[1518-10-21 23:59] Guard #131 begins shift
[1518-08-25 00:47] falls asleep
[1518-07-28 23:57] Guard #1069 begins shift
[1518-04-26 00:57] falls asleep
[1518-09-27 00:59] wakes up
[1518-04-14 00:01] falls asleep
[1518-09-11 00:47] falls asleep
[1518-03-27 00:49] wakes up
[1518-03-02 00:04] Guard #263 begins shift
[1518-04-22 00:30] wakes up
[1518-10-03 00:40] wakes up
[1518-08-05 00:31] falls asleep
[1518-03-12 00:21] falls asleep
[1518-05-21 00:58] wakes up
[1518-05-06 00:25] wakes up
[1518-11-18 00:57] falls asleep
[1518-04-20 00:57] wakes up
[1518-03-11 00:48] falls asleep
[1518-08-06 00:00] Guard #2017 begins shift
[1518-10-13 00:55] wakes up
[1518-08-11 00:49] wakes up
[1518-07-12 00:59] wakes up
[1518-07-17 00:00] Guard #1217 begins shift
[1518-07-10 00:15] falls asleep
[1518-08-02 23:53] Guard #3187 begins shift
[1518-10-26 00:01] Guard #3181 begins shift
[1518-05-29 00:40] falls asleep
[1518-06-26 23:56] Guard #467 begins shift
[1518-09-02 00:45] falls asleep
[1518-04-09 00:41] falls asleep
[1518-10-14 00:57] wakes up
[1518-06-13 00:01] Guard #617 begins shift
[1518-11-15 00:28] falls asleep
[1518-04-24 00:47] wakes up
[1518-03-03 00:24] wakes up
[1518-09-26 00:32] falls asleep
[1518-11-21 00:00] Guard #1933 begins shift
[1518-04-18 00:53] wakes up
[1518-10-03 00:03] Guard #2521 begins shift
[1518-03-07 00:13] falls asleep
[1518-07-23 00:07] falls asleep
[1518-10-12 00:37] falls asleep
[1518-10-21 00:52] wakes up
[1518-09-12 00:51] wakes up
[1518-08-20 00:08] wakes up
[1518-03-08 00:57] wakes up
[1518-09-20 00:54] wakes up
[1518-10-30 00:12] falls asleep
[1518-04-21 00:40] wakes up
[1518-10-15 00:34] falls asleep
[1518-10-21 00:20] falls asleep
[1518-02-26 00:11] falls asleep
[1518-05-29 00:56] wakes up
[1518-04-25 00:24] falls asleep
[1518-04-28 23:56] Guard #263 begins shift
[1518-03-17 00:52] falls asleep
[1518-08-31 00:01] falls asleep
[1518-02-19 00:29] falls asleep
[1518-03-04 00:52] wakes up
[1518-02-04 00:25] falls asleep
[1518-09-10 00:01] falls asleep
[1518-07-31 00:29] falls asleep
[1518-06-13 00:57] falls asleep
[1518-09-12 00:58] wakes up
[1518-06-16 23:59] Guard #2711 begins shift
[1518-05-25 00:03] Guard #1913 begins shift
[1518-04-09 00:56] wakes up
[1518-10-09 00:02] Guard #131 begins shift
[1518-05-24 00:57] wakes up
[1518-04-23 23:58] Guard #3187 begins shift
[1518-03-10 00:39] wakes up
[1518-05-17 00:01] Guard #1069 begins shift
[1518-04-24 23:56] Guard #2081 begins shift
[1518-09-06 00:58] wakes up
[1518-07-09 00:51] falls asleep
[1518-06-02 00:02] Guard #2081 begins shift
[1518-09-29 00:16] falls asleep
[1518-08-12 00:46] wakes up
[1518-04-05 23:54] Guard #2657 begins shift
[1518-11-23 00:51] wakes up
[1518-08-19 00:59] wakes up
[1518-02-07 00:35] wakes up
[1518-06-18 00:03] Guard #3181 begins shift
[1518-02-13 00:44] falls asleep
[1518-03-23 00:53] wakes up
[1518-06-23 00:20] falls asleep
[1518-10-24 00:37] wakes up
[1518-03-25 00:17] falls asleep
[1518-11-20 00:19] falls asleep
[1518-02-08 00:15] falls asleep
[1518-10-28 00:40] wakes up
[1518-02-08 00:04] wakes up
[1518-02-05 23:58] Guard #1201 begins shift
[1518-08-24 23:50] Guard #1069 begins shift
[1518-10-26 00:57] wakes up
[1518-02-09 00:40] wakes up
[1518-10-02 00:07] falls asleep
[1518-10-11 00:04] falls asleep
[1518-06-22 00:02] Guard #2017 begins shift
[1518-07-11 23:59] Guard #1217 begins shift
[1518-11-14 00:58] wakes up
[1518-07-28 00:16] falls asleep
[1518-10-18 00:38] wakes up
[1518-09-11 00:13] falls asleep
[1518-10-20 00:42] falls asleep
[1518-02-01 00:54] wakes up
[1518-04-15 23:58] Guard #2711 begins shift
[1518-02-14 00:18] falls asleep
[1518-03-08 23:54] Guard #2521 begins shift
[1518-03-21 23:47] Guard #1699 begins shift
[1518-07-07 00:14] falls asleep
[1518-06-29 00:18] falls asleep
[1518-07-16 00:20] wakes up
[1518-10-05 23:57] Guard #1217 begins shift
[1518-09-09 00:52] wakes up
[1518-11-10 00:42] wakes up
[1518-04-20 00:10] falls asleep
[1518-09-11 00:44] wakes up
[1518-04-06 00:54] wakes up
[1518-06-30 00:04] Guard #1699 begins shift
[1518-08-03 00:01] falls asleep
[1518-10-01 00:35] wakes up
[1518-09-01 00:01] Guard #1913 begins shift
[1518-09-13 23:58] Guard #1069 begins shift
[1518-07-27 00:48] wakes up
[1518-03-25 00:02] Guard #3137 begins shift
[1518-07-24 23:56] Guard #2657 begins shift
[1518-09-05 00:21] falls asleep
[1518-02-02 00:57] wakes up
[1518-05-01 00:03] Guard #263 begins shift
[1518-07-02 00:21] falls asleep
[1518-02-14 00:40] falls asleep
[1518-07-10 00:37] wakes up
[1518-05-06 00:02] Guard #617 begins shift
[1518-02-03 00:21] falls asleep
[1518-09-01 00:58] wakes up
[1518-06-03 00:52] wakes up
[1518-01-30 00:42] wakes up
[1518-07-03 00:36] falls asleep
[1518-08-13 23:54] Guard #3301 begins shift
[1518-10-11 00:35] falls asleep
[1518-08-18 00:42] falls asleep
[1518-11-02 00:34] falls asleep
[1518-02-12 00:47] falls asleep
[1518-05-15 00:48] wakes up
[1518-04-16 00:55] wakes up
[1518-04-03 00:18] wakes up
[1518-05-28 23:49] Guard #3187 begins shift
[1518-08-05 00:52] wakes up
[1518-02-05 00:30] falls asleep
[1518-09-01 00:52] wakes up
[1518-09-27 00:15] falls asleep
[1518-06-22 00:47] wakes up
[1518-07-03 00:03] Guard #3181 begins shift
[1518-02-24 00:53] wakes up
[1518-02-05 00:57] wakes up
[1518-06-20 00:24] falls asleep
[1518-10-01 00:03] falls asleep
[1518-06-30 00:55] wakes up
[1518-03-06 00:08] falls asleep
[1518-07-06 00:28] falls asleep
[1518-06-24 00:25] falls asleep
[1518-06-26 00:36] wakes up
[1518-08-01 00:58] wakes up
[1518-04-04 00:17] falls asleep
[1518-04-04 00:43] wakes up
[1518-09-24 00:40] falls asleep
[1518-02-21 00:13] wakes up
[1518-09-14 23:57] Guard #1069 begins shift
[1518-02-11 00:03] Guard #557 begins shift
[1518-09-12 00:57] falls asleep
[1518-05-28 00:35] wakes up
[1518-08-17 00:47] wakes up
[1518-04-19 00:31] falls asleep
[1518-09-02 00:27] wakes up
[1518-10-19 00:03] Guard #263 begins shift
[1518-02-15 00:36] falls asleep
[1518-08-26 00:29] falls asleep
[1518-02-20 00:55] falls asleep
[1518-11-18 00:48] wakes up
[1518-10-18 00:45] falls asleep
[1518-09-23 00:21] falls asleep
[1518-10-08 00:15] falls asleep
[1518-07-29 00:51] wakes up
[1518-06-20 00:52] wakes up
[1518-03-15 23:57] Guard #2711 begins shift
[1518-08-20 00:32] falls asleep
[1518-04-09 00:04] Guard #1201 begins shift
[1518-04-21 00:47] falls asleep
[1518-09-28 00:03] Guard #3137 begins shift
[1518-11-14 00:47] falls asleep
[1518-06-13 00:53] wakes up
[1518-07-26 00:55] falls asleep
[1518-07-25 23:58] Guard #1699 begins shift
[1518-03-13 00:01] Guard #2081 begins shift
[1518-04-12 00:34] falls asleep
[1518-08-10 00:20] falls asleep
[1518-10-23 00:44] wakes up
[1518-05-14 00:47] falls asleep
[1518-01-30 00:58] wakes up
[1518-03-15 00:41] falls asleep
[1518-03-10 00:03] falls asleep
[1518-11-07 23:58] Guard #2017 begins shift
[1518-03-23 00:36] falls asleep
[1518-05-13 00:04] falls asleep
[1518-06-29 00:53] falls asleep
[1518-06-08 00:40] falls asleep
[1518-10-23 00:00] Guard #557 begins shift
[1518-06-14 00:57] wakes up
[1518-03-22 00:02] falls asleep
[1518-05-04 23:57] Guard #1217 begins shift
[1518-09-25 00:51] wakes up
[1518-10-03 00:14] wakes up
[1518-05-21 00:01] Guard #1699 begins shift
[1518-08-17 23:59] Guard #2711 begins shift
[1518-11-17 00:04] falls asleep
[1518-09-29 23:56] Guard #263 begins shift
[1518-03-06 00:39] wakes up
[1518-04-16 23:52] Guard #3187 begins shift
[1518-10-04 00:59] wakes up
[1518-06-03 00:47] falls asleep
[1518-09-19 00:47] wakes up
[1518-03-06 23:58] Guard #3181 begins shift
[1518-10-30 23:47] Guard #1217 begins shift
[1518-02-24 00:42] wakes up
[1518-03-28 00:40] falls asleep
[1518-09-17 00:01] Guard #617 begins shift
[1518-03-12 00:46] wakes up
[1518-04-27 00:57] falls asleep
[1518-03-04 00:02] Guard #467 begins shift
[1518-07-18 23:59] Guard #2521 begins shift
[1518-06-29 00:47] wakes up
[1518-07-12 00:50] wakes up
[1518-05-09 00:27] wakes up
[1518-03-19 00:52] falls asleep
[1518-02-14 23:49] Guard #1933 begins shift
[1518-06-09 00:03] falls asleep
[1518-09-03 23:58] Guard #1217 begins shift
[1518-07-07 00:20] wakes up
[1518-02-16 00:24] falls asleep
[1518-08-08 00:29] falls asleep
[1518-05-12 23:46] Guard #2081 begins shift
[1518-11-05 00:37] falls asleep
[1518-06-30 23:57] Guard #1217 begins shift
[1518-11-22 00:15] falls asleep
[1518-07-21 00:29] falls asleep
[1518-11-09 00:55] wakes up
[1518-11-11 00:35] falls asleep
[1518-07-14 23:56] Guard #2521 begins shift
[1518-10-13 00:07] falls asleep
[1518-09-23 00:38] wakes up
[1518-04-29 00:36] falls asleep
[1518-08-04 00:34] falls asleep
[1518-05-14 00:00] Guard #263 begins shift
[1518-04-09 23:56] Guard #2521 begins shift
[1518-04-14 00:07] wakes up
[1518-03-19 00:59] wakes up
[1518-04-07 00:19] falls asleep
[1518-02-25 00:47] wakes up
[1518-03-29 00:20] falls asleep
[1518-09-28 23:56] Guard #2711 begins shift
[1518-04-02 00:55] wakes up
[1518-06-07 00:59] wakes up
[1518-05-29 00:15] wakes up
[1518-05-01 00:55] wakes up
[1518-11-03 00:00] Guard #2081 begins shift
[1518-11-02 00:24] wakes up
[1518-08-21 00:56] wakes up
[1518-10-23 00:52] falls asleep
[1518-11-13 00:04] Guard #2689 begins shift
[1518-06-19 00:36] falls asleep
[1518-07-07 00:52] wakes up
[1518-01-31 00:56] wakes up
[1518-09-16 00:04] Guard #2711 begins shift
[1518-07-17 23:56] Guard #557 begins shift
[1518-03-10 23:53] Guard #1069 begins shift
[1518-07-27 00:58] wakes up
[1518-02-23 00:31] falls asleep
[1518-05-18 00:05] falls asleep
[1518-05-01 00:42] wakes up
[1518-02-21 23:56] Guard #379 begins shift
[1518-02-01 00:57] falls asleep
[1518-06-19 23:57] Guard #2081 begins shift
[1518-11-13 00:53] falls asleep
[1518-06-13 23:46] Guard #2689 begins shift
[1518-11-10 00:25] falls asleep
[1518-01-31 00:43] falls asleep
[1518-07-30 00:35] falls asleep
[1518-02-13 23:58] Guard #1217 begins shift
[1518-04-26 00:58] wakes up
[1518-02-09 00:49] wakes up
[1518-08-10 23:58] Guard #1913 begins shift
[1518-05-12 00:24] falls asleep
[1518-02-14 00:44] wakes up
[1518-02-17 00:59] wakes up
[1518-10-24 00:02] Guard #1699 begins shift
[1518-10-23 00:41] falls asleep
[1518-10-11 00:17] wakes up
[1518-08-10 00:48] falls asleep
[1518-10-11 00:37] wakes up
[1518-09-19 23:48] Guard #2521 begins shift
[1518-04-23 00:46] falls asleep
[1518-07-22 00:42] falls asleep
[1518-07-28 00:41] wakes up
[1518-05-24 00:30] falls asleep
[1518-06-05 00:15] falls asleep
[1518-04-28 00:52] wakes up
[1518-10-31 00:04] falls asleep
[1518-07-06 23:57] Guard #3187 begins shift
[1518-11-05 00:26] wakes up
[1518-08-02 00:36] falls asleep
[1518-06-20 00:37] falls asleep
[1518-02-07 00:03] falls asleep
[1518-10-27 00:00] Guard #379 begins shift
[1518-08-21 23:57] Guard #617 begins shift
[1518-05-30 00:31] falls asleep
[1518-04-16 00:54] falls asleep
[1518-05-26 00:25] wakes up
[1518-05-07 00:18] falls asleep
[1518-03-28 00:46] wakes up
[1518-07-18 00:15] falls asleep
[1518-04-21 23:59] Guard #2689 begins shift
[1518-05-22 00:59] wakes up
[1518-07-08 00:00] Guard #1933 begins shift
[1518-06-06 23:57] Guard #1217 begins shift
[1518-01-31 00:40] wakes up
[1518-04-22 23:56] Guard #2521 begins shift
[1518-03-11 00:04] falls asleep
[1518-08-14 00:57] wakes up
[1518-09-23 00:00] falls asleep
[1518-10-04 23:56] Guard #1201 begins shift
[1518-08-30 00:51] falls asleep
[1518-07-27 23:59] Guard #2521 begins shift
[1518-08-14 00:04] falls asleep
[1518-07-17 00:39] falls asleep
[1518-07-19 00:14] falls asleep
[1518-04-30 00:00] Guard #1913 begins shift
[1518-08-18 23:56] Guard #1217 begins shift
[1518-09-16 00:28] falls asleep
[1518-08-23 00:21] falls asleep
[1518-08-28 00:06] falls asleep
[1518-11-23 00:56] wakes up
[1518-02-13 00:02] Guard #2689 begins shift
[1518-02-27 00:59] wakes up
[1518-10-29 23:59] Guard #2657 begins shift
[1518-10-12 00:57] wakes up
[1518-10-03 23:57] Guard #3181 begins shift
[1518-11-22 00:57] falls asleep
[1518-07-16 00:11] falls asleep
[1518-01-31 00:02] Guard #1201 begins shift
[1518-02-16 00:00] Guard #1913 begins shift
[1518-09-10 23:58] Guard #2689 begins shift
[1518-06-03 00:08] falls asleep
[1518-09-18 23:56] Guard #1217 begins shift
[1518-06-20 00:59] wakes up
[1518-04-27 00:52] wakes up
[1518-11-14 23:58] Guard #1699 begins shift
[1518-11-03 00:59] wakes up
[1518-05-02 00:00] falls asleep
[1518-08-20 00:14] falls asleep
[1518-04-11 00:40] falls asleep
[1518-06-22 00:07] falls asleep
[1518-11-23 00:54] falls asleep
[1518-09-24 23:52] Guard #3187 begins shift
[1518-07-24 00:17] falls asleep
[1518-04-21 00:00] falls asleep
[1518-09-30 23:50] Guard #3137 begins shift
[1518-05-06 00:07] falls asleep
[1518-11-13 00:47] wakes up
[1518-08-04 23:46] Guard #3187 begins shift
[1518-09-01 00:57] falls asleep
[1518-08-17 00:04] Guard #1201 begins shift
[1518-02-05 00:01] Guard #263 begins shift
[1518-05-03 00:09] falls asleep
[1518-02-10 00:14] falls asleep
[1518-10-29 00:50] wakes up
[1518-03-22 00:50] wakes up
[1518-04-06 00:47] falls asleep
[1518-10-11 23:59] Guard #263 begins shift
[1518-04-25 00:36] wakes up
[1518-07-31 00:46] wakes up
[1518-05-26 00:13] falls asleep
[1518-03-17 00:13] falls asleep
[1518-02-11 00:49] falls asleep
[1518-09-30 00:52] wakes up
[1518-04-01 23:57] Guard #2711 begins shift
[1518-02-11 00:50] wakes up
[1518-06-24 23:50] Guard #3301 begins shift
[1518-03-02 00:43] wakes up
[1518-05-05 00:26] falls asleep
[1518-03-17 00:35] falls asleep
[1518-02-01 00:59] wakes up
[1518-05-31 00:57] wakes up
[1518-03-09 00:44] wakes up
[1518-07-03 00:06] falls asleep
[1518-05-04 00:39] wakes up
[1518-11-07 00:50] wakes up
[1518-08-22 00:59] wakes up
[1518-04-20 00:36] wakes up
[1518-02-13 00:50] wakes up
[1518-10-30 00:15] wakes up
[1518-08-14 00:49] falls asleep
[1518-03-03 00:30] falls asleep
[1518-09-22 00:49] falls asleep
[1518-03-18 00:02] Guard #2657 begins shift
[1518-07-07 00:42] falls asleep
[1518-02-09 00:46] falls asleep
[1518-11-18 00:59] wakes up
[1518-10-18 00:56] wakes up
[1518-10-23 00:54] wakes up
[1518-02-15 00:09] wakes up
[1518-05-09 00:00] Guard #1933 begins shift
[1518-03-24 00:46] falls asleep
[1518-06-20 00:29] wakes up
[1518-03-05 00:51] wakes up
[1518-07-11 00:01] Guard #467 begins shift
[1518-04-18 00:41] falls asleep
[1518-05-22 00:27] falls asleep
[1518-07-20 00:51] falls asleep
[1518-04-18 00:44] wakes up
[1518-11-20 00:03] Guard #1933 begins shift
[1518-06-11 23:51] Guard #617 begins shift
[1518-07-30 00:58] wakes up
[1518-08-02 00:59] wakes up
[1518-08-30 23:50] Guard #263 begins shift
[1518-07-25 00:54] wakes up
[1518-07-24 00:37] wakes up
[1518-11-10 23:56] Guard #1069 begins shift
[1518-06-09 00:47] wakes up
[1518-03-26 00:03] Guard #3187 begins shift
[1518-03-14 23:58] Guard #3181 begins shift
[1518-08-31 00:47] wakes up
[1518-02-09 00:00] falls asleep
[1518-10-28 23:58] Guard #617 begins shift
[1518-05-09 23:58] Guard #2081 begins shift
[1518-03-16 00:49] falls asleep
[1518-11-10 00:03] Guard #1069 begins shift
[1518-08-04 00:48] falls asleep
[1518-08-05 00:24] wakes up
[1518-01-30 00:53] falls asleep
[1518-02-18 00:48] wakes up
[1518-10-24 23:54] Guard #1201 begins shift
[1518-07-25 00:22] falls asleep
[1518-11-07 00:29] falls asleep
[1518-04-01 00:46] falls asleep
[1518-03-17 00:59] wakes up
[1518-07-02 00:01] Guard #467 begins shift
[1518-11-03 00:27] wakes up
[1518-09-03 00:22] falls asleep
[1518-11-20 00:45] wakes up
[1518-09-14 00:45] wakes up
[1518-10-20 00:33] wakes up
[1518-02-01 00:27] falls asleep
[1518-10-04 00:20] wakes up
[1518-08-08 00:30] wakes up
[1518-03-28 00:57] wakes up
[1518-06-04 00:51] wakes up
[1518-09-04 00:16] falls asleep
[1518-05-21 00:52] falls asleep
[1518-09-27 00:00] Guard #1217 begins shift
[1518-10-24 00:41] falls asleep
[1518-03-23 00:05] falls asleep
[1518-02-10 00:48] falls asleep
[1518-06-12 00:04] falls asleep
[1518-08-03 00:56] wakes up
[1518-11-12 00:53] wakes up
[1518-06-07 23:59] Guard #1933 begins shift
[1518-04-02 23:46] Guard #2081 begins shift
[1518-07-30 00:36] wakes up
[1518-08-20 23:58] Guard #3137 begins shift
[1518-02-21 00:16] falls asleep
[1518-02-13 00:56] wakes up
[1518-03-31 00:02] Guard #1699 begins shift
[1518-03-27 00:21] falls asleep
[1518-08-26 00:01] Guard #1217 begins shift
[1518-11-20 00:48] falls asleep
[1518-02-25 00:57] falls asleep
[1518-07-05 00:19] falls asleep
[1518-10-14 00:40] wakes up
[1518-09-11 00:48] wakes up
[1518-03-14 00:52] wakes up
[1518-04-29 00:27] falls asleep
[1518-10-14 00:30] falls asleep
[1518-08-23 00:01] Guard #2081 begins shift
[1518-02-13 00:54] falls asleep
[1518-09-15 00:57] wakes up
[1518-11-17 00:54] wakes up
[1518-09-18 00:44] wakes up
[1518-08-25 00:19] wakes up
[1518-03-30 00:00] Guard #263 begins shift
[1518-02-07 23:49] Guard #3137 begins shift
[1518-08-07 00:09] falls asleep
[1518-10-06 00:34] falls asleep
[1518-06-11 00:16] falls asleep
[1518-06-05 00:00] Guard #1699 begins shift
[1518-04-08 00:01] Guard #2711 begins shift
[1518-04-27 00:59] wakes up
[1518-06-05 00:30] wakes up
[1518-07-01 00:52] wakes up
[1518-06-28 00:31] falls asleep
[1518-09-23 23:59] Guard #1933 begins shift
[1518-02-24 00:52] falls asleep
[1518-09-30 00:38] wakes up
[1518-05-04 00:37] falls asleep
[1518-03-09 00:03] falls asleep
[1518-02-12 00:32] falls asleep
[1518-07-31 00:16] falls asleep
[1518-08-09 00:55] falls asleep
[1518-07-08 00:42] falls asleep
[1518-09-16 00:49] wakes up
[1518-06-01 00:42] wakes up
[1518-08-26 00:44] wakes up
[1518-07-06 00:03] Guard #3137 begins shift
[1518-07-19 00:58] wakes up
[1518-08-29 00:52] wakes up
[1518-03-20 00:22] falls asleep
[1518-05-27 00:17] falls asleep
[1518-09-04 00:58] wakes up
[1518-07-02 00:46] wakes up
[1518-05-13 00:39] wakes up
[1518-07-05 00:36] wakes up
[1518-09-17 00:23] falls asleep
[1518-11-03 00:46] falls asleep
[1518-06-19 00:43] wakes up
[1518-05-01 00:51] falls asleep
[1518-10-01 00:52] falls asleep
[1518-08-12 00:20] falls asleep
[1518-08-19 00:13] falls asleep
[1518-08-01 00:54] falls asleep
[1518-02-19 00:48] falls asleep
[1518-07-15 00:37] wakes up
[1518-05-16 00:02] Guard #131 begins shift
[1518-03-06 00:26] falls asleep
[1518-06-16 00:56] wakes up
[1518-03-15 00:24] wakes up
[1518-03-05 00:22] falls asleep
[1518-07-09 00:48] wakes up
[1518-08-28 00:00] Guard #3137 begins shift
[1518-05-31 00:41] falls asleep
[1518-02-18 23:56] Guard #2017 begins shift
[1518-03-31 00:24] falls asleep
[1518-07-21 23:58] Guard #2711 begins shift
[1518-07-27 00:57] falls asleep
[1518-05-22 00:03] Guard #2017 begins shift
[1518-11-17 00:24] wakes up
[1518-05-23 00:50] wakes up
[1518-09-15 00:09] falls asleep
[1518-02-26 23:58] Guard #3187 begins shift
[1518-09-22 00:00] Guard #2521 begins shift
[1518-07-09 00:59] wakes up
[1518-06-02 00:19] falls asleep
[1518-02-20 00:28] wakes up
[1518-07-20 00:06] falls asleep
[1518-10-20 00:01] Guard #617 begins shift
[1518-07-06 00:52] wakes up
[1518-08-30 00:54] wakes up
[1518-11-13 23:54] Guard #1217 begins shift
[1518-06-04 00:56] falls asleep
[1518-05-03 00:00] Guard #1069 begins shift
[1518-08-11 00:38] falls asleep
[1518-05-15 00:02] falls asleep
[1518-08-11 00:11] falls asleep
[1518-08-14 00:34] wakes up
[1518-08-08 00:36] falls asleep
[1518-05-20 00:46] falls asleep
[1518-11-20 00:59] wakes up
[1518-11-09 00:53] falls asleep
[1518-04-03 00:01] falls asleep
[1518-02-03 00:34] wakes up
[1518-05-18 00:58] wakes up
[1518-03-19 00:13] falls asleep
[1518-03-04 23:57] Guard #1913 begins shift
[1518-10-31 23:53] Guard #263 begins shift
[1518-05-28 00:57] wakes up
[1518-10-07 00:51] wakes up
[1518-10-02 00:28] falls asleep
[1518-08-31 00:22] wakes up
[1518-06-01 00:41] falls asleep
[1518-09-06 00:04] Guard #1933 begins shift
[1518-08-04 00:52] wakes up
[1518-05-23 00:11] falls asleep
[1518-03-02 00:47] falls asleep
[1518-07-12 00:57] falls asleep
[1518-05-12 00:54] wakes up
[1518-03-31 23:59] Guard #1933 begins shift
[1518-09-07 00:43] wakes up
[1518-06-13 00:58] wakes up
[1518-05-25 23:59] Guard #2657 begins shift
[1518-05-11 00:44] wakes up
[1518-10-08 00:11] wakes up
[1518-06-16 00:46] wakes up
[1518-06-28 00:00] Guard #2017 begins shift
[1518-04-17 00:01] falls asleep
[1518-10-29 00:48] falls asleep
[1518-04-08 00:38] wakes up
[1518-06-26 00:50] falls asleep
[1518-06-13 00:48] falls asleep
[1518-09-22 00:51] wakes up
[1518-09-03 00:31] wakes up
[1518-06-19 00:14] falls asleep
[1518-07-31 00:26] wakes up
[1518-08-30 00:28] wakes up
[1518-04-10 00:50] falls asleep
[1518-10-18 00:35] falls asleep
[1518-07-11 00:44] wakes up
[1518-08-30 00:23] falls asleep
[1518-02-12 00:43] wakes up
[1518-06-25 00:03] falls asleep
[1518-04-24 00:18] falls asleep
[1518-08-04 00:03] Guard #1933 begins shift
[1518-04-22 00:46] wakes up
[1518-11-03 00:22] falls asleep
[1518-08-12 00:00] Guard #2657 begins shift
[1518-03-20 23:56] Guard #1913 begins shift
[1518-10-20 00:59] wakes up
[1518-10-13 23:57] Guard #3181 begins shift
[1518-03-22 00:30] falls asleep
[1518-09-19 00:38] falls asleep
[1518-07-30 23:58] Guard #3181 begins shift
[1518-10-07 00:34] falls asleep
[1518-07-24 00:00] Guard #1217 begins shift
[1518-05-20 00:00] Guard #617 begins shift
[1518-06-12 00:57] wakes up
[1518-09-13 00:33] falls asleep
[1518-11-22 00:02] Guard #2657 begins shift
[1518-06-04 00:36] falls asleep
[1518-09-26 00:57] wakes up
[1518-10-07 00:45] falls asleep
[1518-11-22 00:19] wakes up
[1518-11-19 00:32] falls asleep
[1518-03-21 00:42] wakes up
[1518-09-30 00:29] falls asleep
[1518-05-25 00:57] wakes up
[1518-04-02 00:54] falls asleep
[1518-09-25 23:56] Guard #1933 begins shift
[1518-05-25 00:52] wakes up
[1518-06-29 00:57] wakes up
[1518-06-19 00:04] Guard #1699 begins shift
[1518-02-03 23:57] Guard #3181 begins shift
[1518-03-28 00:52] falls asleep
[1518-05-21 00:56] falls asleep
[1518-06-24 00:29] wakes up
[1518-10-20 23:57] Guard #1217 begins shift
[1518-03-19 00:00] Guard #1069 begins shift
[1518-05-27 00:45] wakes up
[1518-05-10 00:25] wakes up
[1518-04-13 23:52] Guard #467 begins shift
[1518-07-09 00:29] falls asleep
[1518-02-19 23:58] Guard #2657 begins shift
[1518-08-11 00:29] wakes up
[1518-10-13 00:02] Guard #2521 begins shift
[1518-08-05 00:05] falls asleep
[1518-03-09 00:04] wakes up
[1518-11-06 00:46] wakes up
[1518-09-15 00:14] wakes up
[1518-03-06 00:18] wakes up
[1518-09-25 00:45] falls asleep
[1518-02-27 00:53] falls asleep
[1518-02-26 00:46] falls asleep
[1518-05-04 00:04] falls asleep
[1518-11-04 23:59] Guard #2017 begins shift
[1518-04-19 00:51] wakes up
[1518-06-29 00:46] falls asleep
[1518-04-20 00:52] falls asleep
[1518-02-17 00:02] Guard #263 begins shift
[1518-04-12 00:53] wakes up
[1518-09-22 23:52] Guard #2081 begins shift
[1518-05-05 00:34] wakes up
[1518-02-19 00:34] wakes up
[1518-04-13 00:00] Guard #3529 begins shift
[1518-02-25 00:59] wakes up
[1518-05-19 00:54] wakes up
[1518-06-11 00:59] wakes up
[1518-04-02 00:41] wakes up
[1518-06-02 00:57] wakes up
[1518-06-27 00:18] wakes up
[1518-05-31 23:58] Guard #3181 begins shift
[1518-06-28 00:58] wakes up
[1518-02-08 00:22] wakes up
[1518-03-01 00:09] falls asleep
[1518-03-09 00:26] falls asleep
[1518-06-03 00:43] wakes up
[1518-09-09 00:23] falls asleep
[1518-10-26 00:46] falls asleep
[1518-10-15 00:37] wakes up
[1518-09-22 00:40] wakes up
[1518-10-02 00:18] wakes up
[1518-06-07 00:18] falls asleep
[1518-09-21 00:43] falls asleep
[1518-01-31 00:37] falls asleep
[1518-03-21 00:38] falls asleep
[1518-05-14 00:54] wakes up
[1518-11-07 00:02] Guard #3181 begins shift
[1518-08-02 00:00] Guard #3301 begins shift
[1518-04-05 00:38] wakes up
[1518-10-07 23:46] Guard #2081 begins shift
[1518-11-02 00:03] Guard #1069 begins shift
[1518-08-17 00:53] falls asleep
[1518-06-08 00:54] wakes up
[1518-06-09 23:58] Guard #2081 begins shift
[1518-02-20 00:47] falls asleep
[1518-08-19 23:50] Guard #2521 begins shift
[1518-10-14 23:58] Guard #2657 begins shift
[1518-10-03 00:30] falls asleep
[1518-09-27 00:43] falls asleep
[1518-11-05 00:12] falls asleep
[1518-07-04 00:31] falls asleep
[1518-03-25 00:53] wakes up
[1518-10-08 00:00] falls asleep
[1518-11-19 00:18] falls asleep
[1518-05-08 00:00] Guard #617 begins shift
[1518-02-25 00:03] Guard #3187 begins shift
[1518-02-19 00:59] wakes up
[1518-08-06 00:52] wakes up
[1518-04-15 00:02] Guard #3301 begins shift
[1518-11-17 23:57] Guard #2657 begins shift
[1518-11-08 00:42] falls asleep
[1518-06-17 00:39] falls asleep
[1518-07-14 00:56] wakes up
[1518-08-06 00:25] falls asleep
[1518-08-20 00:28] wakes up
[1518-02-10 00:00] Guard #2689 begins shift
[1518-02-08 23:53] Guard #2657 begins shift
[1518-03-31 00:49] wakes up
[1518-11-17 00:43] wakes up
[1518-06-05 23:59] Guard #1217 begins shift
[1518-07-27 00:17] falls asleep
[1518-10-10 23:54] Guard #1913 begins shift
[1518-08-10 00:00] Guard #2711 begins shift
[1518-03-11 00:56] wakes up
[1518-09-15 00:38] falls asleep
[1518-03-20 00:28] wakes up
[1518-03-03 00:55] wakes up
[1518-09-02 00:53] wakes up
[1518-03-24 00:34] wakes up
[1518-09-19 00:57] wakes up
[1518-08-01 00:02] Guard #1069 begins shift
[1518-09-08 00:03] Guard #2657 begins shift
[1518-11-14 00:40] wakes up
[1518-10-20 00:20] falls asleep
[1518-08-24 00:59] wakes up
[1518-05-22 23:59] Guard #1069 begins shift
[1518-04-04 23:58] Guard #557 begins shift
[1518-03-18 00:50] wakes up
[1518-08-17 00:54] wakes up
[1518-11-13 00:19] falls asleep
[1518-11-12 00:00] falls asleep
[1518-07-20 00:15] wakes up
[1518-03-07 00:48] wakes up
[1518-05-28 00:41] falls asleep
[1518-09-02 00:03] Guard #2657 begins shift
[1518-03-02 00:38] falls asleep
[1518-09-21 00:13] falls asleep
[1518-08-24 00:00] Guard #467 begins shift
[1518-10-04 00:44] falls asleep
[1518-07-15 00:34] falls asleep
[1518-08-18 00:59] wakes up
[1518-06-25 00:58] wakes up
[1518-04-26 00:10] falls asleep
[1518-10-06 00:54] wakes up
[1518-02-14 00:35] wakes up
[1518-09-06 23:59] Guard #1069 begins shift
[1518-09-28 00:23] falls asleep
[1518-04-06 00:41] falls asleep
[1518-02-26 00:48] wakes up
[1518-06-24 00:02] Guard #3301 begins shift
[1518-06-25 23:53] Guard #1217 begins shift
[1518-09-18 00:06] falls asleep
[1518-02-23 00:38] wakes up
[1518-02-16 00:50] wakes up
[1518-04-21 00:59] wakes up
[1518-06-08 00:31] wakes up
[1518-11-04 00:46] wakes up
[1518-05-03 00:59] wakes up
[1518-08-09 00:56] wakes up
[1518-02-20 23:54] Guard #2689 begins shift
[1518-04-29 00:45] wakes up
[1518-03-06 00:58] wakes up
[1518-11-19 00:56] wakes up
[1518-08-15 00:32] wakes up
[1518-02-10 00:19] wakes up
[1518-06-10 00:20] falls asleep
[1518-11-18 00:37] falls asleep
[1518-08-20 00:03] falls asleep
[1518-03-18 00:27] falls asleep
[1518-07-15 00:45] falls asleep
[1518-07-12 00:17] falls asleep
[1518-03-24 00:26] falls asleep
[1518-10-05 00:08] falls asleep
[1518-08-10 00:55] wakes up
[1518-07-04 23:59] Guard #3301 begins shift
[1518-03-04 00:08] falls asleep
[1518-07-30 00:00] Guard #2711 begins shift
[1518-07-10 00:35] falls asleep
[1518-02-26 00:00] Guard #467 begins shift
[1518-10-29 00:22] wakes up
[1518-08-04 00:42] wakes up
[1518-03-08 00:16] falls asleep
[1518-09-05 00:29] wakes up
[1518-06-13 00:31] falls asleep
[1518-07-26 00:51] wakes up
[1518-04-01 00:24] wakes up
[1518-07-13 00:04] Guard #3529 begins shift
[1518-02-11 00:43] wakes up
[1518-10-31 00:09] wakes up
[1518-04-08 00:36] falls asleep
[1518-09-22 00:10] falls asleep
[1518-03-17 00:49] wakes up
[1518-05-26 00:58] wakes up
[1518-08-23 00:26] wakes up
[1518-08-19 00:20] wakes up
[1518-04-20 23:52] Guard #3301 begins shift
[1518-02-28 00:02] Guard #2017 begins shift
[1518-06-15 00:35] falls asleep
[1518-04-22 00:10] falls asleep
[1518-04-19 00:03] Guard #1933 begins shift
[1518-10-01 23:59] Guard #3187 begins shift
[1518-07-10 00:44] falls asleep
[1518-02-01 23:59] Guard #467 begins shift
[1518-06-10 23:57] Guard #2657 begins shift
[1518-07-15 00:52] wakes up
[1518-05-09 00:32] falls asleep
[1518-08-20 00:57] wakes up
[1518-05-08 00:49] wakes up
[1518-11-21 00:34] wakes up
[1518-03-05 23:59] Guard #1069 begins shift
[1518-09-09 00:04] Guard #2689 begins shift
[1518-08-13 00:57] wakes up
[1518-02-12 00:01] Guard #3181 begins shift
[1518-11-22 23:59] Guard #2711 begins shift
[1518-09-04 00:50] wakes up
[1518-08-25 00:01] falls asleep
[1518-04-12 00:03] Guard #2689 begins shift
[1518-04-30 00:42] falls asleep
[1518-10-14 00:49] falls asleep
[1518-07-14 00:03] Guard #1933 begins shift
[1518-05-07 00:03] Guard #467 begins shift
[1518-05-29 00:03] falls asleep
[1518-08-08 23:57] Guard #1933 begins shift
[1518-05-14 23:52] Guard #3187 begins shift
[1518-09-13 00:59] wakes up
[1518-03-23 00:16] wakes up
[1518-06-13 00:42] wakes up
[1518-07-04 00:02] Guard #467 begins shift
[1518-08-10 00:45] wakes up
[1518-03-02 00:54] wakes up
[1518-05-11 00:04] Guard #1913 begins shift
[1518-10-19 00:22] falls asleep
[1518-10-06 23:58] Guard #3187 begins shift
[1518-07-03 00:16] wakes up
[1518-04-15 00:24] falls asleep
[1518-09-21 00:29] wakes up
[1518-04-06 00:31] wakes up
[1518-02-26 00:33] wakes up
[1518-04-07 00:03] Guard #2657 begins shift
[1518-05-09 00:46] wakes up
[1518-11-09 00:05] falls asleep
[1518-05-12 00:52] falls asleep
[1518-03-29 00:29] wakes up
[1518-06-20 00:56] falls asleep
[1518-11-16 00:04] Guard #617 begins shift
[1518-03-06 00:49] falls asleep
[1518-05-25 00:55] falls asleep
[1518-09-30 00:41] falls asleep
[1518-04-03 00:26] falls asleep
[1518-06-27 00:23] falls asleep
[1518-02-12 00:52] wakes up
[1518-03-22 00:25] wakes up
[1518-05-08 00:24] falls asleep
[1518-07-06 00:45] falls asleep
[1518-07-08 23:56] Guard #1913 begins shift
[1518-09-03 00:00] Guard #617 begins shift
[1518-06-16 00:02] Guard #1217 begins shift
[1518-05-25 00:23] falls asleep
[1518-07-21 00:43] wakes up
[1518-11-01 00:01] falls asleep
[1518-02-08 00:00] falls asleep
[1518-08-21 00:55] falls asleep
[1518-03-24 00:00] falls asleep
[1518-05-03 23:50] Guard #557 begins shift
[1518-07-21 00:03] Guard #2689 begins shift
[1518-09-03 00:46] falls asleep
[1518-03-09 23:46] Guard #2081 begins shift
[1518-06-14 00:30] wakes up
[1518-03-13 00:12] falls asleep
[1518-10-27 23:58] Guard #2017 begins shift
[1518-07-19 23:57] Guard #1201 begins shift
[1518-07-04 00:54] wakes up
[1518-09-04 23:59] Guard #2657 begins shift
[1518-11-09 00:46] wakes up
[1518-07-14 00:21] falls asleep
[1518-11-08 23:50] Guard #2017 begins shift
[1518-09-19 00:54] falls asleep
[1518-06-23 00:17] wakes up
[1518-08-12 23:59] Guard #3187 begins shift
[1518-11-04 00:19] falls asleep
[1518-06-03 00:04] Guard #2657 begins shift
[1518-10-24 00:58] wakes up
[1518-03-29 00:00] Guard #617 begins shift
[1518-04-06 00:43] wakes up
[1518-11-16 00:38] wakes up
[1518-06-16 00:10] falls asleep
[1518-03-23 00:57] falls asleep
[1518-06-04 00:00] Guard #3181 begins shift
[1518-05-21 00:38] wakes up
[1518-10-05 00:57] wakes up
[1518-06-01 00:57] wakes up
[1518-09-17 23:58] Guard #557 begins shift
[1518-07-20 00:58] wakes up
[1518-11-03 00:56] falls asleep
[1518-09-12 00:42] falls asleep
[1518-07-04 00:11] falls asleep
[1518-04-17 00:59] wakes up
[1518-10-17 00:02] Guard #2521 begins shift
[1518-06-29 00:01] Guard #2689 begins shift
[1518-07-14 00:30] wakes up
[1518-04-28 00:32] falls asleep
[1518-08-15 23:58] Guard #3529 begins shift
[1518-06-21 00:01] Guard #379 begins shift
[1518-06-18 00:36] falls asleep
[1518-09-04 00:56] falls asleep
[1518-11-11 00:59] wakes up
[1518-05-21 00:35] falls asleep
[1518-02-06 00:39] falls asleep
[1518-08-30 00:36] falls asleep
[1518-03-28 00:00] Guard #1201 begins shift
[1518-06-27 00:38] wakes up
[1518-11-11 23:48] Guard #617 begins shift
[1518-04-23 00:48] wakes up
[1518-05-18 23:56] Guard #1933 begins shift
[1518-03-26 00:20] falls asleep
[1518-03-19 00:42] wakes up
[1518-10-25 00:02] falls asleep
[1518-04-11 00:59] wakes up
[1518-04-11 00:03] Guard #2017 begins shift
[1518-09-09 23:50] Guard #2711 begins shift
[1518-10-05 00:41] wakes up
[1518-08-29 00:24] falls asleep
[1518-03-15 00:44] wakes up
[1518-03-03 00:00] Guard #3181 begins shift
[1518-08-09 00:25] falls asleep
[1518-08-30 00:48] wakes up
[1518-11-22 00:25] falls asleep
[1518-02-28 00:51] wakes up
[1518-04-06 00:01] falls asleep
[1518-04-05 00:18] falls asleep
[1518-09-25 00:03] falls asleep
[1518-08-22 00:53] falls asleep
[1518-08-27 00:18] falls asleep
[1518-10-29 00:06] falls asleep
[1518-02-15 00:48] wakes up
[1518-05-24 00:04] Guard #1913 begins shift
[1518-05-12 00:01] Guard #3301 begins shift
[1518-09-06 00:12] falls asleep
[1518-04-27 00:07] falls asleep
[1518-02-02 00:25] falls asleep
[1518-08-24 00:19] falls asleep
[1518-05-17 23:54] Guard #2689 begins shift
[1518-02-17 00:13] falls asleep
[1518-07-03 00:39] wakes up
[1518-10-10 00:15] falls asleep
[1518-06-04 00:57] wakes up
[1518-06-23 00:42] wakes up
[1518-07-26 00:07] falls asleep
[1518-11-02 00:20] falls asleep
[1518-02-24 00:56] falls asleep
[1518-05-28 00:08] falls asleep
[1518-04-10 00:54] wakes up
[1518-04-18 00:47] falls asleep
[1518-09-28 00:45] wakes up
[1518-10-16 00:04] Guard #131 begins shift
[1518-10-04 00:13] falls asleep
[1518-05-20 00:51] wakes up
[1518-05-17 00:43] falls asleep
[1518-11-21 00:15] falls asleep
[1518-11-17 00:47] falls asleep
[1518-03-13 23:56] Guard #1699 begins shift
[1518-10-08 00:34] wakes up
[1518-06-18 00:58] wakes up
[1518-02-02 23:59] Guard #557 begins shift
[1518-03-26 00:29] wakes up
[1518-03-24 00:17] wakes up
[1518-03-03 00:16] falls asleep
[1518-09-20 00:02] falls asleep
[1518-10-09 23:56] Guard #3301 begins shift
[1518-03-01 00:56] wakes up
[1518-02-10 00:50] wakes up
[1518-03-30 00:27] falls asleep
[1518-05-19 00:46] falls asleep
[1518-08-25 00:52] wakes up
[1518-11-19 00:51] falls asleep
[1518-08-26 23:58] Guard #2711 begins shift
[1518-06-19 00:27] wakes up
[1518-03-14 00:42] falls asleep
[1518-05-01 23:46] Guard #3301 begins shift
[1518-11-07 00:58] wakes up
[1518-09-10 00:54] wakes up
[1518-10-24 00:09] falls asleep
[1518-10-02 00:46] wakes up
[1518-06-09 00:05] wakes up
[1518-03-13 00:55] wakes up
[1518-09-07 00:13] falls asleep
[1518-09-17 00:44] wakes up
[1518-03-14 00:18] falls asleep
[1518-07-16 00:00] Guard #1201 begins shift
[1518-04-30 00:59] wakes up
[1518-03-20 00:00] Guard #2081 begins shift
[1518-05-06 00:56] wakes up
[1518-03-11 23:59] Guard #3187 begins shift
[1518-05-11 00:20] falls asleep
[1518-09-25 00:40] wakes up
[1518-07-17 00:53] wakes up
[1518-06-23 00:14] falls asleep
[1518-06-26 00:55] wakes up
[1518-08-14 23:57] Guard #2081 begins shift
[1518-05-10 00:17] falls asleep
[1518-05-20 00:40] wakes up
[1518-11-15 00:54] wakes up
[1518-05-06 00:47] falls asleep
[1518-10-19 00:56] wakes up
[1518-03-17 00:32] wakes up
[1518-05-31 00:00] Guard #3181 begins shift
[1518-06-26 00:00] falls asleep
[1518-11-19 00:48] wakes up
[1518-02-28 23:58] Guard #2081 begins shift
[1518-03-22 00:55] wakes up
[1518-04-26 00:00] Guard #557 begins shift
[1518-03-15 00:09] falls asleep
[1518-02-24 00:07] falls asleep
[1518-09-24 00:59] wakes up
[1518-06-09 00:11] falls asleep
[1518-09-21 00:04] Guard #2711 begins shift
[1518-08-17 00:35] falls asleep
[1518-07-10 00:49] wakes up
[1518-02-18 00:25] falls asleep
[1518-02-21 00:03] falls asleep
[1518-06-06 00:11] falls asleep
[1518-08-29 00:00] Guard #3301 begins shift
[1518-08-09 00:48] wakes up
[1518-08-19 00:27] falls asleep
[1518-07-30 00:54] falls asleep
[1518-03-23 23:48] Guard #3137 begins shift
[1518-11-13 00:55] wakes up
[1518-10-17 00:45] wakes up
[1518-05-02 00:22] wakes up
[1518-11-02 00:51] wakes up
[1518-09-21 00:53] wakes up
[1518-05-01 00:33] falls asleep
[1518-05-19 00:22] falls asleep
[1518-09-08 00:26] wakes up
[1518-08-06 23:59] Guard #617 begins shift
[1518-02-23 23:59] Guard #617 begins shift
[1518-02-25 00:25] falls asleep
[1518-05-26 00:40] falls asleep
[1518-11-05 00:58] wakes up
[1518-02-24 00:59] wakes up
[1518-05-30 00:37] wakes up
[1518-10-10 00:27] wakes up
[1518-04-03 23:56] Guard #2689 begins shift
[1518-07-23 00:03] Guard #2081 begins shift
[1518-04-29 00:31] wakes up
[1518-10-05 00:51] falls asleep
[1518-09-13 00:04] Guard #3181 begins shift
[1518-05-29 23:59] Guard #2689 begins shift
[1518-10-17 00:28] wakes up
[1518-05-26 23:58] Guard #3181 begins shift
[1518-11-19 00:22] wakes up
[1518-02-20 00:10] falls asleep
[1518-03-22 23:52] Guard #617 begins shift
[1518-06-15 00:44] wakes up
[1518-11-03 00:51] wakes up
[1518-06-23 00:04] Guard #2521 begins shift
[1518-05-20 00:06] falls asleep
[1518-08-30 00:03] Guard #2081 begins shift
[1518-02-28 00:30] falls asleep
[1518-08-27 00:53] wakes up
[1518-11-01 00:58] wakes up
[1518-10-28 00:15] falls asleep
[1518-07-11 00:27] falls asleep
[1518-05-17 00:48] wakes up
[1518-09-27 00:17] wakes up
[1518-08-08 00:59] wakes up
[1518-07-26 00:59] wakes up
[1518-08-31 00:43] falls asleep
[1518-07-29 00:26] falls asleep
[1518-02-15 00:02] falls asleep
[1518-10-17 23:57] Guard #3301 begins shift
[1518-11-07 00:53] falls asleep
[1518-07-22 00:53] wakes up
[1518-04-01 00:13] falls asleep
[1518-11-22 00:52] wakes up
[1518-10-03 00:09] falls asleep
[1518-11-16 23:49] Guard #557 begins shift
[1518-11-18 23:56] Guard #1069 begins shift
[1518-11-06 00:18] falls asleep
[1518-02-01 00:04] Guard #2521 begins shift
[1518-07-06 00:31] wakes up
[1518-04-26 00:24] wakes up
[1518-04-02 00:11] falls asleep
[1518-07-04 00:13] wakes up
[1518-06-27 00:12] falls asleep
[1518-02-20 00:48] wakes up
[1518-03-23 00:59] wakes up
[1518-07-18 00:31] wakes up
[1518-03-14 00:21] wakes up
[1518-10-01 00:55] wakes up
[1518-07-09 23:57] Guard #557 begins shift
[1518-08-07 00:56] wakes up
[1518-04-22 00:45] falls asleep
[1518-10-25 00:05] wakes up
[1518-03-16 00:53] wakes up
[1518-02-06 00:59] wakes up
[1518-06-14 00:05] falls asleep
[1518-04-18 00:00] Guard #1933 begins shift
[1518-09-03 00:53] wakes up
[1518-09-02 00:22] falls asleep
[1518-07-10 00:17] wakes up
[1518-08-28 00:32] wakes up
[1518-06-30 00:36] falls asleep
[1518-01-30 00:22] falls asleep
[1518-06-10 00:25] wakes up
[1518-05-19 00:42] wakes up
[1518-11-23 00:33] falls asleep
[1518-04-15 00:30] wakes up
[1518-11-22 00:59] wakes up
[1518-09-23 00:06] wakes up
[1518-04-03 00:56] wakes up
[1518-06-16 00:53] falls asleep
[1518-06-14 00:44] falls asleep
[1518-06-29 00:42] wakes up
[1518-04-07 00:50] wakes up
[1518-04-14 00:29] falls asleep
[1518-06-06 00:35] wakes up
[1518-02-20 00:58] wakes up
[1518-11-17 00:28] falls asleep
[1518-03-17 00:03] Guard #3187 begins shift
[1518-02-21 00:37] wakes up
[1518-05-04 00:16] wakes up
[1518-05-21 00:53] wakes up
[1518-07-27 00:04] Guard #2017 begins shift
[1518-06-14 23:59] Guard #1217 begins shift
[1518-03-11 00:17] wakes up
[1518-03-07 23:57] Guard #3187 begins shift
[1518-07-01 00:15] falls asleep
[1518-11-08 00:57] wakes up
[1518-09-29 00:54] wakes up
[1518-08-07 23:56] Guard #3301 begins shift
[1518-08-15 00:23] falls asleep
[1518-03-24 00:57] wakes up



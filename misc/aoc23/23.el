# AoC-23 - Day 23: A Long Walk
#
sysconf topleft
visual = 1
#
global m[] nc .
proc read .
   s$ = input
   nc = len s$
   repeat
      s$[] = strchars s$
      for c$ in s$[]
         if c$ = "#"
            m[] &= -1
         elif c$ = "."
            m[] &= 0
         elif c$ = ">"
            m[] &= 1
         elif c$ = "v"
            m[] &= 2
         elif c$ = "<"
            m[] &= 3
         else
            m[] &= 4
         .
      .
      s$ = input
      until s$ = ""
   .
.
read
#
#
start = 2
dest = len m[] - 1
#
gbackground 000
gtextsize 5
sc = 100 / nc
colind = 0
col[] = [ 966 855 744 633 522 633 744 855 ]
global vis[] max maxway[] .
#
proc showm m .
   if m = 1
      colind = colind mod len col[] + 1
   elif m = 0
      gclear
   .
   for r range0 nc
      for c range0 nc
         ind = r * nc + c + 1
         col = -1
         if m = 0 and m[ind] >= 0
            col = 888
         elif m = 1 and vis[ind] = 1
            col = col[colind]
         .
         if col >= 0
            gcolor col
            grect c * sc r * sc sc sc
         .
      .
   .
   gcolor 000
   grect 2 90 14 6
   gcolor 666
   gtext 3 91 max
.
d[] = [ 1 nc -1 (-nc) ]
#
global pseen[] w[][] nddest ndpos[] .
#
proc gond p d0 v &ndx .
   p = p + d[d0]
   repeat
      if v = 1 : vis[p] = 1
      for d = 1 to 4
         if d <> (d0 + 2) mod1 4 and m[p + d[d]] >= 0
            break 1
         .
      .
      p = p + d[d]
      d0 = d
      until pseen[p] <> 0
   .
   ndx = pseen[p]
.
proc gosteps nd ndn .
   p = ndpos[nd]
   vis[p] = 1
   d0 = 1
   repeat
      if m[p + d[d0]] >= 0
         gond p d0 0 ndx
      .
      until ndx = ndn
      d0 += 1
   .
   gond p d0 1 ndx
.
proc showmway .
   if visual = 0 : return
   showm 0
   ndp = maxway[1]
   for i = 2 to len maxway[]
      nd = maxway[i]
      vis[] = [ ]
      len vis[] len m[]
      gosteps ndp nd
      ndp = nd
      showm 1
      sleep 0.05
   .
   sleep 0.5
.
#
part = 1
maxavail = 0
func is_border h .
   if h <= 2 * nc or h mod nc = (nc - 1)
      return 1
   .
   if h > nc * nc - 2 * nc or h mod nc = 2
      return 1
   .
.
proc makegraph node p d0 .
   vis[] = [ ]
   len vis[] len m[]
   p = p + d[d0]
   repeat
      vis[p] = 1
      if m[p] > 0 and d0 <> m[p]
         if part = 1 : return
      .
      c = 0
      dx = (d0 + 2) mod1 4
      for d = 1 to 4
         if d <> dx and m[p + d[d]] >= 0
            d0 = d
            c += 1
         .
      .
      cnt += 1
      if c = 0
         pr "dead end"
         return
      .
      until c > 1
      pn = p + d[d0]
      if is_border pn = 1 and is_border p = 1 and (d0 = 3 or d0 = 4)
         deny = 1
      .
      p = pn
      if p = dest or p = start : break 1
   .
   nd = pseen[p]
   if nd = 0
      ndpos[] &= p
      w[][] &= [ ]
      nd = len w[][]
   .
   maxavail += cnt
   if deny = 1 : return
   w[node][] &= nd
   w[node][] &= cnt
   seen = pseen[p]
   pseen[p] = nd
   if p = dest
      maxavail += cnt + 1
      nddest = nd
   elif p <> start and seen = 0
      pseen[p] = nd
      for d = 1 to 4
         if m[p + d[d]] >= 0
            makegraph nd p d
         .
      .
   .
.
global seen[] nseen .
func entercon nd ndn .
   if seen[nd + nseen * ndn] = 0 and seen[ndn] = 0
      seen[ndn] = 1
      seen[nd + nseen * ndn] = 1
      seen[ndn + nseen * nd] = 1
      return 1
   .
.
proc leavecon nd ndn .
   seen[ndn] = 0
   seen[nd + nseen * ndn] = 0
   seen[ndn + nseen * nd] = 0
.
#
proc solve nd dist avail way[] .
   way[] &= nd
   if dist + avail <= max : return
   if nd = nddest
      if dist > max
         maxway[] = way[]
         max = dist
      .
      return
   .
   for i = 1 step 2 to len w[nd][] - 1
      if seen[w[nd][i]] = 0
         avail -= w[nd][i + 1]
      .
   .
   for i = 1 step 2 to len w[nd][] - 1
      ndn = w[nd][i]
      d = w[nd][i + 1]
      if entercon nd ndn = 1
         solve ndn dist + d avail way[]
         leavecon nd ndn
      .
   .
.
proc run .
   pseen[] = [ ]
   len pseen[] len m[]
   w[][] = [ [ ] ]
   ndpos[] = [ start ]
   maxavail = 0
   makegraph 1 start 2
   maxavail /= 2
   nseen = len w[][]
   seen[] = [ ]
   len seen[] nseen * nseen + nseen
   max = 0
   solve 1 1 maxavail [ ]
   print max
   showmway
.
#
proc main .
   #
   run
   part = 2
   run
.
main
#
input_data
#.#####################
#.......#########...###
#######.#########.#.###
###.....#.>.>.###.#.###
###v#####.#v#.###.#.###
###.>...#.#.#.....#...#
###v###.#.#.#########.#
###...#.#.#.......#...#
#####.#.#.#######.#.###
#.....#.#.#.......#...#
#.#####.#.#.#########v#
#.#...#...#...###...>.#
#.#.#v#######v###.###v#
#...#.>.#...>.>.#.###.#
#####v#.#.###v#.#.###.#
#.....#...#...#.#.#...#
#.#########.###.#.#.###
#...###...#...#...#.###
###.###.#.###v#####v###
#...#...#.#.>.>.#.>.###
#.###.###.#.###.#.#v###
#.....###...###...#...#
#####################.#

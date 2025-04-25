# AoC-24 - Day 20: Race Condition
#
global nc m$[] start ende .
proc init .
   s$ = input
   nc = len s$ + 2
   for i to nc : m$[] &= "*"
   while s$ <> ""
      m$[] &= "*"
      for c$ in strchars s$
         if c$ = "S"
            m$[] &= "."
            start = len m$[]
         elif c$ = "E"
            m$[] &= "."
            ende = len m$[]
         else
            m$[] &= c$
         .
      .
      m$[] &= "*"
      s$ = input
   .
   for i to nc : m$[] &= "*"
.
init
thre = 50
if nc > 20 : thre = 100
#
proc fill s0 &seen[] .
   todo[] = [ s0 ]
   while len todo[] > 0
      cnt += 1
      todon[] = [ ]
      for p in todo[]
         seen[p] = cnt
         for pn in [ (p + 1) (p + nc) (p - 1) (p - nc) ]
            if m$[pn] = "." and seen[pn] = 0
               todon[] &= pn
            .
         .
      .
      swap todo[] todon[]
   .
.
len cntback[] len m$[]
len cntfwd[] len m$[]
fill start cntfwd[]
fill ende cntback[]
fullcnt = cntfwd[ende] + 1
#
proc cheat p0 &ncheat1 &ncheat2 .
   len seen[] len m$[]
   len out[] len m$[]
   todo[] = [ p0 ]
   while len todo[] > 0 and cnt < 20
      cnt += 1
      todon[] = [ ]
      for p in todo[]
         for pn in [ (p + 1) (p + nc) (p - 1) (p - nc) ]
            if seen[pn] = 0 and m$[pn] <> "*"
               todon[] &= pn
               seen[pn] = 1
            .
            if m$[pn] = "." and out[pn] = 0
               out[pn] = 1
               if fullcnt - (cntfwd[p0] + cntback[pn] + cnt) >= thre
                  if cnt = 2 : ncheat1 += 1
                  ncheat2 += 1
               .
            .
         .
      .
      swap todo[] todon[]
   .
   return
.
proc run .
   for i to len m$[]
      if m$[i] = "." : cheat i sum1 sum2
   .
   print sum1
   print sum2
.
run
#
input_data
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############

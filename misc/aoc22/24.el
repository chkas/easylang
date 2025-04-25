# AoC-22 - Day 24: Blizzard Basin
#
global bl[] bld[] m[] nc .
proc read .
   repeat
      s$ = input
      until s$ = ""
      nc = len s$
      for c$ in strchars s$
         if c$ = "#"
            m[] &= -1
         else
            m[] &= 0
            if c$ <> "."
               if c$ = ">"
                  dir = 1
               elif c$ = "v"
                  dir = nc
               elif c$ = "<"
                  dir = -1
               else
                  dir = -nc
               .
               bld[] &= dir
               bl[] &= len m[]
            .
         .
      .
   .
.
read
npos = len m[]
nr = npos div nc
nc2 = nc - 2
nr2 = nr - 2
proc lcm a b &res .
   a0 = a
   b0 = b
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   res = (a0 div a) * (b0 div a)
.
lcm nc2 nr2 nstat
#
proc blizn .
   for i = 1 to len m[]
      if m[i] <> -1
         m[i] = 0
      .
   .
   for i = 1 to len bl[]
      dir = bld[i]
      bl = bl[i] + dir
      if m[bl] = -1
         if abs dir = 1
            bl -= dir * nc2
         else
            bl -= dir * nr2
         .
      .
      m[bl] += 1
      bl[i] = bl
   .
.
#
global todon[] seen[] .
proc run start dest &cnt .
   seen[] = [ ]
   len seen[] nstat * npos
   todo[] = [ stat * npos + start ]
   while len todo[] > 0
      todon[] = [ ]
      cnt += 1
      blizn
      stat = cnt mod nstat
      for pos in todo[]
         for p in [ pos + 1 pos + nc pos - 1 pos - nc pos ]
            if p = dest
               break 3
            .
            if p > 0 and p <= npos and m[p] = 0
               h = stat * npos + p
               if seen[h] = 0
                  seen[h] = 1
                  todon[] &= p
               .
            .
         .
      .
      swap todon[] todo[]
   .
.
run 2 npos - 1 cnt
print cnt
run npos - 1 2 cnt
run 2 npos - 1 cnt
print cnt
#
input_data
#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#




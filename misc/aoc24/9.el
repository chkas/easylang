# AoC-24 - Day 9: Disk Fragmenter
#
inp[] = number strchars input
#
proc part1 . .
   repeat
      for i to inp[id * 2 + 1] : dsk[] &= id
      until id = len inp[] div 2
      for i to inp[id * 2 + 2] : dsk[] &= -1
      id += 1
   .
   free = 1
   last = len dsk[]
   repeat
      while dsk[free] <> -1 : free += 1
      while dsk[last] = -1 : last -= 1
      until free >= last
      dsk[free] = dsk[last]
      dsk[last] = -1
   .
   for i to last : sum += (i - 1) * dsk[i]
   print sum
.
part1
#
proc part2 . .
   id = 1
   repeat
      size[] &= inp[id * 2 - 1]
      until id > len inp[] div 2
      free[] &= inp[id * 2]
      next[] &= id + 1
      prev[] &= id - 1
      id += 1
   .
   next[] &= 0
   prev[] &= id - 1
   free[] &= 0
   #
   for todo = len size[] downto 2
      ind = 1
      size = size[todo]
      while ind <> todo
         if free[ind] >= size
            indpr = ind
            ind = next[ind]
            free[prev[todo]] += free[todo] + size
            if ind <> todo
               next[indpr] = todo
               prev[ind] = todo
               next[prev[todo]] = next[todo]
               if next[todo] <> 0
                  prev[next[todo]] = prev[todo]
               .
               next[todo] = ind
               prev[todo] = indpr
            .
            free[todo] = free[indpr] - size
            free[indpr] = 0
            break 1
         .
         ind = next[ind]
      .
   .
   ind = 1
   size = size[todo]
   while ind <> 0
      for j to size[ind]
         sum += pos * (ind - 1)
         pos += 1
      .
      pos += free[ind]
      ind = next[ind]
   .
   print sum
.
part2
#
input_data
2333133121414131402

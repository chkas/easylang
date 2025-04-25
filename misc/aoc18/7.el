# AoC-18 - Day 7: The Sum of Its Parts
#
len dep[][] 26
len todo0[] 26
repeat
   s$ = input
   until s$ = ""
   a = (strcode substr s$ 6 1) - 64
   b = (strcode substr s$ 37 1) - 64
   dep[a][] &= b
   todo0[a] = 1
   todo0[b] = 1
   ninp += 1
.
#
proc work nwrk timeadd &ord$ &time ..
   time = 0
   todo[] = todo0[]
   len do[] 26
   len can_do[] 26
   repeat
      for i to 26 : if todo[i] = 1 and do[i] = 0
         can_do[i] = timeadd + i
         for j to 26 : if todo[j] = 1
            for k to len dep[j][]
               if i = dep[j][k]
                  can_do[i] = 0
                  break 2
               .
            .
         .
      .
      for i to 26 : if can_do[i] > 0
         do[i] = can_do[i]
         ord$ &= strchar (i + 64)
         can_do[i] = 0
         nwrk -= 1
         if nwrk = 0
            break 1
         .
      .
      min = 9999
      for i to 26
         if do[i] > 0 and do[i] < min
            min = do[i]
         .
      .
      until min = 9999
      for i to 26 : if do[i] > 0
         do[i] -= min
         if do[i] = 0
            todo[i] = 0
            nwrk += 1
         .
      .
      time += min
   .
.
work 1 0 ord$ h
print ord$
if ninp < 20
   work 2 0 h$ time
else
   work 5 60 h$ time
.
print time
#
input_data
Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.


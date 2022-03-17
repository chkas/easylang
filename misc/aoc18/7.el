# AoC-18 - Day 7: The Sum of Its Parts
# 
len dep[][] 26
len todo0[] 26
repeat
  s$ = input
  until s$ = ""
  a = (strcode substr s$ 5 1) - 65
  b = (strcode substr s$ 36 1) - 65
  dep[a][] &= b
  todo0[a] = 1
  todo0[b] = 1
.
# 
func work nwrk . ord$ time .
  todo[] = todo0[]
  len do[] 26
  len can_do[] 26
  repeat
    for i range 26
      if todo[i] = 1 and do[i] = 0
        can_do[i] = 61 + i
        for j range 26
          if todo[j] = 1
            for k range len dep[j][]
              if i = dep[j][k]
                can_do[i] = 0
                break 2
              .
            .
          .
        .
      .
    .
    for i range 26
      if can_do[i] > 0
        do[i] = can_do[i]
        ord$ &= strchar (i + 65)
        can_do[i] = 0
        nwrk -= 1
        if nwrk = 0
          break 1
        .
      .
    .
    min = 9999
    for i range 26
      if do[i] > 0 and do[i] < min
        min = do[i]
      .
    .
    until min = 9999
    for i range 26
      if do[i] > 0
        do[i] -= min
        if do[i] = 0
          todo[i] = 0
          nwrk += 1
        .
      .
    .
    time += min
  .
.
call work 1 ord$ _
print ord$
call work 5 _$ time
print time
# 
input_data
Step G must be finished before step M can begin.
Step T must be finished before step E can begin.
Step P must be finished before step M can begin.
Step V must be finished before step L can begin.
Step Y must be finished before step B can begin.
Step K must be finished before step Z can begin.
Step H must be finished before step I can begin.
Step D must be finished before step U can begin.
Step C must be finished before step L can begin.
Step R must be finished before step Z can begin.
Step U must be finished before step B can begin.
Step J must be finished before step M can begin.
Step M must be finished before step E can begin.
Step I must be finished before step X can begin.
Step N must be finished before step O can begin.
Step S must be finished before step F can begin.
Step X must be finished before step A can begin.
Step F must be finished before step Q can begin.
Step B must be finished before step Z can begin.
Step Q must be finished before step W can begin.
Step L must be finished before step W can begin.
Step O must be finished before step Z can begin.
Step A must be finished before step Z can begin.
Step E must be finished before step W can begin.
Step W must be finished before step Z can begin.
Step G must be finished before step R can begin.
Step H must be finished before step A can begin.
Step A must be finished before step W can begin.
Step Y must be finished before step D can begin.
Step O must be finished before step A can begin.
Step V must be finished before step U can begin.
Step H must be finished before step W can begin.
Step K must be finished before step F can begin.
Step J must be finished before step X can begin.
Step V must be finished before step R can begin.
Step Q must be finished before step A can begin.
Step F must be finished before step B can begin.
Step G must be finished before step P can begin.
Step L must be finished before step A can begin.
Step B must be finished before step Q can begin.
Step H must be finished before step J can begin.
Step J must be finished before step L can begin.
Step F must be finished before step E can begin.
Step U must be finished before step A can begin.
Step G must be finished before step Q can begin.
Step G must be finished before step S can begin.
Step K must be finished before step J can begin.
Step N must be finished before step B can begin.
Step F must be finished before step O can begin.
Step C must be finished before step Z can begin.
Step B must be finished before step E can begin.
Step M must be finished before step S can begin.
Step A must be finished before step E can begin.
Step E must be finished before step Z can begin.
Step K must be finished before step I can begin.
Step P must be finished before step A can begin.
Step Y must be finished before step L can begin.
Step Y must be finished before step J can begin.
Step G must be finished before step N can begin.
Step Q must be finished before step L can begin.
Step D must be finished before step X can begin.
Step C must be finished before step I can begin.
Step K must be finished before step B can begin.
Step N must be finished before step F can begin.
Step D must be finished before step M can begin.
Step B must be finished before step A can begin.
Step U must be finished before step J can begin.
Step Q must be finished before step Z can begin.
Step X must be finished before step F can begin.
Step K must be finished before step X can begin.
Step U must be finished before step E can begin.
Step X must be finished before step W can begin.
Step K must be finished before step Q can begin.
Step I must be finished before step E can begin.
Step D must be finished before step J can begin.
Step P must be finished before step I can begin.
Step K must be finished before step D can begin.
Step S must be finished before step X can begin.
Step C must be finished before step R can begin.
Step P must be finished before step W can begin.
Step I must be finished before step O can begin.
Step S must be finished before step O can begin.
Step K must be finished before step C can begin.
Step N must be finished before step Q can begin.
Step L must be finished before step E can begin.
Step L must be finished before step Z can begin.
Step K must be finished before step W can begin.
Step Y must be finished before step A can begin.
Step L must be finished before step O can begin.
Step N must be finished before step W can begin.
Step R must be finished before step W can begin.
Step C must be finished before step O can begin.
Step H must be finished before step X can begin.
Step V must be finished before step Y can begin.
Step S must be finished before step W can begin.
Step V must be finished before step E can begin.
Step Q must be finished before step E can begin.
Step P must be finished before step H can begin.
Step V must be finished before step H can begin.
Step N must be finished before step Z can begin.
Step C must be finished before step A can begin.



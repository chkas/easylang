# Peg solitaire solver
# ported from https://golang.org/doc/play/solitaire.go
# 
global nc brd$[] center moves .
# 
proc init . .
  repeat
    s$ = input
    until s$ = ""
    nc = len s$ + 1
    for c$ in strchars s$
      brd$[] &= c$
      if c$ = "○"
        center = len brd$[]
      .
    .
    brd$[] &= "\n"
  .
.
init
# 
proc movex pos dir . res .
  moves += 1
  res = 0
  if brd$[pos] = "●" and brd$[pos + dir] = "●" and brd$[pos + 2 * dir] = "○"
    brd$[pos] = "○"
    brd$[pos + dir] = "○"
    brd$[pos + 2 * dir] = "●"
    res = 1
  .
.
proc unmove pos dir . .
  brd$[pos] = "●"
  brd$[pos + dir] = "●"
  brd$[pos + 2 * dir] = "○"
.
proc solve . res .
  for pos = 1 to len brd$[]
    if brd$[pos] = "●"
      for dir in [ -1 (-nc) 1 nc ]
        movex pos dir moved
        if moved = 1
          solve solved
          unmove pos dir
          if solved = 1
            break 2
          .
        .
      .
      last = pos
      n += 1
    .
  .
  res = 0
  if solved = 1 or n = 1 and last = center
    print strjoin brd$[]
    res = 1
  .
.
solve res
print moves & " moves tried"
# 
input_data
.........
...●●●...
...●●●...
.●●●●●●●.
.●●●○●●●.
.●●●●●●●.
...●●●...
...●●●...
.........




# Peg solitaire solver
# ported from https://golang.org/doc/play/solitaire.go
# 
# 
global nc brd$[] center moves .
# 
func init . .
  repeat
    s$ = input
    until s$ = ""
    nc = len s$ + 1
    for c$ in strchars s$
      if c$ = "○"
        center = len brd$[]
      .
      brd$[] &= c$
    .
    brd$[] &= "\n"
  .
.
call init
# 
func movex pos dir . res .
  moves += 1
  res = 0
  if brd$[pos] = "●" and brd$[pos + dir] = "●" and brd$[pos + 2 * dir] = "○"
    brd$[pos] = "○"
    brd$[pos + dir] = "○"
    brd$[pos + 2 * dir] = "●"
    res = 1
  .
.
func unmove pos dir . .
  brd$[pos] = "●"
  brd$[pos + dir] = "●"
  brd$[pos + 2 * dir] = "○"
.
func solve . res .
  for pos range len brd$[]
    if brd$[pos] = "●"
      for dir in [ -1 (-nc) 1 nc ]
        call movex pos dir moved
        if moved = 1
          call solve solved
          call unmove pos dir
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
call solve res
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




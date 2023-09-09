len cyl[] 6
proc rshift . .
  h = cyl[6]
  for i = 6 downto 2
    cyl[i] = cyl[i - 1]
  .
  cyl[1] = h
.
proc unload . .
  for i = 1 to 6
    cyl[i] = 0
  .
.
proc load . .
  while cyl[1] = 1
    rshift
  .
  cyl[1] = 1
  rshift
.
proc spin . .
  lim = random 6
  for i = 1 to lim - 1
    rshift
  .
.
proc fire . shot .
  shot = cyl[1]
  rshift
.
proc method m[] . shot .
  unload
  shot = 0
  for m in m[]
    if m = 1
      load
    elif m = 2
      spin
    elif m = 3
      fire shot
      if shot = 1
        break 1
      .
    .
  .
.
method$[] = [ "load" "spin" "fire" ]
proc test m[] . .
  n = 100000
  for i = 1 to n
    method m[] shot
    sum += shot
  .
  for i = 1 to len m[]
    write method$[m[i]] & " "
  .
  print "-> " & 100 * sum / n & "% death"
.
test [ 1 2 1 2 3 2 3 ]
test [ 1 2 1 2 3 3 ]
test [ 1 1 2 3 2 3 ]
test [ 1 1 2 3 3 ]


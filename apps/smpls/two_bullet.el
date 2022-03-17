len cyl[] 6
func rshift . .
  h = cyl[5]
  for i = 5 downto 1
    cyl[i] = cyl[i - 1]
  .
  cyl[0] = h
.
func unload . .
  for i range 6
    cyl[i] = 0
  .
.
func load . .
  while cyl[0] = 1
    call rshift
  .
  cyl[0] = 1
  call rshift
.
func spin . .
  lim = random 6 + 1
  for i = 1 to lim - 1
    call rshift
  .
.
func fire . shot .
  shot = cyl[0]
  call rshift
.
func method m[] . shot .
  call unload
  shot = 0
  for m in m[]
    if m = 0
      call load
    elif m = 1
      call spin
    elif m = 2
      call fire shot
      if shot = 1
        break 1
      .
    .
  .
.
method$[] = [ "load" "spin" "fire" ]
func test m[] . .
  n = 100000
  for i range n
    call method m[] shot
    sum += shot
  .
  for i range len m[]
    write method$[m[i]] & " "
  .
  print "-> " & 100 * sum / n & "% death"
.
call test [ 0 1 0 1 2 1 2 ]
call test [ 0 1 0 1 2 2 ]
call test [ 0 0 1 2 1 2 ]
call test [ 0 0 1 2 2 ]


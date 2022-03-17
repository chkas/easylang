# AoC-20 - Day 24: Lobby Layout
# 
visual = 1
# 
global go[][] nc .
func read . .
  repeat
    s$ = input
    until s$ = ""
    go[][] &= [ ]
    s$[] = strchars s$
    i = 0
    while i < len s$[]
      c$ = s$[i]
      i += 1
      if c$ = "w"
        go[l][] &= 0
      elif c$ = "e"
        go[l][] &= 3
      else
        c$ &= s$[i]
        i += 1
        if c$ = "nw"
          go[l][] &= 1
        elif c$ = "ne"
          go[l][] &= 2
        elif c$ = "se"
          go[l][] &= 4
        elif c$ = "sw"
          go[l][] &= 5
        .
      .
    .
    l += 1
  .
  nc = 150
.
call read
len m[] nc * nc
dirs_even[] = [ -1 (-nc - 1) (-nc) 1 nc (nc - 1) ]
dirs_odd[] = [ -1 (-nc) (-nc + 1) 1 (nc + 1) nc ]
# 
func sum_black . s .
  s = 0
  for i range len m[]
    s += m[i]
  .
.
background 000
func show . .
  if visual = 0
    break 1
  .
  # 
  srow = 30
  offs = (nc - srow) div 2
  clear
  f = 100 / srow
  f2 = f / 2
  f4 = f / 4
  fd = f / 16
  fd2 = fd / 2
  f34 = f2 + f4
  linewidth f / 30
  for r range srow + 1
    for c range srow + 1
      x = c * f + fd2
      y = r * f34 - f4 + fd2
      if r mod 2 = 1
        x -= f2
      .
      x2 = x + f2
      xn = x + f - fd2
      # 
      y1 = y + f4 + fd2
      y2 = y + f34 - fd2
      yn = y + f - fd2
      ind = (r + offs) * nc + c + offs
      if m[ind] = 1
        color 222
      else
        color 765
      .
      polygon [ x y1 x2 y xn y1 xn y2 x2 yn x y2 x y1 ]
    .
  .
  color 111
  move 0 (srow + 1) * f34 - f4
  rect 100 100 - srow * f34
  move 5 85
  color 888
  call sum_black sum
  text sum & " black tiles"
  sleep 0.03
.
func show2 . .
  if visual = 0
    break 1
  .
  f = 100 / nc
  f2 = f / 2
  f34 = f2 + f / 4
  f4 = f / 4
  color 765
  move 0 0
  rect 100 nc * f34
  for r range nc
    for c range nc
      ind = r * nc + c
      if m[ind] = 1
        x = c * f
        y = r * f34 - f4
        if r mod 2 = 1
          x -= f2
        .
        move x y
        color 222
        rect f f
      .
    .
  .
  color 111
  move 0 nc * f34 - f4
  rect 100 100 - nc * f34
  move 5 85
  color 888
  call sum_black sum
  text sum & " black tiles"
  sleep 0.1
.
func part1 . .
  start = nc * (nc div 2) + nc div 2
  for l range len go[][]
    pos = start
    for i range len go[l][]
      r = pos div nc
      if r mod 2 = 0
        pos += dirs_even[go[l][i]]
      else
        pos += dirs_odd[go[l][i]]
      .
    .
    m[pos] = 1 - m[pos]
    call show
  .
  call sum_black sum
  print sum
.
call part1
# 
# 
len p[] len m[]
func update . .
  swap m[] p[]
  for r = 1 to nc - 2
    for c = 1 to nc - 2
      pos = r * nc + c
      s = 0
      if r mod 2 = 0
        for j range 6
          d = dirs_even[j]
          s += p[pos + d]
        .
      else
        for j range 6
          d = dirs_odd[j]
          s += p[pos + d]
        .
      .
      if p[pos] = 0 and s = 2
        m[pos] = 1
      elif p[pos] = 1 and (s = 0 or s > 2)
        m[pos] = 0
      else
        m[pos] = p[pos]
      .
    .
  .
.
func part2 . .
  for i range 100
    call update
    if i < 10
      call show
      sleep 0.3
    else
      if i mod 5 = 4
        call show2
      .
    .
  .
  call sum_black sum
  print sum
.
if visual = 1
  sleep 1
.
call part2
# 
# 
# 
input_data
nweneneeneneneneneesweenene
seswswswswnwswnenwswweseswseswswseswsenw
enweneswneneesenenenenenenene
nwseenwsewneseseseswneeenwewseenwnw
wwweseswnwwwswwwwnweswwew
weeneseeneeswswneswseeeeeee
nwseswnwswwnwnwwweneseswenenenwwe
nwnwwswesenwewwnenwsenenwnwnwswnwnwese
sweswseswsenwseswswswswsw
senesenenesewnwswesewneswseesesee
seenewwewwwwswswwwnewsewnwww
wswneswswsewwseswswnwswswnese
seseeeswewseswsweeseenwnenwwnwnwnw
nwnwnenwnenwsewswnwnwsewnwnwnwwwwwnw
wneweswwsenwwwswnwwew
swwswwewsewwwwwwwwwnw
swswewnwseseswnenenewswwswsweswsesese
seswseewnenwnweswnesweenwswnenenenee
nwswnenwneswenwnwnewneneswnwsesenwnee
nwsenenewwsenwsewwewnwwswwseeswsw
swseseeneewseeeeesesenesenwewseee
eneeeeneneewswwnenenenenenenenene
wwneweneesenwneeesweeneweesee
nwneneneneenenwnenwneswneswnwnewwneene
wseneeneewwwsesewenesenewwnenese
weeseneneenesesenenenenwnwswnewnew
swsweswenenwswnenwneneneseseswnwswseswe
swsewwwswsenwnwswww
nwnwnwswnwnwenwnwnwnenwnwsenwnwwwnwnw
senwneseseseeneeseeseeeseseswswenwse
nwsweseneneswwesenesweswneswwwswswwsw
nwnwnwnwnwnwnwnwenwwewnwswnwnwsenwnwnw
seseseeneswswwseswnwnwswseeseswneewww
eswnwseswswsweswesesewseswnesewswswsw
wnwswseneneneseseswwswswsw
eeneneseeweseeweeeneswnenwnenwsesw
seseswsewneseswenewsesesesenwseeewe
nwswnwwwnwewewwnwsw
eenwweeeeeeseenwseseneswsesee
eseeswnenwneneenenesenenwnwnenenenesw
senwsweenweeneneenwseneeesweene
swswswwweswsweswswswswseenenwswwsww
esenwneseseneneswnwnenwneeswesenwwne
eseseeesweeseseewseesewsenwsese
sewewnwnwwswewnwnwnwnwwnwnwnwww
seseewseeeneeeewseese
esenwneswnwewnwneneswneeneneesenene
eswswseenweeswnenesewenwnenwsweswee
ewenweeeneseeewseeseseeneswsew
eswseseseswswsesew
wesenweswwnesewseseeneswswswsenwse
sesewewseseesewnweenesenwseesw
swwneswswseneseseseewseswsesesesenwsenwsw
nwswnwswseswnwwseswswswseswnwseeenese
neeswwswwnwsenwsewseneswseweseneene
swwswsesesesenenwsenenwsweseseswsw
seeesewesesenwneeseese
seseenwseseswsesewseneese
senwseneswsewsesweseseseseseseswseswne
nwsenewnwneneseswneseenwneswneenwwnw
wswwwenwwwwsewnwnwesenwnwnwnenww
nwseswswswswswswswswswwswswsw
newwswwswnesewwwswswwswsweswwswsw
swewwnwnwewseswwswswsewsww
nwseeeseeeseeeesesenwnwsweeeee
senenwseesewswseneweeenwseswseseese
neneneswnenwnenenenwnesenwnesenenesenewe
wnesenwsenwseseswneseeswsesenenw
eswseseseswnenwnwswswseswseswseseseswse
seenwswnenwswnwnwnwswnwnwnwnenwnwnwnwnw
nenwsewewswneswenenwneneeswnwneesesw
nenenewnenwnweneneeswwnenwneneseesene
wwwwswwswnewseeneneswswwswsw
wneneeeneeesweneneenesenewneeee
eneeeeneeeeeeweseenenwseew
eewwsweneenwwseweeee
nwwwsewwnewwse
ewenwesweeseseeeeseseswnenwsesee
esewseswsesesenwnweseseesesenweenwe
swswwnenesewsewseneswneseswswneneseese
nenenwnenenwneswneswsenwenwnenenw
swneseseeswseswsewswsesewnwseswswnwsee
wswswswswnwewwswwswswwwsweewew
esweneesenenweeneweeeseeeneswne
nwenwseneswnwnwnwwswnwenwnwwwnwnwne
seswsweseswswswseswswswswneswnenwswswswsw
swnwswswnwseswnwwsese
wswneswswneswsewwswwesww
neweenewswswnesesenenesenenwe
swnwseswwseseneseseswsesewwnweesese
wenweweeneneeeneseeswenee
seneesweenweeeswesee
wswswswsesewneeseneswswswswwesesesw
neneneseswnenenenenenenenenenesenenenewnew
neneseenenewenenenenwnenenweneseenesw
seneewwwwswnwsewwwwwwwwswwsw
seeseeseswnwewewnwseesesesesesenese
wwnwwenwnwnwnwwnwswewnenwwenww
senweeeeeeeeeswnwenweswwee
eswwwewseseeswneseneseenwwenesese
swsenweseseswseswseswnesesenweseswwwswsw
nwnwneswsweneneneewneswewnenwneseeswnw
senwswsewseseneenewseswseseseesesee
nwwnwnweswswsesenwwnenwwswwneseweene
wsesweswswswswwswnwswnwnwneseswesww
nwnwnwnwnwwnwwnwsenw
swwwnwnwewwwnwswwsesweewwwwe
nwnwswswswnwnwseswenwnewwnwenwnwnwe
neeenwneneneeneweneneswswnenene
swswswswswseswsenwswswswseseswewneswswe
seseseswewseseswswnesenesesewnwsesesenw
sewseeseseseseseseenesewseseswsewsese
swswswnewswswswswwswswsweewswwnwesw
nwwnenwnwnwnwsenwnenwnwnesenenenwnwnww
nesweswwswwswswwswswswsw
nesenesesweeneewswseneeswnwnenwswenw
eseeseeeenweeseseneeeswse
wenwswwwnwnwnwenwwwwwwneswnwnw
ewseeeneeseseeneswwse
swswseseswswswneswseenwwswnewseswswenwe
nenewswesenwwseseswswseseenwsewswneswse
swswesesesesesenwsenesenwneseswsewseswsese
nenwnesewnwnwnwnwenwnwnwsenwnwnenenwnw
wwwswwwwnewwsenewsewwnwwswenw
newesewsewseeseneswseseswnwnewsesese
sweweseneseneswswnwnenwenwnwneswne
ewnwneeeneenwseswswnwnwnenwwwnesene
swnwswnewnweenwnwnenwnwnenenwsenwnenenwnw
nwnwnwnwwnewnwwnwnwwsenwnwneseswwnw
wsewwwnwwwwwwwwnwwsenewseww
nwwnewsenwnenwnwnenwsenwsenwwnenenenwse
nwswseswnwswsweswsewseswswseseswneswsesw
seewewsesesesesene
nwwswswswswswswwswenwswswewswswswsw
sesewwwwwnewwnewnewneswesewwswne
esewseweseneseseseswsenwsesesenesese
swwsewwsenwwnesenewneewnwwwww
nwnwnwnwneseswneneswsenesenwnwnw
swneenenwnwswenwnenwwsewnwnwswenenw
nwsewseswswenewseneseseeseeswwseneew
swswnenwswewswnwswneneswswweswswesw
swnewesewwwwwwsewneseewnwww
swswswswwswseneneewweswneswsewswne
sesenwsesesesenewswnweseseseeswsesesw
swswnwswswnweswnwswsweswswwseseswwnww
wswswneswseneenewnesenesewnenwnweew
nwesesweeeseeeseewwenweseee
nwsesenesewseswseswseneswwswswwesene
sesenwswsesesesewsesenwnesesenwseseswse
ewnwwswnenwnesenenwnenwneseeswneneswnene
eneswnewnenwneneswseneseswnenwene
wwewwwnwwwwnwwwnwswwwewsw
wnenwenwnwneneneswenenwneneswnwsenene
sewsenwnwnwwwewnwsewwwnenenwwwnw
nwnwnwnwnwnwwswnenewnwnwewwnwnwwse
wnwwewwnwnwnwnwnwwnwnwww
neseseseesesesesesesenwswwnesesesese
wnwnewnwwsewnewse
enwnenwneswnwnwnwnwnwswnenwnwnwnwnwsee
eeeeeeenwweeeesw
nwsesesenwwseseseswsesenenesesesesesese
wnwnwneneenesenwseswwseswnwwwwee
nwswneneneneenwneneenwwnenenenesenwnene
wnwwwwwnewsewwwwwwwnw
swnwnwsewnewwnwnenewwwwseswnenesw
swseswswswswswswswnwnewneswwswswwswswse
swwswswnwwwewwwswwneswwwnesw
nwnwnwwnenwnwnwnwnwnwnenesenw
wseswswnwwwwwesenwnwesesesenwnwnw
eenewenenesenenwe
wwwewnwwsewwwwwnwwwwwsew
sweswsweewseseswswswswnwswswseswwnwse
wswseswneeseswswswnewseswswswseenwswsw
newwsenewnwwwwwwnwwsenwseewww
nwnwnwneswnwnwwnwnwnwenwnwnwnwswenwsw
sweseswnwnwenwseswnwnweneneneswnwswnesew
nwenwwnwsenwnwnwenwnwnewswwnenwnwnwenw
newsweeswswnwnenweseweeneswneswnesw
neeneseeenwseesenewwsweswnwenene
nwnwswswwnwsewswwswseswsewswnwewwse
nwnwwnwnwnwsenwsenwnwnenwewnwnwwnwsw
nenwsweeewnwnwnenenenwnwnenenenewnenw
sewswwswsewnewnewswwnenewwwwse
nwsesesenwewseseseseseseseswnesw
ewwwwwwwwsewwwswswswnenwswwswne
nenwsenwnwsewnwnwwnwnwnwsesenwnwnwnwnwnw
nwesewseseseeseseseseeseeseene
seewswwwnwsewnenwnwnwnwsweneswnesene
swswewswswwwneswswwswswnwwnewseswswsw
enwnwswnwwwsenwwnwnwenwwwwnwww
eneneswnenenenwnwnwne
nenenenenenenenenenenesewnewnenenesenw
swsweseswswsenenwswswswswswnwseswswswswnw
senewwswnwswesewnenwnwsenweseswsee
senewnewnwseewwwwswseswnwewnesw
sesenwesewneeseseseseswsesewnwnwenw
eweeneeeseeseneswe
nenenenenenewneneneseneneneneee
wswwwewwneswwwwwww
wewnwwnenwswnwneneswwnwsenwnenwswenwse
ewseseeeseseweseneseeseesesewee
swswswnesweswsenwsesewseseswseswesesesw
seseeeeswneweenwseseesewnewee
nwseeneesweneeneswswwnwesweeeeenw
seneseswseseesenwswsesesenweneseewswne
swsweneswswswnwseswswnwswswswswswswsene
neswswwnwseeseswnwwswnewsenenenwswnese
nwneneswswwseneswsewnewwewwseenewnw
eswswswseseseseseswnwseseswsesesenwese
nwsewwsewnwwnwneeeweeswwwwswsene
nwnwnwnwnwenwwwnwnw
swswswswsweswswswweswnwsenwwswswswswsw
nenesenwnwnenenwnenene
nwnewswnwswnwnenwswneseneewswseeneswnee
enenwnwnweneswnenwnwneneswwnwnenewsw
seseseesesewsewseseseneseswnesenesese
nwwsenewnwnwwsewwnwwsenwsenenwnwnww
sewseseseseseseseseseenweseeswsenwse
wewsewwwswwewnwwswnwwneswsww
swwswswwswswwswwwneeswsw
nwenwswneesenenenwnwnwswwnwenesw
neeeswnwsesewenwsesweswwene
nenwswswnwneneneenwwnwenenwnewnwneeene
nwswswnenenwswwsesesw
nenwnesenwwnwnwnwnenenenenesesenwnwnwne
seseesewseeeeeesewesenenewsesesenw
swsesesewwsenweeswswnenweswesenwnwsw
nwseseeseseswsenwseseseswswseseswwsesw
nenwswwswswswwswswswswewswwnewsww
swswswswwswewseswneswswswneseswswseswsw
swnwnwnwnwnwnwnwnwnwnwnwnwswnwenwenwnw
nesweseswesenwwsweswswnwsewswwswsw
senenwwwwswwswnwwenesw
nwesewnwnwnwnwwnweseenwnwwnwnwsww
swesenewnwneswseeswsewnwneswneswwsw
sesesesenwsewsesesesesesewsenesesenese
seeseewswswwswneenwsww
wnenwnewenwnwneeneneseswseeneenwesesw
nwenwnwswnwnwwwnwwwwnw
neswwwwswwsenwswseweswwwnweww
sesweeeeeswnwenwee
neseseswneseswseeswsewseseswsenwseseswswse
swnwnwnwnwnwwnwwnwnenwwnwwnw
eseeeseeeneeeneseeeweeewe
eeeswneeweswneeenwewsweswene
sewwwnwnwwenwsenwwwnenwnwwwnwww
seneseneswseswswswnwswseseswswwswswswsw
swnwwwwwwwnwwswseseswwneswswsww
nwnewnenenenwnwsenweenwwnewneeswne
wwewnewwsenwnenewsewwwsewswnwsew
nwnwnenwswnwnwneswwnwswnwwnenwswnwnwee
eeeesweeeewswneeeneeeeee
eeseeseweeeseeseeenesese
nwswnwswneneneneneneswnenenenewnwese
seseseeswseswsesesenesenwsewswsesenwsesese
wsewseswseenesenwseseseneswsewesewe
enweeneseeneenewswseneenewene
nenwsesenwnwsewnwnwnwwwnwwwswnwnwwne
seseswseseseseseseneseneesewse
neeneeneneenenwswneneneswnesenenewnene
swnwenwnwnwneswnwswnenwnwnw
eeswnwneeneeenee
neseseenwsewsewswseneeswswseeenesesee
swwnwnwnwneswnwnenwnwsenwnenenwse
nwnwnwewswwsweseswswsenwwswsewenw
nwnwewswnwsenwsewswwswwwswe
wswwwwwwewwwwww
wnwswwswwwswnenwwewsewwwswsewsw
eneneeenenenenewseneneswneenenewnesene
wsenwnwwnwnwswenwnwnwswnwwnwnwnenwnwnese
senewnwswsenwseswsenwseseeenew
wnwnwnwwwnwwenwnwnwnwnw
sweewwwneswwwnweeswnwenwwwwenw
swnwnwnwnewwnwnwwnwnwnwsenwne
enwswnwnwsenenesenwswnweswnesesenwwnenww
nenwnwnwsewnwnwnenwnwnwnw
nenenenenwnenwwneswsesenenewnenenenenese
neneenenenwneseenwwnwnenenenenewnwnw
neneneeneweenenenenewseneswse
seseneswsesesesesesewseseseswesenenesese
seeseneseswsenwswseswneesesesewswnwnwwse
seeeeseeeeseeeseeswwnenewsee
senwnwnwnwwneswswnwwnweenwnwnwwnwnw
wswswnwswswwswsweeswsesweswswsenew
senwnwnenwwnwnwnwnwswnwenesenwnwnwne
senwnwnwnesenwnwneenwneweeswnwnwswnw
nwwnwwwsewsewwwswenwnwe
eswnenenenenwneneneneneeeenee
swneewseseenenenweeneeeeeenee
senwwneseesewwseswnwswnewnw
enwwwwwsenwwnwwwswwwwwewww
nwswswwsenwnwnwnwwwnwwnwneesewnwnwne
nwnesesewsewswnwsesewnwneeeswwswese
esesewnewwnesenwwnwseswne
wnwwwwnewnewnewnwnwsenwswwseww
sesewseseseswswswsesweswseesenww
eewenenweneseeeeswswenwwe
neswweneneweeneneenwneeswseeneese
neseseswseseseesenwnwsesesesewewsese
wnwnenwseewswnwwwnwnwe
seeswnwewwswewnwnwwnwenwswswnw
swseneswneseseseseseseswseswnwswsesewsw
neseeewesenwnwwneneseeweswseswnw
nenweenenweeseeeeeeswnweeeswsene
eseseseeenweesesesweeese
seneseswwwsenwnesewneseseseesew
esweeeeeeeneeeeenw
nenwwwwswnwnwnesenwwnwnwnwsenenw
nwenwnwnesenwnwnwneswwwnwsenwwwnwww
wewswseseswneseswneswseswnweseneww
ewnwnewwwsewnwwswswnwwwwnwwewnw
nwseswnwnwnwsesenwnwsesenwneneneneseewsw
wnwnwwnwnwnwnwwwnwwwwew
wnwwnwnwsenwnwnwwnwnwwne
nenwnwswnewneewswseneeenenwnenenwe
nenwnwnwneneneneswwnwswsenenwesenwnenw
nwnwnwewwnwwnewwnwswwwwwneswnwse
enwnwseseseswsweewnwnwsesesesenewsene
nenesenenwneenenenenewnewsewneenwswne
swweswwswswnwswswwwswswswsw
nwsesweswseseswseswnenwswsenwnesewnw
wwwswswswwswnewswswwsewswwnenww


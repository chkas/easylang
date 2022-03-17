# AoC-19 - Day 16: Flawed Frequency Transmission
# 
inp$ = input
# 
func part1 . .
  write "Part 1: "
  d[] = number strchars inp$
  n = len d[]
  pat[] = [ 0 1 0 -1 ]
  for i range n
    p[][] &= [ ]
    ip = 0
    first = 1
    while len p[i][] < n
      k = 0
      while k <= i and len p[i][] < n
        if first = 0
          p[i][] &= pat[ip]
        .
        first = 0
        k += 1
      .
      ip = (ip + 1) mod 4
    .
  .
  len dn[] n
  for _ range 100
    for i range n
      v = 0
      for j range n
        v += p[i][j] * d[j]
      .
      dn[i] = abs v mod 10
    .
    swap d[] dn[]
  .
  for i range 8
    write d[i]
  .
  print ""
.
call part1
# 
func part2 . .
  write "Part 2: "
  n_in = len inp$
  offs = number substr inp$ 0 7
  len d[] n_in * 10000 - offs
  j = offs mod n_in
  n = len d[]
  for i range n
    d[i] = number substr inp$ j 1
    j = (j + 1) mod n_in
  .
  #   
  len dn[] n
  for _ range 100
    s = 0
    for i = n - 1 downto 0
      s += d[i]
      dn[i] = s mod 10
    .
    swap d[] dn[]
  .
  for i range 8
    write d[i]
  .
  print ""
.
call part2
# 
input_data
59738476840592413842278931183278699191914982551989917217627400830430491752064195443028039738111788940383790187992349338669216882218362200304304999723624146472831445016914494176940890353790253254035638361091058562936884762179780957079673204210602643442603213181538626042470133454835824128662952579974587126896226949714610624975813583386749314141495655816215568136392852888525754247201021383516228214171660111826524421384758783400220017148022332694799323429711845103305784628923350853888186977670136593067604033507812932778183786479207072226236705355778245701287481396364826358903409595200711678577506495998876303181569252680220083046665757597971122614



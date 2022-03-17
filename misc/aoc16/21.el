# AoC-16 - Day 21: Scrambled Letters and Hash
#  
repeat
  ii$ = input
  until ii$ = ""
  inp$[] &= ii$
.
func tostr pw[] . pw$ .
  pw$ = ""
  for v in pw[]
    pw$ &= strchar v + 97
  .
.
func hash pw[] . hash$ .
  np = len pw[]
  len pwn[] np
  for inp$ in inp$[]
    s$[] = strsplit inp$ " "
    if s$[0] = "swap"
      if s$[1] = "position"
        a = number s$[2]
        b = number s$[5]
      else
        ai = strcode s$[2] - 97
        bi = strcode s$[5] - 97
        for i range np
          if pw[i] = ai
            a = i
          .
          if pw[i] = bi
            b = i
          .
        .
      .
      swap pw[a] pw[b]
    elif s$[0] = "reverse"
      a = number s$[2]
      b = number s$[4]
      for i range (b - a + 1) div 2
        swap pw[a + i] pw[b - i]
      .
    elif s$[0] = "rotate"
      if s$[1] = "right"
        h = number s$[2]
      elif s$[1] = "left"
        h = -number s$[2]
      elif s$[1] = "based"
        ai = strcode s$[6] - 97
        for h range np
          if pw[h] = ai
            break 1
          .
        .
        if h >= 4
          h += 1
        .
        h += 1
      .
      for i range np
        pwn[(i + h) mod np] = pw[i]
      .
      swap pw[] pwn[]
    elif s$[0] = "move"
      a = number s$[2]
      b = number s$[5]
      i = 0
      for in range np
        if in = b
          pwn[in] = pw[a]
        elif in = a
          if a < b
            i += 1
            pwn[in] = pw[i]
            i += 1
          else
            pwn[in] = pw[i]
            i += 2
          .
        else
          pwn[in] = pw[i]
          i += 1
        .
      .
      swap pw[] pwn[]
    .
  .
  call tostr pw[] hash$
.
call hash [ 0 1 2 3 4 5 6 7 ] h$
print h$
# 
perm[] = [ 0 1 2 3 4 5 6 7 ]
global permlist[][] .
func mk_permlist k . .
  for i = k to len perm[] - 1
    swap perm[i] perm[k]
    call mk_permlist k + 1
    swap perm[k] perm[i]
  .
  if k = len perm[] - 1
    permlist[][] &= perm[]
  .
.
call mk_permlist 0
# 
for i range len permlist[][]
  call hash permlist[i][] hash$
  if hash$ = "fbgdceah"
    call tostr permlist[i][] pw$
    print pw$
    break 1
  .
.
# 
input_data
swap position 2 with position 7
swap letter f with letter a
swap letter c with letter a
rotate based on position of letter g
rotate based on position of letter f
rotate based on position of letter b
swap position 3 with position 6
swap letter e with letter c
swap letter f with letter h
rotate based on position of letter e
swap letter c with letter b
rotate right 6 steps
reverse positions 4 through 7
rotate based on position of letter f
swap position 1 with position 5
rotate left 1 step
swap letter d with letter e
rotate right 7 steps
move position 0 to position 6
swap position 2 with position 6
swap position 2 with position 0
swap position 0 with position 1
rotate based on position of letter d
rotate right 2 steps
rotate left 4 steps
reverse positions 0 through 2
rotate right 2 steps
move position 6 to position 1
move position 1 to position 2
reverse positions 2 through 5
move position 2 to position 7
rotate left 3 steps
swap position 0 with position 1
rotate based on position of letter g
swap position 5 with position 0
rotate left 1 step
swap position 7 with position 1
swap letter g with letter h
rotate left 1 step
rotate based on position of letter g
reverse positions 1 through 7
reverse positions 1 through 4
reverse positions 4 through 5
rotate left 2 steps
swap letter f with letter d
swap position 6 with position 3
swap letter c with letter e
swap letter c with letter d
swap position 1 with position 6
rotate based on position of letter g
move position 4 to position 5
swap letter g with letter h
rotate based on position of letter h
swap letter h with letter f
swap position 3 with position 6
rotate based on position of letter c
rotate left 3 steps
rotate based on position of letter d
swap position 0 with position 7
swap letter e with letter d
move position 6 to position 7
rotate right 5 steps
move position 7 to position 0
rotate left 1 step
move position 6 to position 2
rotate based on position of letter d
rotate right 7 steps
swap position 3 with position 5
move position 1 to position 5
rotate right 0 steps
move position 4 to position 5
rotate based on position of letter b
reverse positions 2 through 4
rotate right 3 steps
swap letter b with letter g
rotate based on position of letter a
rotate right 0 steps
move position 0 to position 6
reverse positions 5 through 6
rotate left 2 steps
move position 3 to position 0
swap letter g with letter b
move position 6 to position 1
rotate based on position of letter f
move position 3 to position 2
reverse positions 2 through 7
swap position 0 with position 4
swap letter e with letter b
rotate left 4 steps
reverse positions 0 through 4
rotate based on position of letter a
rotate based on position of letter b
rotate left 6 steps
rotate based on position of letter d
rotate left 7 steps
swap letter c with letter d
rotate left 3 steps
move position 4 to position 6
move position 3 to position 2
reverse positions 0 through 6



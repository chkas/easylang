# AoC-21 - Day 21: Dirac Dice
# 
# In a 2 dimensional field with indices
# sum (up to 21) and position (1 - 10) the 
# possibilities to get there are summed up. 
# In each round there are 27 new additions 
# for all field elements.
# 
apos = (number substr input 28 9) - 1
bpos = (number substr input 28 9) - 1
# 
func part1 pos pos2 . .
  repeat
    for _ range 3
      pos = (pos + die + 1) mod 10
      die = (die + 1) mod 100
    .
    sum += pos + 1
    cnt += 3
    until sum >= 1000
    swap pos pos2
    swap sum sum2
  .
  print cnt * sum2
.
call part1 apos bpos
# 
func calc . start done[] ndone[] .
  len cnt[] 21 * 10
  cnt[start] = 1
  repeat
    cntn[] = [ ]
    len cntn[] len cnt[]
    done = 0
    ndone = 0
    for i range len cnt[]
      cnt = cnt[i]
      if cnt > 0
        pos = i mod 10
        sum = i div 10
        # 
        for d1 = 1 to 3
          for d2 = 1 to 3
            for d3 = 1 to 3
              posn = (pos + d1 + d2 + d3) mod 10
              sumn = sum + posn + 1
              if sumn >= 21
                done += cnt
              else
                ndone += cnt
                cntn[sumn * 10 + posn] += cnt
              .
            .
          .
        .
      .
    .
    done[] &= done
    ndone[] &= ndone
    until ndone = 0
    swap cnt[] cntn[]
  .
.
call calc apos adone[] anotdone[]
call calc bpos bdone[] bnotdone[]
# 
for i = 1 to len adone[] - 1
  awin += adone[i] * bnotdone[i - 1]
  bwin += bdone[i] * anotdone[i]
.
print higher awin bwin
# 
input_data
Player 1 starting position: 9
Player 2 starting position: 4



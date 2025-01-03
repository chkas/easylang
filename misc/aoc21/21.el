# AoC-21 - Day 21: Dirac Dice
#
# In a 2 dimensional field with indices
# sum (up to 21) and position (1 - 10) the
# possibilities to get there are summed up.
# In each round there are 27 new additions
# for all field elements.
#
apos = number substr input 28 10
bpos = number substr input 28 10
#
proc part1 pos pos2 . .
   repeat
      for i to 3
         pos = (pos + die) mod 10 + 1
         die = die mod 100 + 1
      .
      sum += pos
      cnt += 3
      until sum >= 1000
      swap pos pos2
      swap sum sum2
   .
   print cnt * sum2
.
part1 apos bpos
#
proc calc start . done[] ndone[] .
   len cnt[] 21 * 10
   cnt[start] = 1
   repeat
      cntn[] = [ ]
      len cntn[] len cnt[]
      done = 0
      ndone = 0
      for i to len cnt[]
         cnt = cnt[i]
         if cnt > 0
            pos = (i - 1) mod 10 + 1
            sum = (i - 1) div 10
            #
            for d1 to 3 : for d2 to 3 : for d3 to 3
               posn = (pos + d1 + d2 + d3 - 1) mod 10 + 1
               sumn = sum + posn
               if sumn >= 21
                  done += cnt
               else
                  ndone += cnt
                  cntn[sumn * 10 + posn] += cnt
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
proc part2 . .
   calc apos adone[] anotdone[]
   calc bpos bdone[] bnotdone[]
   #
   for i = 2 to len adone[]
      awin += adone[i] * bnotdone[i - 1]
      bwin += bdone[i] * anotdone[i]
   .
   print higher awin bwin
.
part2
#
input_data
Player 1 starting position: 4
Player 2 starting position: 8


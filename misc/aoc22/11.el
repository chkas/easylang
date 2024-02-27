# AoC-22 - Day 11: Monkey in the Middle
#
repeat
   s$ = input
   until s$ = ""
   a[] = number strsplit substr input 19 999 ","
   item0[][] &= a[]
   a$[] = strsplit substr input 24 9 " "
   h = 1
   if a$[1] = "*"
      h = 2
   .
   if a$[2] <> "old"
      n = number a$[2]
      h += 2
   .
   op[] &= h
   opn[] &= n
   divs[] &= number substr input 21 9
   true[] &= number substr input 29 9 + 1
   false[] &= number substr input 30 9 + 1
   s$ = input
.
#
prod = 1
n = len op[]
for i = 1 to n
   prod *= divs[i]
.
proc run maxcnt . .
   item[][] = item0[][]
   len cnt[] n
   for r = 1 to maxcnt
      for m = 1 to n
         for old in item[m][]
            cnt[m] += 1
            op = op[m]
            h = old
            if op >= 3
               h = opn[m]
               op -= 2
            .
            new = old + h
            if op = 2
               new = old * h
            .
            if maxcnt = 20
               new = new div 3
            else
               new = new mod prod
            .
            d = false[m]
            if new mod divs[m] = 0
               d = true[m]
            .
            item[d][] &= new
         .
         item[m][] = [ ]
      .
   .
   for i = 1 to 2
      for j = i + 1 to n
         if cnt[j] > cnt[i]
            swap cnt[j] cnt[i]
         .
      .
   .
   print cnt[1] * cnt[2]
.
run 20
run 10000
#
input_data
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1


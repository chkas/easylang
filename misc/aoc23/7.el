# AoC-23 - Day 7: Camel Cards
#
repeat
   s$ = input
   until s$ = ""
   cards$[] &= substr s$ 1 5
   bid[] &= number substr s$ 7 9
.
Grande = 6
Poker = 5
Full = 4
Three = 3
TwoPairs = 2
Pair = 1
Nothing = 0
#
func value hand$ part .
   len cnt[] 14
   for c$ in strchars hand$
      if c$ = "T"
         v = 10
      elif c$ = "J"
         v = 11
      elif c$ = "Q"
         v = 12
      elif c$ = "K"
         v = 13
      elif c$ = "A"
         v = 14
      else
         v = number c$
      .
      if part = 2 and v = 11
         v = 1
      .
      cnt[v] += 1
      cards[] &= v
   .
   for i = 2 to 14
      if cnt[i] = 5
         hand = Grande
      elif cnt[i] = 4
         hand = Poker
      elif cnt[i] = 3
         hand += Three
         # +3
      elif cnt[i] = 2
         hand += Pair
         # +1
      .
      # 1+1 = TowPairs, 3+1 -> Full
   .
   if part = 2
      joker = cnt[1]
      while joker > 0
         if hand = Poker
            hand = Grande
         elif hand = Full
            hand = Poker
         elif hand = Three
            hand = Poker
         elif hand = TwoPairs
            hand = Full
         elif hand = Pair
            hand = Three
         elif hand = Nothing
            hand = Pair
         .
         joker -= 1
      .
   .
   for card in cards[]
      cardval += cardval * 15 + card
   .
   return hand * 1000000 + cardval
.
#
proc run part . .
   b[] = bid[]
   for c$ in cards$[]
      v[] &= value c$ part
   .
   # sort
   for i = 1 to len v[] - 1
      for j = i + 1 to len v[]
         if v[j] < v[i]
            swap v[j] v[i]
            swap b[j] b[i]
         .
      .
   .
   for i to len b[]
      s += b[i] * i
   .
   print s
.
#
run 1
run 2
#
input_data
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483

txt_tutor=`+ Monte Carlo Methods - Why It Is a Bad Idea to Go to the Casino

-

+ A *Monte Carlo method* is a fairly simple way to get an answer to a task without having to analyze it mathematically. The solution is to simulate the task and see what happens. And this is best done with a computer program.

* Coin flipping

+ If we want to know how often heads come out of 1000 coin tosses, we do it or better let the computer do it.

+ The computer program needs a random function that simulates the random landing of the coin. 

+ *random 2* returns an integer value between 0 and 1 inclusive, that is 0 or 1. 0 stands for *heads* and 1 for *tails*.

flip = random 2
if flip = 0
  print "heads"
else
  print "tails"
.

+ We flip a coin 1000 times and count how often heads come

while i < 1000
  flip = random 2
  if flip = 0
    heads += 1
  .
  i += 1
.
print "We got " & heads & " heads"
print "That is " & 100.0 * heads / i & "%"

+ We get roughly about 500 times head, so that's about 50% of all flips.

-

+ If we increase the number of flips to a million, the percentage of heads comes very close to 50%.

while i < 1000000
  flip = random 2
  if flip = 0
    heads += 1
  .
  i += 1
.
print "We got " & heads & " heads"
print "That is " & 100.0 * heads / i & "%"

+ This is called the *Law of large numbers*

* Roulette

+ Now it's time to go to the casino - virtually with a software simulation.

+ We play roulette with a single zero wheel. Double zero wheels are twice as bad for the player. There are 37 numbers, from 0 to 36. We bet on the high numbers, i.e. we win the bet if the ball rolls to a number from 19 to 36, otherwise we lose our money.

+ So let's play, we'll bet $10:

numb = random 37
if numb >= 19
  print "You win $10"
else
  print "You lose $10"
.

+ Let's play a thousand times:

while i < 1000
  cash -= 10
  numb = random 37
  if numb >= 19
    cash += 20
  .
  i += 1
.
print "Cash after playing: $" & cash

+ Most of the time we lose. Why do we actually lose? The reason is the *0*. There are 18 numbers where we win and 19 where we lose.

-

+ Now lets play 10000 times

while i < 10000
  cash -= 10
  numb = random 37
  if numb >= 19
    cash += 20
  .
  i += 1
.
print "Cash after playing: $" & cash

+ Now we lose nearly every time - That's the *Law of large numbers*

+ The simulation already comes close to the calculated value.

print 10 * 10000 * (18 / 37 - 19 / 37)

-

+ The new strategy: bet on 13 - we win $350 when the ball rolls to 13.

while i < 10000
  cash -= 10
  numb = random 37
  if numb = 13
    cash += 360
  .
  i += 1
.
print "Cash after playing: $" & cash

+ This doesn't change the chances much, only that the fluctuation margin is wider.

* Gambling with $1000

+ We got $1000. We always bet $10 on the high numbers. When the $1000 is gone or becomes $2000, we stop playing. When the casino day is over (after 500 games), we go home and continue playing the next day.

cash = 1000
day = 1
while cash < 2000 and cash >= 10
  game += 1
  cash -= 10
  numb = random 37
  if numb >= 19
    cash += 20
  .
  if game = 500
    print "Day " & day & ": $" & cash
    day += 1
    game = 0
    sleep 1.5
  .
.
print "Day " & day & ": $" & cash
print "-------------"

+ We lose nearly every time our money.

-

+ We need a winning strategy. The chance that a high number will come after a low one could be higher. So we bet on the high numbers if there was a low number before, otherwise we bet on the low numbers.

cash = 1000
day = 1
while cash < 2000 and cash >= 10
  game += 1
  if numb < 19
    set_high = 1
  else
    set_high = 0
  .
  cash -= 10
  numb = random 37
  if set_high = 1 and numb >= 19
    cash += 20
  elif set_high = 0 and numb >= 1 and numb <= 18
    cash += 20
  .
  if game = 500
    print "Day " & day & ": $" & cash
    day += 1
    game = 0
    sleep 1.5
  .
.
print "Day " & day & ": $" & cash
print "-------------"

+ Sadly, that didn't work.

-

+ New Strategy: we double the bet after each loss so that the first win resumes all previous losses and makes a profit equal to the original bet. But we are limited by our capital and the table limit of $1000. Starting capital is $10000.

cash = 10000
day = 1
bet = 10
while cash < 20000 and cash >= 10
  game += 1
  cash -= bet
  numb = random 37
  if numb >= 19
    cash += 2 * bet
    bet = 10
  else
    bet *= 2
    if bet > 1000
      bet = 1000
    .
    if bet > cash
      bet = cash
    .
  .
  if game = 500
    print "Day " & day & ": $" & cash
    day += 1
    game = 0
    sleep 1.5
  .
.
print "Day " & day & ": $" & cash
print "-------------"

+ Most often, we lose.

-

+ Some European casinos are not so greedy, they return half the bet when the ball rolls to zero (La Partage).

cash = 1000
day = 1
while cash < 2000 and cash >= 10
  game += 1
  cash -= 10
  numb = random 37
  if numb >= 19
    cash += 20
  elif numb = 0
    cash += 5
  .
  if game = 500
    print "Day " & day & ": $" & cash
    day += 1
    game = 1
    sleep 1.5
  .
.
print "Day " & day & ": $" & cash
print "-------------"

+ Losing is than slower and sometimes we can even win.

-

+ We haven't found a winning strategy for roulette. You can keep trying. Better on the computer than in a real casino. It is cheaper and at least you practice programming.

* Lotto

+ Getting rich at the casino doesn't work so well. Let's try lotto, it doesn't make you poor as fast as the casino.

+ How many years does it take to have a Lotto six (6 out of 49) if you give a tip every week? For a Lotto five, the years are also printed out.

my_numbers[] = [ 3 7 13 27 31 49 ]
# 
len box[] 49
for i range 49
  box[i] = i + 1
.
subr drawing
  for i range 6
    h = random (49 - i) + i
    swap box[i] box[h]
  .
.
subr check
  n_match = 0
  for i range 6
    for j range 6
      if my_numbers[i] = box[j]
        n_match += 1
      .
    .
  .
.
while n_match < 6
  call drawing
  call check
  if n_match = 5
    print "5 correct after " & week div 52 & " years"
  .
  week += 1
.
print ""
print "6 correct after " & week div 52 & " years"

+ Your 6 numbers will come - sooner or later, more likely later.

* Not only for gambling

+ There are other things you can do with Monte Carlo methods. For example, you can approximate the value of *PI*. 

+ You fire random points at a square and count the number of points within the quarter circle. This can easily be determined with the theorem of Pythagoras. This proportion times four is close to PI.

for i range 100000
  x = randomf
  y = randomf
  if x * x + y * y < 1
    hit += 1
  .
.
print "PI: " & hit / i * 4

+ With visualisation

for i range 50000
  x = randomf
  y = randomf
  if x * x + y * y < 1
    hit += 1
    color 900
  else
    color 000
  .
  move x * 100 y * 100
  circle 0.2
  if i mod 1000 = 0
    sleep 0.01
  .
.
print hit / i * 4
`

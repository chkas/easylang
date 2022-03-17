# AoC-20 - Day 7: Handy Haversacks
# 
global col$[] cont_col[][] cont_cnt[][] .
# 
func col_id s$ . col .
  for col range len col$[]
    if col$[col] = s$
      break 2
    .
  .
  col$[] &= s$
  cont_col[][] &= [ ]
  cont_cnt[][] &= [ ]
.
func read_inp . .
  repeat
    inp$ = input
    until inp$ = ""
    s$[] = strsplit inp$ " "
    call col_id s$[0] & " " & s$[1] s
    if s$[4] <> "no"
      i = 4
      while i < len s$[]
        cnt = number s$[i]
        call col_id s$[i + 1] & " " & s$[i + 2] col
        cont_col[s][] &= col
        cont_cnt[s][] &= cnt
        i += 4
      .
    .
  .
.
call read_inp
call col_id "shiny gold" gold
# 
func search i . fnd .
  for j range len cont_col[i][]
    col = cont_col[i][j]
    if col = gold
      fnd = 1
      break 1
    else
      call search col fnd
    .
  .
.
func part1 . .
  for i range len cont_col[][]
    fnd = 0
    call search i fnd
    sum += fnd
  .
  print sum
.
call part1
# 
func get_sum col . sum .
  sum = 0
  for i range len cont_col[col][]
    call get_sum cont_col[col][i] s
    h = cont_cnt[col][i]
    sum += h + h * s
  .
.
func part2 . .
  call get_sum gold sum
  print sum
.
call part2
# 
input_data
plaid magenta bags contain 2 clear lavender bags, 3 clear teal bags, 4 vibrant gold bags.
light teal bags contain 4 drab magenta bags, 2 dull crimson bags, 3 posh brown bags.
wavy gray bags contain 3 dark aqua bags.
faded magenta bags contain 3 dark crimson bags, 3 dark violet bags.
shiny aqua bags contain 1 plaid turquoise bag.
muted maroon bags contain 2 dim cyan bags.
pale yellow bags contain 5 dotted black bags, 2 drab silver bags, 3 shiny gold bags.
dark white bags contain 5 posh salmon bags, 5 wavy brown bags, 4 dark fuchsia bags.
plaid tomato bags contain 1 posh brown bag, 3 muted white bags, 4 vibrant fuchsia bags, 2 drab magenta bags.
wavy green bags contain 5 pale brown bags, 3 plaid turquoise bags, 2 mirrored maroon bags.
posh tomato bags contain 5 mirrored white bags, 1 shiny lavender bag.
vibrant silver bags contain 4 dotted lavender bags, 3 wavy green bags, 1 striped yellow bag, 4 muted plum bags.
mirrored cyan bags contain 1 faded plum bag, 5 dull purple bags.
bright yellow bags contain 1 clear yellow bag, 3 muted indigo bags.
shiny plum bags contain 3 shiny teal bags, 3 wavy gray bags.
striped gold bags contain 1 dull plum bag, 2 dark crimson bags, 4 bright lime bags, 2 vibrant teal bags.
faded black bags contain 3 faded bronze bags.
dim white bags contain 5 striped turquoise bags, 4 muted yellow bags, 4 shiny crimson bags.
light bronze bags contain 5 bright plum bags.
vibrant maroon bags contain 3 dim beige bags, 4 drab blue bags.
vibrant lime bags contain 2 pale cyan bags.
striped fuchsia bags contain 1 vibrant bronze bag, 3 shiny lavender bags.
mirrored indigo bags contain 4 dim gray bags.
posh bronze bags contain 5 muted coral bags, 2 pale orange bags.
drab coral bags contain no other bags.
mirrored violet bags contain 2 dotted purple bags, 2 posh green bags.
dotted lime bags contain 3 dull fuchsia bags, 4 plaid fuchsia bags, 4 pale gray bags, 3 drab fuchsia bags.
dull gray bags contain 4 bright brown bags, 5 dark blue bags, 4 dull cyan bags, 1 dark violet bag.
posh indigo bags contain 1 faded teal bag, 3 dark cyan bags.
shiny orange bags contain 3 mirrored green bags, 5 dim tomato bags.
faded lime bags contain 5 vibrant olive bags.
dim magenta bags contain 3 vibrant green bags, 1 vibrant olive bag.
light salmon bags contain 1 dim turquoise bag, 1 muted tomato bag, 4 bright black bags, 5 posh yellow bags.
bright bronze bags contain 4 pale black bags, 2 mirrored maroon bags.
striped yellow bags contain 5 mirrored red bags, 3 light tan bags, 4 vibrant teal bags.
dark teal bags contain 5 posh yellow bags, 4 dull plum bags, 3 muted plum bags, 5 mirrored beige bags.
plaid green bags contain 4 mirrored yellow bags, 4 dark aqua bags, 2 muted gray bags.
bright red bags contain 2 faded olive bags, 5 drab olive bags, 1 striped lime bag.
light plum bags contain 2 pale coral bags.
muted yellow bags contain no other bags.
wavy yellow bags contain 3 posh plum bags, 2 dotted chartreuse bags, 4 dotted magenta bags.
drab brown bags contain 2 clear blue bags.
posh purple bags contain 4 light coral bags, 1 dim aqua bag.
faded brown bags contain 2 faded salmon bags, 5 striped crimson bags.
dark blue bags contain 4 pale brown bags, 1 mirrored gray bag.
mirrored gold bags contain 2 wavy gold bags, 4 muted gray bags, 5 drab olive bags.
muted tomato bags contain 1 bright violet bag, 5 pale plum bags, 5 light plum bags.
wavy tomato bags contain 4 dim beige bags, 5 faded orange bags.
clear aqua bags contain 1 dull lime bag, 1 clear violet bag, 2 dim tan bags, 3 bright gray bags.
clear violet bags contain 4 posh brown bags, 2 striped fuchsia bags.
plaid yellow bags contain 1 pale fuchsia bag, 1 mirrored purple bag, 4 faded purple bags.
muted lime bags contain 3 dotted lavender bags, 1 faded turquoise bag, 1 plaid chartreuse bag.
bright orange bags contain 1 shiny aqua bag, 2 mirrored salmon bags, 3 posh red bags.
pale cyan bags contain 3 dim orange bags, 4 drab lavender bags, 2 bright coral bags, 5 light white bags.
dark magenta bags contain 5 dull salmon bags, 1 drab cyan bag, 1 dotted maroon bag, 1 dim tomato bag.
plaid chartreuse bags contain 5 dotted orange bags, 2 vibrant maroon bags, 1 dotted lavender bag.
dotted tomato bags contain 2 muted bronze bags, 1 dark magenta bag.
muted tan bags contain 2 plaid tan bags.
posh magenta bags contain 2 vibrant red bags, 4 muted gray bags, 2 vibrant maroon bags.
bright purple bags contain 4 bright gray bags, 2 plaid tomato bags.
drab chartreuse bags contain 1 light blue bag, 3 drab gray bags, 1 dim tan bag, 5 posh crimson bags.
shiny white bags contain 5 dull beige bags.
bright cyan bags contain 4 shiny tomato bags, 1 muted lavender bag.
faded blue bags contain 3 vibrant aqua bags, 3 muted orange bags.
light cyan bags contain 4 mirrored magenta bags, 1 dotted turquoise bag.
wavy salmon bags contain 3 clear tan bags, 1 dull bronze bag.
pale indigo bags contain 2 faded blue bags, 2 pale yellow bags, 5 dim tomato bags, 5 dark coral bags.
pale olive bags contain 5 muted olive bags, 4 dim olive bags, 5 clear violet bags.
shiny brown bags contain 1 dark green bag, 3 vibrant olive bags, 1 wavy indigo bag.
shiny coral bags contain 5 bright violet bags.
posh plum bags contain 3 pale coral bags, 1 dull green bag, 1 plaid cyan bag, 4 shiny orange bags.
shiny silver bags contain 3 dotted brown bags, 3 bright tomato bags, 2 posh tomato bags.
wavy gold bags contain 1 bright gray bag, 1 shiny fuchsia bag.
vibrant yellow bags contain 2 posh lavender bags, 1 pale purple bag, 5 muted plum bags, 3 faded chartreuse bags.
drab blue bags contain 4 drab silver bags, 4 bright plum bags.
vibrant turquoise bags contain 2 bright maroon bags.
pale violet bags contain 5 faded violet bags.
dark bronze bags contain 4 faded indigo bags, 5 muted yellow bags.
drab gray bags contain no other bags.
shiny violet bags contain 2 bright lime bags, 5 dull magenta bags.
striped tomato bags contain 1 wavy indigo bag, 5 shiny coral bags, 5 vibrant bronze bags.
dull yellow bags contain 3 muted teal bags, 1 dim green bag, 4 pale brown bags.
shiny lime bags contain 5 muted yellow bags, 1 drab gray bag, 2 faded yellow bags, 1 pale magenta bag.
vibrant tan bags contain 1 vibrant lime bag, 1 drab blue bag, 5 dark maroon bags.
wavy coral bags contain 1 clear gold bag, 2 drab tan bags, 1 plaid magenta bag, 2 pale lime bags.
bright beige bags contain 3 bright violet bags.
dim silver bags contain 4 bright plum bags.
plaid beige bags contain 4 dotted turquoise bags, 5 shiny salmon bags, 2 pale red bags.
light blue bags contain no other bags.
wavy brown bags contain 4 light yellow bags, 1 dark coral bag, 2 dark olive bags, 4 vibrant teal bags.
pale gray bags contain 5 faded cyan bags, 2 shiny lime bags, 3 striped blue bags, 5 drab purple bags.
vibrant white bags contain 3 drab gray bags, 4 faded blue bags, 2 clear white bags, 1 dull tan bag.
light lime bags contain 3 muted white bags, 2 dark fuchsia bags.
dark yellow bags contain 3 vibrant maroon bags.
vibrant indigo bags contain 4 dark olive bags, 5 light purple bags.
faded yellow bags contain 1 posh brown bag, 2 light blue bags, 4 mirrored teal bags, 1 dull crimson bag.
mirrored bronze bags contain 3 bright black bags, 4 faded blue bags, 3 striped salmon bags, 4 mirrored olive bags.
pale chartreuse bags contain 3 dim aqua bags, 4 mirrored lime bags.
plaid gray bags contain 1 vibrant aqua bag.
pale fuchsia bags contain 5 wavy yellow bags, 3 dotted brown bags, 3 muted black bags, 1 dotted turquoise bag.
vibrant olive bags contain 1 faded tan bag, 3 drab silver bags, 4 muted brown bags, 2 faded blue bags.
dotted olive bags contain 3 plaid gold bags, 5 mirrored salmon bags, 2 dim magenta bags.
muted purple bags contain 2 muted magenta bags.
dim teal bags contain 2 dotted maroon bags.
mirrored red bags contain 3 dim tan bags, 5 clear black bags, 3 faded violet bags, 1 mirrored olive bag.
dark lime bags contain 3 mirrored violet bags.
shiny beige bags contain 1 dim yellow bag, 2 mirrored coral bags, 2 bright salmon bags, 5 vibrant brown bags.
dim gold bags contain 1 shiny gold bag.
mirrored maroon bags contain 1 faded blue bag.
shiny olive bags contain 5 plaid olive bags, 3 muted silver bags.
wavy purple bags contain 3 dim cyan bags, 2 dotted white bags, 4 dark coral bags.
drab fuchsia bags contain 4 dull gold bags, 3 muted yellow bags, 4 muted orange bags, 4 faded fuchsia bags.
drab beige bags contain 2 plaid olive bags.
vibrant coral bags contain 3 mirrored cyan bags.
dull salmon bags contain 2 shiny gold bags.
light chartreuse bags contain 3 plaid cyan bags.
striped silver bags contain 3 shiny violet bags, 3 dark blue bags.
dark indigo bags contain 3 light beige bags, 3 wavy white bags, 2 light black bags, 4 striped silver bags.
dotted orange bags contain 2 dull bronze bags, 3 vibrant red bags, 5 dull gold bags, 3 shiny yellow bags.
dotted fuchsia bags contain 1 vibrant cyan bag, 4 dotted crimson bags.
shiny turquoise bags contain 1 dark aqua bag, 4 dark cyan bags.
posh beige bags contain 1 shiny purple bag.
shiny tan bags contain 2 bright violet bags, 5 faded orange bags, 2 mirrored cyan bags.
faded maroon bags contain 1 dark red bag, 1 mirrored red bag.
clear tomato bags contain 4 mirrored teal bags, 2 posh turquoise bags.
pale beige bags contain 2 pale salmon bags, 5 dark teal bags, 4 shiny chartreuse bags, 5 striped green bags.
dull red bags contain 1 pale plum bag.
striped salmon bags contain 4 drab cyan bags, 5 light yellow bags, 4 vibrant orange bags, 4 dark gold bags.
dull lavender bags contain 3 pale blue bags, 5 clear blue bags.
dim red bags contain 3 vibrant bronze bags, 3 dotted gray bags.
light orange bags contain 2 plaid teal bags, 2 dull brown bags, 3 dark brown bags.
dotted silver bags contain 1 vibrant yellow bag, 4 pale lime bags, 4 pale crimson bags.
mirrored gray bags contain 1 dark coral bag, 2 mirrored crimson bags, 3 light yellow bags, 5 dull crimson bags.
light black bags contain 1 drab tan bag, 3 drab lavender bags.
plaid purple bags contain 4 clear tan bags, 3 dim yellow bags.
mirrored tan bags contain 2 dark olive bags, 4 clear violet bags, 5 wavy salmon bags.
dark silver bags contain 3 shiny silver bags, 3 dark lime bags.
dark violet bags contain 3 faded violet bags, 1 dull plum bag, 1 drab silver bag, 1 pale purple bag.
drab magenta bags contain 1 dark aqua bag, 2 muted maroon bags, 5 drab green bags.
pale green bags contain 5 posh red bags, 1 light fuchsia bag, 2 dotted chartreuse bags.
mirrored beige bags contain 4 vibrant turquoise bags, 4 muted yellow bags, 5 faded cyan bags, 2 drab purple bags.
striped aqua bags contain 4 clear black bags, 3 striped indigo bags.
mirrored crimson bags contain 2 dull gold bags, 5 wavy blue bags, 2 bright plum bags, 4 shiny yellow bags.
striped crimson bags contain 3 clear blue bags.
muted lavender bags contain 1 drab coral bag, 2 dull gold bags, 2 posh crimson bags, 1 mirrored green bag.
light tomato bags contain 3 dull black bags, 5 posh white bags.
pale tan bags contain 1 clear yellow bag, 2 vibrant aqua bags, 1 wavy red bag, 2 drab chartreuse bags.
dotted plum bags contain 4 shiny tomato bags, 1 mirrored olive bag, 2 posh turquoise bags, 1 faded bronze bag.
vibrant bronze bags contain 1 vibrant aqua bag.
clear tan bags contain 5 vibrant aqua bags, 1 drab coral bag, 4 muted lavender bags, 1 muted orange bag.
dark beige bags contain 5 dull green bags, 5 clear violet bags, 1 pale coral bag, 3 pale silver bags.
wavy plum bags contain 4 light teal bags, 4 shiny aqua bags, 2 light olive bags, 4 light blue bags.
striped turquoise bags contain 2 pale salmon bags, 3 muted orange bags, 3 posh lavender bags.
mirrored turquoise bags contain 3 vibrant lavender bags.
clear gray bags contain 3 dark cyan bags, 2 mirrored red bags, 2 wavy teal bags.
wavy violet bags contain 1 dark fuchsia bag.
clear crimson bags contain 1 pale red bag.
faded purple bags contain 1 shiny black bag, 2 mirrored white bags.
bright white bags contain 5 dotted maroon bags, 1 wavy aqua bag.
pale bronze bags contain 5 dull teal bags.
bright teal bags contain 1 mirrored aqua bag, 5 drab fuchsia bags.
posh silver bags contain 5 dim gray bags, 5 vibrant beige bags, 2 muted green bags.
posh chartreuse bags contain 3 pale brown bags.
dotted purple bags contain 5 faded indigo bags, 4 drab magenta bags, 5 shiny chartreuse bags, 3 faded maroon bags.
dim fuchsia bags contain 3 light blue bags, 3 muted yellow bags.
dark coral bags contain 4 dull crimson bags, 3 muted brown bags.
faded crimson bags contain 1 muted teal bag.
mirrored orange bags contain 3 dull bronze bags, 5 dull gold bags, 4 dim gray bags, 1 dotted green bag.
faded aqua bags contain 1 light gray bag.
vibrant magenta bags contain 1 dark aqua bag.
light fuchsia bags contain 4 light orange bags, 5 muted chartreuse bags, 3 wavy tomato bags, 1 dotted violet bag.
light coral bags contain 5 plaid tan bags.
dim lavender bags contain 1 pale purple bag.
shiny gray bags contain 5 shiny purple bags, 5 vibrant green bags, 1 bright cyan bag, 5 light blue bags.
dim turquoise bags contain no other bags.
wavy turquoise bags contain 1 light white bag, 4 posh magenta bags, 5 dim magenta bags.
dim salmon bags contain 5 faded violet bags, 1 faded lime bag.
wavy bronze bags contain 4 plaid magenta bags.
clear black bags contain 1 shiny lavender bag.
striped magenta bags contain 5 shiny cyan bags, 3 dotted purple bags, 4 striped silver bags, 3 light coral bags.
striped gray bags contain 3 faded plum bags, 2 striped fuchsia bags, 1 dim gray bag.
wavy cyan bags contain 1 striped indigo bag.
faded fuchsia bags contain 2 striped fuchsia bags.
plaid blue bags contain 2 dark brown bags, 5 drab gray bags, 5 plaid olive bags, 1 dark aqua bag.
pale red bags contain 5 clear aqua bags, 2 dim turquoise bags, 5 drab gray bags, 4 faded turquoise bags.
dim tan bags contain no other bags.
wavy fuchsia bags contain 2 dull lime bags, 1 drab fuchsia bag, 3 drab indigo bags.
drab gold bags contain 4 bright salmon bags, 2 shiny fuchsia bags, 4 faded lime bags, 5 plaid magenta bags.
pale lavender bags contain 1 wavy beige bag, 2 striped olive bags.
muted olive bags contain 5 striped fuchsia bags, 1 drab silver bag, 3 dotted lavender bags.
shiny magenta bags contain 3 clear orange bags, 2 plaid silver bags, 5 bright turquoise bags, 4 shiny orange bags.
muted blue bags contain 3 dark gray bags, 3 drab blue bags, 4 dark gold bags, 5 bright tomato bags.
dotted red bags contain 4 striped plum bags, 5 shiny aqua bags, 2 clear red bags.
vibrant tomato bags contain 3 wavy white bags, 1 mirrored lime bag, 1 dark fuchsia bag.
dull silver bags contain 4 posh black bags, 3 dark gray bags, 3 pale plum bags.
dark chartreuse bags contain 3 dull blue bags, 1 dim tan bag.
clear gold bags contain 3 muted magenta bags, 3 dim teal bags, 4 vibrant olive bags, 1 vibrant salmon bag.
posh teal bags contain 4 wavy red bags.
pale blue bags contain 1 dim red bag, 4 clear silver bags, 2 dull salmon bags, 4 vibrant salmon bags.
dotted gray bags contain 4 vibrant bronze bags, 4 dark maroon bags, 4 muted lavender bags.
dotted magenta bags contain 2 dull purple bags, 4 dim gold bags, 5 drab gray bags, 4 faded bronze bags.
faded gold bags contain 2 clear black bags, 3 pale tomato bags, 3 wavy aqua bags.
light turquoise bags contain 2 bright tan bags, 2 muted chartreuse bags.
muted green bags contain 4 muted gold bags, 4 posh black bags, 1 striped fuchsia bag, 1 dotted blue bag.
light beige bags contain 5 muted olive bags.
striped brown bags contain 4 bright white bags, 1 pale teal bag.
vibrant blue bags contain 4 clear aqua bags, 2 striped green bags, 1 faded indigo bag.
dim purple bags contain 4 bright coral bags, 2 posh yellow bags.
dim aqua bags contain 3 faded plum bags, 2 dim red bags.
clear salmon bags contain 2 drab gray bags, 1 mirrored cyan bag.
plaid tan bags contain 5 muted yellow bags, 1 bright brown bag.
striped green bags contain 2 drab cyan bags, 5 dim gray bags.
dark gray bags contain 3 muted teal bags, 1 clear violet bag, 5 bright cyan bags.
clear lavender bags contain 1 dark red bag, 1 wavy blue bag, 2 plaid silver bags.
vibrant gold bags contain 5 dark brown bags.
drab indigo bags contain 3 wavy aqua bags, 3 mirrored indigo bags, 5 dull brown bags.
light white bags contain 2 dull plum bags, 2 drab orange bags.
posh orange bags contain 4 wavy plum bags, 2 posh tan bags, 1 bright blue bag, 4 muted red bags.
drab red bags contain 2 mirrored maroon bags, 4 light coral bags.
muted silver bags contain 5 muted maroon bags, 3 clear fuchsia bags, 3 dark gold bags.
plaid olive bags contain 1 posh red bag, 1 pale crimson bag, 5 shiny tomato bags.
light tan bags contain 1 dull bronze bag, 2 dim lavender bags.
plaid white bags contain 3 dim turquoise bags.
pale aqua bags contain 1 vibrant crimson bag, 3 striped silver bags, 3 bright lavender bags, 3 shiny white bags.
bright tomato bags contain 5 drab purple bags, 1 shiny black bag, 4 wavy turquoise bags.
dotted green bags contain 3 dim cyan bags, 4 faded violet bags.
faded silver bags contain 1 shiny violet bag, 5 faded lavender bags.
vibrant cyan bags contain 1 bright green bag, 4 muted teal bags, 3 clear salmon bags.
mirrored blue bags contain 2 muted teal bags, 4 posh crimson bags, 2 dim indigo bags, 1 clear black bag.
faded olive bags contain 3 faded fuchsia bags, 3 dotted maroon bags, 5 wavy red bags, 4 plaid chartreuse bags.
striped lavender bags contain 2 vibrant salmon bags, 5 bright black bags, 5 dull blue bags.
bright green bags contain 2 muted maroon bags, 3 dim orange bags.
striped teal bags contain 4 light brown bags, 5 plaid brown bags, 4 clear turquoise bags.
posh yellow bags contain 1 pale teal bag, 5 dark crimson bags.
clear cyan bags contain 1 muted silver bag, 5 shiny white bags, 4 dotted white bags, 2 striped fuchsia bags.
drab tan bags contain 3 vibrant bronze bags, 1 pale white bag.
muted chartreuse bags contain 1 clear white bag, 1 shiny violet bag, 5 bright fuchsia bags.
drab aqua bags contain 3 mirrored tan bags.
vibrant gray bags contain 2 mirrored salmon bags, 3 dotted brown bags, 3 wavy maroon bags, 4 shiny maroon bags.
faded teal bags contain 2 drab gray bags, 1 dim gold bag, 4 drab orange bags, 5 clear violet bags.
wavy red bags contain 4 drab coral bags, 4 dotted lavender bags, 5 dim turquoise bags.
dull white bags contain 3 mirrored green bags, 5 dim turquoise bags.
dotted chartreuse bags contain 1 dotted green bag, 4 dull blue bags, 1 striped indigo bag, 5 dim tomato bags.
posh maroon bags contain 2 dull salmon bags, 5 clear bronze bags, 5 bright cyan bags, 5 clear silver bags.
faded white bags contain 4 drab gray bags, 4 dim gray bags.
striped black bags contain 1 bright salmon bag, 3 faded white bags, 3 dark magenta bags, 1 muted plum bag.
striped indigo bags contain 3 shiny tomato bags, 2 mirrored olive bags.
striped white bags contain 4 vibrant maroon bags.
dim gray bags contain 2 dull gold bags.
faded coral bags contain 5 mirrored lavender bags, 2 vibrant plum bags.
mirrored tomato bags contain 5 light yellow bags, 2 drab orange bags.
dotted tan bags contain 2 posh plum bags, 2 pale teal bags, 2 pale maroon bags.
dotted turquoise bags contain 5 mirrored crimson bags, 2 dull orange bags.
dim yellow bags contain 2 bright cyan bags, 3 dim turquoise bags, 2 mirrored green bags.
vibrant crimson bags contain 5 posh maroon bags.
pale crimson bags contain 4 clear black bags, 5 dull crimson bags, 5 dotted green bags.
light indigo bags contain 3 clear black bags.
plaid cyan bags contain 3 plaid tan bags, 3 drab coral bags.
drab bronze bags contain 5 dull teal bags, 3 plaid coral bags, 2 faded beige bags, 4 plaid aqua bags.
drab orange bags contain 1 mirrored green bag.
mirrored lime bags contain 1 shiny gray bag, 3 dim indigo bags.
posh aqua bags contain 4 muted tan bags, 2 faded yellow bags.
light purple bags contain 2 shiny chartreuse bags, 2 dim gray bags, 5 pale red bags.
dull teal bags contain 3 posh crimson bags, 1 dotted blue bag, 3 muted yellow bags.
vibrant red bags contain 4 faded white bags, 5 dim tan bags, 4 shiny lavender bags, 1 dim turquoise bag.
dull cyan bags contain 1 dotted silver bag, 5 striped olive bags, 5 faded gray bags, 1 dark green bag.
dim crimson bags contain 1 posh lime bag, 1 dark salmon bag.
light violet bags contain 5 posh brown bags.
clear orange bags contain 2 light olive bags, 4 faded turquoise bags, 4 drab gray bags, 2 mirrored olive bags.
dotted crimson bags contain 4 pale magenta bags, 5 muted red bags, 4 shiny yellow bags.
posh gray bags contain 4 dull lavender bags, 4 dim gray bags.
faded tomato bags contain 3 striped salmon bags, 1 bright lime bag, 4 vibrant magenta bags.
clear bronze bags contain 5 bright plum bags, 1 dim beige bag, 1 dim cyan bag, 5 dotted blue bags.
clear fuchsia bags contain 3 vibrant olive bags, 3 pale crimson bags, 4 wavy maroon bags, 4 drab olive bags.
bright violet bags contain 3 faded blue bags.
muted brown bags contain 1 muted lavender bag.
faded turquoise bags contain 3 dull gold bags, 3 muted orange bags, 4 light blue bags, 1 dotted gray bag.
dim indigo bags contain 5 muted maroon bags.
plaid black bags contain 4 plaid teal bags, 5 vibrant green bags.
dull purple bags contain 2 shiny gold bags, 4 dim gray bags.
dull crimson bags contain 1 dull gold bag, 4 vibrant aqua bags.
light aqua bags contain 5 mirrored orange bags, 4 wavy aqua bags.
pale lime bags contain 4 drab coral bags, 3 vibrant chartreuse bags, 4 posh crimson bags.
faded plum bags contain 1 muted brown bag, 4 dull bronze bags, 1 plaid white bag, 1 drab blue bag.
clear silver bags contain 4 muted gray bags, 5 mirrored maroon bags, 1 clear violet bag.
light brown bags contain 4 shiny maroon bags, 1 drab lavender bag, 5 dark violet bags, 4 dull green bags.
light crimson bags contain 4 light magenta bags, 3 mirrored blue bags, 1 pale tomato bag, 1 muted tomato bag.
plaid orange bags contain 4 dull silver bags.
muted black bags contain 2 dull tomato bags, 5 mirrored teal bags.
dotted bronze bags contain 4 dim tan bags.
drab tomato bags contain 4 muted lime bags, 2 striped cyan bags.
clear indigo bags contain 5 dull lavender bags, 4 dark indigo bags.
pale purple bags contain 5 dim beige bags, 5 shiny tomato bags, 3 mirrored olive bags, 5 muted lavender bags.
mirrored silver bags contain 4 vibrant maroon bags.
bright aqua bags contain 5 bright olive bags, 2 drab magenta bags, 2 dim teal bags.
wavy magenta bags contain 3 clear fuchsia bags, 3 mirrored gray bags, 4 dull fuchsia bags.
dull blue bags contain 5 drab coral bags, 5 drab chartreuse bags.
dim plum bags contain 1 muted magenta bag, 3 shiny lavender bags.
muted bronze bags contain 3 posh white bags, 5 clear black bags, 3 mirrored lime bags.
drab cyan bags contain 1 drab blue bag.
faded tan bags contain 4 pale plum bags.
posh violet bags contain 2 dim silver bags.
posh blue bags contain 5 clear yellow bags, 3 light indigo bags.
muted orange bags contain 5 drab gray bags, 1 dim turquoise bag.
bright lavender bags contain 1 drab cyan bag.
clear brown bags contain 2 shiny teal bags.
light maroon bags contain 4 dim fuchsia bags, 1 light yellow bag, 3 pale magenta bags.
muted indigo bags contain 4 shiny gold bags, 1 clear teal bag, 4 light gray bags, 2 shiny orange bags.
striped red bags contain 4 wavy blue bags, 1 vibrant maroon bag, 5 shiny yellow bags.
drab olive bags contain 2 dull blue bags, 5 pale coral bags, 1 vibrant salmon bag, 1 dotted green bag.
dotted aqua bags contain 5 dim aqua bags, 1 drab olive bag, 5 dim violet bags, 2 light plum bags.
dull indigo bags contain 5 vibrant gold bags.
drab turquoise bags contain 3 pale salmon bags, 1 shiny violet bag, 1 shiny orange bag, 1 mirrored olive bag.
bright turquoise bags contain 1 dotted green bag.
bright tan bags contain 5 faded cyan bags, 5 mirrored aqua bags, 3 dim orange bags.
bright chartreuse bags contain 1 dim bronze bag, 3 posh bronze bags, 3 drab salmon bags.
vibrant orange bags contain 3 dim fuchsia bags, 3 dull crimson bags, 5 vibrant salmon bags.
bright lime bags contain 3 posh tomato bags, 4 striped indigo bags, 1 dull white bag, 2 light plum bags.
dark black bags contain 1 muted aqua bag.
pale silver bags contain 2 dull fuchsia bags, 2 dark maroon bags.
dotted maroon bags contain 2 drab olive bags.
shiny gold bags contain 2 dim beige bags, 1 dark maroon bag, 4 light blue bags.
posh lime bags contain 1 shiny green bag, 3 drab purple bags, 3 vibrant blue bags.
vibrant violet bags contain 5 dim silver bags, 4 dotted maroon bags, 5 drab fuchsia bags, 5 clear plum bags.
bright silver bags contain 2 drab coral bags, 5 mirrored red bags, 5 drab fuchsia bags.
dark purple bags contain 1 drab chartreuse bag, 1 posh lavender bag, 1 clear blue bag.
light green bags contain 1 dark plum bag, 5 dull olive bags, 4 shiny lavender bags.
dull beige bags contain 5 light indigo bags.
muted gold bags contain 2 mirrored magenta bags, 5 shiny orange bags, 5 drab lavender bags.
plaid gold bags contain 4 dark crimson bags, 3 dotted crimson bags.
plaid silver bags contain 2 dotted blue bags, 1 vibrant aqua bag, 2 shiny chartreuse bags.
vibrant green bags contain 5 posh brown bags, 3 light gray bags, 2 wavy blue bags.
posh crimson bags contain 2 dim turquoise bags, 3 dim tan bags, 4 dotted lavender bags.
bright coral bags contain 1 faded chartreuse bag.
shiny teal bags contain 2 muted orange bags, 5 muted olive bags, 5 mirrored olive bags.
posh brown bags contain 4 posh crimson bags.
pale white bags contain 5 dark coral bags, 3 dim tomato bags, 3 wavy indigo bags.
clear olive bags contain 1 bright plum bag.
dotted violet bags contain 3 posh plum bags.
vibrant salmon bags contain 3 dim beige bags, 2 light gray bags, 2 wavy red bags, 5 dull brown bags.
dotted indigo bags contain 1 dull maroon bag.
clear lime bags contain 5 posh maroon bags, 1 muted coral bag, 5 wavy maroon bags, 3 muted orange bags.
posh cyan bags contain 3 posh black bags, 4 drab black bags.
striped blue bags contain 5 dim yellow bags, 1 wavy chartreuse bag.
dark cyan bags contain 1 faded blue bag.
clear magenta bags contain 3 muted green bags, 5 dotted aqua bags, 2 posh gray bags.
dull lime bags contain 4 dotted lavender bags, 3 dim cyan bags, 4 dim tan bags.
pale brown bags contain 3 dim gray bags.
dull violet bags contain 2 posh tomato bags, 2 clear blue bags, 2 drab silver bags, 4 muted gray bags.
dark tan bags contain 2 dim cyan bags, 4 dotted lavender bags.
dotted black bags contain 3 plaid olive bags, 3 posh plum bags, 3 wavy turquoise bags, 5 muted teal bags.
muted cyan bags contain 2 shiny tan bags, 1 bright aqua bag, 4 dotted lavender bags, 3 vibrant crimson bags.
clear green bags contain 1 dotted violet bag, 3 dotted bronze bags, 1 clear bronze bag.
bright olive bags contain 4 muted orange bags, 3 dotted orange bags.
dull turquoise bags contain 1 faded lavender bag, 5 dark blue bags, 3 striped cyan bags.
mirrored plum bags contain 5 dull violet bags, 3 faded turquoise bags.
plaid lavender bags contain 2 striped green bags, 2 posh magenta bags, 3 drab cyan bags, 3 bright plum bags.
clear yellow bags contain 1 mirrored green bag, 2 dotted blue bags.
light gold bags contain 3 dark blue bags.
dark gold bags contain 1 light aqua bag.
drab crimson bags contain 2 posh coral bags, 1 shiny red bag.
faded chartreuse bags contain 2 vibrant red bags, 4 vibrant aqua bags, 5 pale purple bags, 5 mirrored olive bags.
bright plum bags contain 2 pale tan bags.
muted crimson bags contain 3 dotted orange bags, 4 bright orange bags, 3 drab maroon bags, 2 vibrant turquoise bags.
dim black bags contain 3 shiny green bags, 5 mirrored gold bags, 2 wavy fuchsia bags.
pale gold bags contain 2 wavy silver bags, 3 muted magenta bags.
wavy black bags contain 2 dim beige bags, 1 clear bronze bag, 5 shiny gray bags.
dim green bags contain 1 wavy maroon bag.
dull tomato bags contain 4 mirrored red bags, 1 dark violet bag, 2 posh magenta bags, 1 light indigo bag.
clear beige bags contain 1 posh coral bag, 4 dim silver bags, 1 wavy turquoise bag, 4 bright white bags.
posh red bags contain 5 dim cyan bags.
dark turquoise bags contain 1 dark cyan bag, 3 light blue bags.
clear maroon bags contain 2 mirrored white bags, 5 dull plum bags, 3 dull beige bags.
light silver bags contain 4 shiny violet bags, 4 posh indigo bags, 1 wavy white bag.
muted salmon bags contain 3 dim lime bags, 2 shiny violet bags, 2 dark green bags, 1 mirrored chartreuse bag.
muted plum bags contain 3 bright coral bags, 5 posh indigo bags, 4 bright gray bags.
dim orange bags contain 5 mirrored brown bags, 4 dim turquoise bags.
light gray bags contain 2 light blue bags, 2 pale purple bags.
mirrored magenta bags contain 5 pale coral bags, 1 dark crimson bag.
drab lavender bags contain 3 clear yellow bags.
striped tan bags contain 1 dotted black bag, 1 dull crimson bag.
wavy aqua bags contain 1 muted teal bag.
light olive bags contain 4 drab magenta bags.
bright indigo bags contain 1 mirrored gray bag, 4 vibrant red bags, 3 dim tomato bags.
dotted yellow bags contain 1 drab olive bag, 4 pale crimson bags, 4 drab gray bags, 2 striped fuchsia bags.
mirrored lavender bags contain 3 drab coral bags, 3 dim indigo bags, 4 dim gold bags, 5 wavy salmon bags.
muted white bags contain 5 bright brown bags, 5 bright plum bags, 1 dull gold bag.
posh fuchsia bags contain 3 dotted aqua bags.
dotted brown bags contain 4 dim turquoise bags, 1 dotted gray bag, 3 dark magenta bags, 2 bright coral bags.
shiny bronze bags contain 4 mirrored indigo bags, 2 wavy turquoise bags, 2 wavy blue bags, 3 mirrored beige bags.
vibrant teal bags contain 1 dark violet bag, 3 wavy blue bags, 1 dull fuchsia bag.
plaid indigo bags contain 4 vibrant magenta bags, 2 dull cyan bags.
muted turquoise bags contain 5 dark magenta bags, 5 drab gray bags, 4 plaid red bags.
striped bronze bags contain 5 bright white bags, 2 clear bronze bags, 3 bright silver bags.
posh salmon bags contain 4 drab maroon bags, 3 mirrored bronze bags, 4 faded plum bags.
light magenta bags contain 5 dark purple bags, 3 plaid silver bags.
dull fuchsia bags contain 3 posh red bags, 4 dark coral bags, 2 dark aqua bags.
vibrant aqua bags contain 3 drab coral bags, 3 dim cyan bags, 5 dim tan bags.
muted red bags contain 3 plaid teal bags, 1 posh coral bag, 3 posh plum bags.
drab yellow bags contain 3 bright brown bags, 3 mirrored aqua bags.
dim cyan bags contain no other bags.
shiny yellow bags contain 4 wavy red bags, 2 dotted blue bags.
bright maroon bags contain 4 drab gray bags, 1 mirrored olive bag, 5 faded white bags.
dark crimson bags contain 4 drab orange bags, 5 vibrant red bags, 1 pale purple bag.
shiny cyan bags contain 4 faded plum bags, 4 faded teal bags, 1 posh indigo bag.
posh olive bags contain 1 dark tan bag, 1 drab green bag, 5 pale cyan bags, 4 vibrant turquoise bags.
dull chartreuse bags contain 3 shiny chartreuse bags, 3 striped brown bags, 2 mirrored blue bags, 3 pale coral bags.
dim bronze bags contain 4 muted olive bags.
faded orange bags contain 2 vibrant red bags.
dim violet bags contain 1 posh red bag, 5 plaid tan bags.
wavy indigo bags contain 2 bright olive bags, 3 shiny red bags, 4 clear blue bags.
dull coral bags contain 4 faded magenta bags, 1 plaid lime bag, 2 dotted red bags.
dotted white bags contain 2 mirrored purple bags, 4 faded cyan bags, 1 vibrant salmon bag.
shiny crimson bags contain 5 mirrored magenta bags, 2 plaid silver bags, 3 vibrant brown bags, 2 vibrant orange bags.
bright magenta bags contain 1 light silver bag, 1 striped salmon bag, 4 dark gold bags, 5 faded lime bags.
dotted salmon bags contain 5 dim purple bags, 4 dull indigo bags, 2 pale turquoise bags.
clear purple bags contain 2 clear coral bags, 2 muted green bags, 5 clear maroon bags.
mirrored purple bags contain 4 drab silver bags, 1 wavy aqua bag, 1 shiny teal bag.
wavy teal bags contain 5 dull salmon bags, 2 bright coral bags, 2 bright plum bags.
shiny red bags contain 4 dull indigo bags, 4 pale coral bags, 3 wavy blue bags.
wavy tan bags contain 5 faded turquoise bags, 2 posh tomato bags, 4 dark green bags, 4 dull crimson bags.
wavy crimson bags contain 3 vibrant gold bags, 3 drab magenta bags, 3 dull salmon bags.
wavy olive bags contain 2 pale blue bags, 1 dull gold bag, 3 clear aqua bags, 1 mirrored gray bag.
shiny salmon bags contain 2 mirrored aqua bags, 3 mirrored tan bags, 1 wavy blue bag.
dark plum bags contain 1 faded salmon bag, 1 faded plum bag, 3 pale tan bags.
mirrored yellow bags contain 3 clear lime bags.
dark lavender bags contain 5 muted teal bags, 5 shiny bronze bags.
pale tomato bags contain 2 clear silver bags, 3 shiny green bags, 2 mirrored blue bags, 4 vibrant beige bags.
dotted cyan bags contain 4 light gray bags.
wavy silver bags contain 4 drab teal bags, 5 vibrant maroon bags, 4 wavy teal bags, 4 striped turquoise bags.
vibrant brown bags contain 5 striped gray bags, 1 bright turquoise bag.
mirrored salmon bags contain 1 bright salmon bag, 4 drab lavender bags.
striped violet bags contain 5 drab teal bags.
bright gold bags contain 4 clear blue bags, 2 dull gray bags, 1 striped red bag, 5 muted indigo bags.
faded cyan bags contain 5 dark green bags.
plaid fuchsia bags contain 2 posh blue bags.
posh green bags contain 4 striped cyan bags, 2 bright lime bags, 1 dotted black bag, 5 dim silver bags.
dull plum bags contain 4 striped fuchsia bags.
dull brown bags contain 1 faded bronze bag, 5 posh tomato bags, 1 muted gray bag.
dull aqua bags contain 1 light blue bag, 1 vibrant bronze bag, 1 posh brown bag.
clear plum bags contain 4 clear silver bags, 2 bright beige bags, 5 mirrored red bags, 2 dull magenta bags.
dull orange bags contain 1 light blue bag, 5 shiny maroon bags.
wavy maroon bags contain 3 dotted gray bags, 3 faded indigo bags, 3 dim cyan bags.
plaid teal bags contain 2 dotted blue bags, 5 vibrant olive bags, 5 faded orange bags.
muted gray bags contain 1 dim tan bag, 1 shiny tomato bag, 3 vibrant bronze bags, 1 drab coral bag.
plaid aqua bags contain 3 mirrored tan bags, 2 mirrored green bags, 2 dark gray bags, 4 dotted blue bags.
striped beige bags contain 4 clear salmon bags.
faded beige bags contain 4 vibrant red bags, 3 pale tan bags.
pale salmon bags contain 3 mirrored chartreuse bags, 3 striped salmon bags, 4 faded blue bags.
plaid turquoise bags contain 3 shiny lavender bags, 3 faded beige bags.
muted fuchsia bags contain 3 muted indigo bags, 3 vibrant red bags, 4 dim lavender bags, 4 dull teal bags.
drab black bags contain 5 dark beige bags, 3 mirrored olive bags, 3 faded turquoise bags.
shiny fuchsia bags contain 3 muted brown bags, 4 dim beige bags.
shiny maroon bags contain 2 dark bronze bags, 2 bright salmon bags, 5 striped cyan bags.
shiny lavender bags contain 3 muted orange bags, 1 bright plum bag, 5 muted lavender bags.
bright gray bags contain 1 plaid tan bag, 2 dotted gray bags.
striped purple bags contain 5 posh black bags, 2 striped fuchsia bags, 3 mirrored magenta bags, 3 dark tan bags.
faded red bags contain 5 posh coral bags, 3 dim silver bags, 2 bright black bags, 3 muted green bags.
dim blue bags contain 5 drab purple bags.
dotted gold bags contain 5 pale coral bags, 5 dim bronze bags.
bright crimson bags contain 2 clear purple bags, 2 plaid yellow bags, 4 muted fuchsia bags.
dull gold bags contain no other bags.
mirrored teal bags contain 4 wavy maroon bags, 1 faded magenta bag, 2 wavy teal bags, 2 vibrant salmon bags.
dotted lavender bags contain no other bags.
muted aqua bags contain 4 muted tan bags.
vibrant black bags contain 3 plaid white bags.
pale maroon bags contain 3 dotted cyan bags, 4 posh brown bags, 1 bright salmon bag.
dark maroon bags contain 1 shiny tomato bag, 2 mirrored white bags, 2 posh red bags.
pale magenta bags contain 4 vibrant red bags, 3 bright cyan bags.
posh lavender bags contain 5 dim silver bags, 3 striped indigo bags, 3 muted gray bags, 3 dull violet bags.
striped chartreuse bags contain 2 shiny chartreuse bags, 5 drab gray bags, 2 dotted brown bags, 1 plaid coral bag.
muted teal bags contain 5 clear black bags, 1 light white bag, 4 posh crimson bags, 4 faded beige bags.
mirrored chartreuse bags contain 1 bright silver bag, 1 light plum bag, 2 drab purple bags.
dim lime bags contain 1 dotted gray bag, 4 muted olive bags, 2 muted gray bags.
drab violet bags contain 1 plaid fuchsia bag, 4 dull white bags, 3 posh beige bags.
bright fuchsia bags contain 1 pale turquoise bag, 5 dotted cyan bags.
striped lime bags contain 3 light blue bags, 4 drab fuchsia bags, 5 light aqua bags, 1 dim indigo bag.
wavy lavender bags contain 4 dull violet bags.
drab maroon bags contain 1 pale brown bag, 1 pale purple bag.
clear chartreuse bags contain 4 faded fuchsia bags, 2 light gray bags, 3 vibrant maroon bags, 3 posh lavender bags.
clear teal bags contain 1 faded teal bag, 4 muted white bags.
dull black bags contain 1 pale blue bag, 2 shiny green bags, 3 plaid plum bags, 2 faded turquoise bags.
dark olive bags contain 1 faded tan bag, 3 dim beige bags, 4 dark chartreuse bags, 5 light yellow bags.
faded green bags contain 4 striped green bags, 5 dotted blue bags, 3 striped beige bags.
drab green bags contain 1 clear aqua bag, 4 light plum bags.
mirrored green bags contain no other bags.
posh black bags contain 4 striped cyan bags, 2 dim tan bags, 5 drab blue bags, 5 faded white bags.
muted magenta bags contain 2 vibrant aqua bags.
mirrored brown bags contain 4 wavy turquoise bags, 1 dull magenta bag, 1 dim silver bag, 2 dim gray bags.
plaid brown bags contain 5 mirrored brown bags, 4 mirrored lime bags, 1 clear red bag.
posh white bags contain 5 clear bronze bags, 5 faded maroon bags, 3 light lavender bags.
posh turquoise bags contain 1 pale tan bag, 1 dark purple bag, 4 shiny white bags, 2 drab brown bags.
dim brown bags contain 2 drab coral bags.
plaid violet bags contain 4 clear lavender bags, 4 drab maroon bags, 4 muted maroon bags, 1 bright red bag.
posh coral bags contain 1 shiny gold bag, 4 dim red bags, 5 dull aqua bags.
bright black bags contain 2 dull teal bags.
plaid bronze bags contain 1 bright orange bag, 5 wavy turquoise bags, 5 vibrant beige bags.
drab plum bags contain 2 bright lime bags.
shiny green bags contain 5 wavy blue bags, 4 bright lime bags.
drab teal bags contain 1 wavy aqua bag, 2 mirrored gray bags, 5 dim lavender bags.
bright blue bags contain 4 muted purple bags, 3 bright fuchsia bags, 5 muted maroon bags.
shiny chartreuse bags contain 2 clear violet bags, 3 posh coral bags, 2 drab chartreuse bags, 2 pale silver bags.
faded lavender bags contain 5 dim lavender bags, 1 dim turquoise bag, 1 vibrant magenta bag.
dim coral bags contain 3 faded teal bags, 3 faded indigo bags.
striped maroon bags contain 1 shiny aqua bag, 3 vibrant magenta bags, 5 light maroon bags, 2 dull aqua bags.
striped plum bags contain 1 dotted brown bag, 3 wavy green bags, 2 mirrored tomato bags.
drab lime bags contain 2 wavy teal bags, 3 dim maroon bags, 1 dark cyan bag.
muted coral bags contain 4 dim maroon bags, 5 drab lavender bags, 5 drab purple bags.
drab white bags contain 3 shiny cyan bags, 5 wavy aqua bags, 5 faded maroon bags.
dotted teal bags contain 3 muted indigo bags.
plaid coral bags contain 4 dotted aqua bags, 4 wavy salmon bags, 2 dim maroon bags.
bright salmon bags contain 5 dark cyan bags.
shiny blue bags contain 1 posh lime bag.
plaid red bags contain 1 dim maroon bag, 4 faded crimson bags, 2 muted plum bags.
dull olive bags contain 2 faded plum bags, 4 striped white bags, 4 wavy indigo bags.
shiny purple bags contain 2 drab coral bags, 5 pale blue bags.
striped olive bags contain 2 vibrant orange bags, 5 dim red bags, 1 dim cyan bag, 3 mirrored cyan bags.
dull magenta bags contain 2 vibrant yellow bags.
dull tan bags contain 2 mirrored green bags, 5 muted yellow bags, 4 faded turquoise bags.
vibrant plum bags contain 3 shiny olive bags, 1 dim indigo bag.
mirrored black bags contain 3 posh black bags, 4 vibrant tan bags, 1 vibrant black bag, 2 posh orange bags.
shiny black bags contain 3 muted white bags, 1 dim maroon bag, 2 dull salmon bags.
clear red bags contain 4 muted gray bags.
striped cyan bags contain 4 posh chartreuse bags, 4 dull brown bags, 2 posh tomato bags, 3 dark crimson bags.
faded violet bags contain 1 drab chartreuse bag, 1 dim turquoise bag, 2 mirrored olive bags, 2 clear tan bags.
muted beige bags contain 2 bright silver bags, 5 bright gold bags, 4 pale brown bags, 2 bright bronze bags.
pale black bags contain 5 vibrant green bags, 3 dark coral bags.
vibrant purple bags contain 4 dark brown bags, 3 clear violet bags, 1 wavy black bag, 2 faded fuchsia bags.
dark fuchsia bags contain 1 wavy salmon bag.
dark aqua bags contain 5 vibrant aqua bags, 5 dull blue bags.
pale coral bags contain 3 mirrored olive bags, 5 faded blue bags, 3 dim beige bags.
striped coral bags contain 4 shiny fuchsia bags, 1 plaid brown bag, 2 bright turquoise bags, 1 vibrant blue bag.
pale turquoise bags contain 3 dull green bags, 1 dim red bag.
pale teal bags contain 3 mirrored green bags, 1 faded violet bag, 3 vibrant green bags.
wavy beige bags contain 1 bright tomato bag, 2 dull olive bags, 3 dotted violet bags.
dark orange bags contain 2 posh salmon bags, 1 clear bronze bag.
shiny tomato bags contain 5 drab orange bags, 3 dull crimson bags, 4 clear tan bags, 5 faded blue bags.
mirrored fuchsia bags contain 2 bright maroon bags, 2 dim beige bags, 3 muted gold bags, 4 striped brown bags.
clear coral bags contain 5 dim brown bags, 1 drab lavender bag, 3 dull lime bags.
clear white bags contain 2 clear violet bags, 5 dull beige bags, 3 vibrant aqua bags, 4 dull blue bags.
dull maroon bags contain 5 dim salmon bags, 4 dim silver bags, 3 dark magenta bags.
drab silver bags contain 5 faded blue bags, 5 wavy chartreuse bags, 5 dull crimson bags, 5 muted yellow bags.
faded salmon bags contain 4 wavy olive bags, 3 mirrored salmon bags, 1 plaid violet bag.
drab salmon bags contain 4 dull magenta bags, 5 muted teal bags.
light yellow bags contain 1 pale coral bag, 4 dim turquoise bags, 4 mirrored maroon bags.
plaid crimson bags contain 3 dark violet bags, 2 dull gray bags.
dark tomato bags contain 1 posh teal bag, 1 posh lavender bag, 5 dim cyan bags, 4 light yellow bags.
dim chartreuse bags contain 5 muted plum bags, 4 vibrant aqua bags.
mirrored white bags contain 5 dull gold bags, 5 muted lavender bags, 2 dull crimson bags.
dotted blue bags contain 3 muted orange bags.
mirrored olive bags contain 5 posh crimson bags, 3 faded blue bags.
dim maroon bags contain 5 wavy aqua bags, 5 faded violet bags, 2 dull crimson bags, 2 posh lavender bags.
shiny indigo bags contain 5 dull lavender bags, 1 light white bag.
wavy chartreuse bags contain 3 mirrored white bags, 2 drab chartreuse bags, 5 muted orange bags, 4 dull crimson bags.
striped orange bags contain 4 shiny salmon bags.
dull green bags contain 4 muted gray bags, 4 drab gray bags, 3 clear yellow bags.
pale orange bags contain 5 posh turquoise bags, 3 light beige bags, 3 bright aqua bags, 5 dim bronze bags.
dim tomato bags contain 3 bright brown bags.
dull bronze bags contain 1 bright plum bag, 3 wavy red bags, 2 drab silver bags.
wavy blue bags contain 3 dull crimson bags, 4 light blue bags.
clear blue bags contain 1 dim gold bag, 4 dark crimson bags, 2 light gray bags, 4 muted olive bags.
clear turquoise bags contain 1 muted lime bag, 2 faded turquoise bags, 4 plaid lavender bags.
dark brown bags contain 3 dull gold bags, 5 bright cyan bags, 2 dull brown bags, 3 dark aqua bags.
plaid lime bags contain 3 dotted purple bags, 1 plaid blue bag, 3 bright silver bags, 1 vibrant chartreuse bag.
mirrored coral bags contain 2 plaid olive bags.
vibrant fuchsia bags contain 3 light indigo bags.
dim beige bags contain 1 muted lavender bag, 3 light blue bags.
wavy orange bags contain 5 dotted teal bags, 3 dull magenta bags, 4 clear chartreuse bags, 5 shiny violet bags.
vibrant lavender bags contain 3 vibrant orange bags, 1 dark aqua bag.
mirrored aqua bags contain 4 drab blue bags.
faded gray bags contain 1 wavy blue bag, 2 vibrant yellow bags, 1 light magenta bag.
dark green bags contain 2 wavy red bags.
dark red bags contain 5 drab magenta bags, 3 bright lime bags.
dark salmon bags contain 2 striped indigo bags, 5 wavy lavender bags, 1 dim fuchsia bag, 5 dim yellow bags.
wavy lime bags contain 2 striped plum bags, 3 faded brown bags.
muted violet bags contain 1 faded tomato bag.
faded bronze bags contain 2 dim gray bags, 3 muted gray bags.
vibrant beige bags contain 5 striped brown bags, 5 dull lime bags.
dotted coral bags contain 4 shiny brown bags, 1 bright silver bag, 2 clear yellow bags.
plaid maroon bags contain 3 shiny magenta bags, 3 faded tomato bags.
dim olive bags contain 3 light brown bags.
pale plum bags contain 4 pale tan bags, 1 drab silver bag, 3 dim beige bags.
vibrant chartreuse bags contain 4 mirrored white bags, 2 muted orange bags, 2 posh magenta bags.
faded indigo bags contain 3 bright brown bags, 3 dim tomato bags.
posh gold bags contain 3 dark silver bags, 4 mirrored gray bags, 4 dark salmon bags, 1 dim white bag.
light lavender bags contain 2 dark cyan bags.
plaid salmon bags contain 2 dotted green bags, 4 shiny indigo bags, 5 bright brown bags.
wavy white bags contain 2 dim lavender bags, 3 faded teal bags, 2 dull tan bags, 3 drab orange bags.
plaid plum bags contain 1 vibrant yellow bag.
posh tan bags contain 2 dull orange bags, 4 pale violet bags, 2 shiny brown bags.
light red bags contain 4 dim maroon bags, 4 faded salmon bags, 5 plaid purple bags.
dotted beige bags contain 2 shiny fuchsia bags, 3 faded cyan bags, 5 mirrored red bags, 3 drab turquoise bags.
drab purple bags contain 3 bright cyan bags, 1 faded bronze bag, 3 light plum bags, 1 dull fuchsia bag.
bright brown bags contain 2 dotted green bags, 4 clear tan bags, 3 wavy red bags.



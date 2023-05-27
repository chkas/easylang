# AoC-21 - Day 10: Syntax Scoring
# 
# Recursive syntax tree parsing. 
# 
proc sort . d[] .
   for i = 1 to len d[] - 1
      for j = i + 1 to len d[]
         if d[j] > d[i]
            swap d[j] d[i]
         .
      .
   .
.
global inp$ c$ inpi .
proc nextc . .
   c$ = substr inp$ inpi 1
   inpi += 1
.
procdecl parse . .
global score err .
proc parse_expect b$ . .
   call nextc
   call parse
   if c$ = "" and err = 0
      h = 4
      if b$ = ")"
         h = 1
      elif b$ = "]"
         h = 2
      elif b$ = "}"
         h = 3
      .
      score = score * 5 + h
   elif c$ <> b$ and err = 0
      err = 25137
      if c$ = ")"
         err = 3
      elif c$ = "]"
         err = 57
      elif c$ = "}"
         err = 1197
      .
   .
   call nextc
.
proc parse . .
   while 1 = 1
      if c$ = "("
         call parse_expect ")"
      elif c$ = "["
         call parse_expect "]"
      elif c$ = "{"
         call parse_expect "}"
      elif c$ = "<"
         call parse_expect ">"
      else
         break 1
      .
   .
.
repeat
   inp$ = input
   until inp$ = ""
   inpi = 1
   err = 0
   score = 0
   call nextc
   call parse
   if score <> 0
      score[] &= score
   .
   part1 += err
.
print part1
call sort score[]
print score[len score[] div 2 + 1]
# 
input_data
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]



txt_tutor=`+ Procedures and recursion

-

+ Procedures are defined with *proc* and called with *call*. The syntax of a procedure definition is: *proc <proc_name> <value parameters> . <reference parameters> .*

+ Variables that occur for the first time within a procedure are local to that procedure. Global variables declared above can be accessed.

proc gcd a b . res .
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   res = a
.
call gcd 120 35 r
print r

+ *a*, *b* are value parameters, *res* is a reference (or inout) parameter and *h* is a local variable.

* Recursive procedures

+ The factorial of a number *n* is the product of numbers from *1* to *n*: *n! = n ** (n - 1) ** . . . ** 2 ** 1*

+ This can be easily calculated

proc fact n . res .
   res = 1
   while n > 1
      res = res * n
      n -= 1
   .
.
call fact 6 res
print res

+ The factorial can be defined recursively: *n! = n ** (n - 1)!* and *1! = 1*

+ It can also be calculated recursively

proc fact n . res .
  if n = 1
    res = 1
  else
    call fact n - 1 h
    res = n * h
  .
.
call fact 6 res
print res

+ The procedure is called within the procedure. Each calling instance requires a new set of local variables and parameters. This and the return address are stored on the stack. The recursion depth is limited.

* Fractal tree

+ A simple tree can be viewed recursively. It consists of a branch at the end of which two smaller trees, one slightly inclined to the left, the other slightly to the right, grow out. 

+ Such a tree can be drawn relatively easily with a recursive program.

proc tree x y angle depth . .
   linewidth depth * 0.4
   move x y
   x += cos angle * depth * 1.4 * (randomf + 0.5)
   y += sin angle * depth * 1.4 * (randomf + 0.5)
   line x y
   if depth > 1
      call tree x y angle - 20 depth - 1
      call tree x y angle + 20 depth - 1
   .
.
call tree 50 5 90 10

* Quicksort

proc qsort left right . d[] .
  # 
  subr partition
    mid = left
    for i = left + 1 to right
      if d[i] < d[left]
        mid += 1
        swap d[i] d[mid]
      .
    .
    swap d[left] d[mid]
  .
  # 
  if left < right
    call partition
    call qsort left mid - 1 d[]
    call qsort mid + 1 right d[]
  .
.
for i = 1 to 100
  d[] &= random 1000
.
call qsort 1 len d[] d[]
print d[]

+ The subroutine *partition* is defined within the procedure *sort*. In the subroutine *partition*, access to the local variables of the procedure *sort* is then also possible.

* Tower of Hanoi

+ There are three places and some discs of different sizes. The discs are in first place in ascending size. They must be reallocated to second place.  The third place can be used. Only one disc can be moved at a time. The discs must be taken from above and placed on top of the target, whereby the disc underneath must be larger.

+ The problem can be solved recursively: To move *n* discs to the target place, move *n-1* discs to the auxiliary place, then give the lowest disc to the target and then move the *n-1* discs from the auxiliary place to the target place.

ndisc = 5
len tow_height[] 3
len tow_disc[][] 3
len tow_disc[1][] ndisc
len tow_disc[2][] ndisc
len tow_disc[3][] ndisc
textsize 7
# 
proc init . .
   for i = 1 to ndisc
      tow_disc[1][i] = ndisc - i
   .
   tow_height[1] = ndisc
.
proc show . .
   clear
   color 444
   move 0 0
   rect 100 10
   for tow = 1 to 3
      linewidth 3
      color 444
      x = 18 + 32 * (tow - 1)
      move x 12 + ndisc * 6
      line x 10
      move x - 2 2
      color 998
      text tow
      linewidth 6
      for i = 1 to tow_height[tow]
         d = tow_disc[tow][i]
         color 210 + d * 111
         sz = 4 + 26 * d / ndisc
         x = (tow - 1) * 32 + 6 + (24 - sz) / 2
         y = 7 + i * 6
         move x y
         line x + sz y
      .
   .
.
proc move_disc src dst . .
   print "move " & src & " to " & dst
   sleep 0.5
   d = tow_disc[src][tow_height[src]]
   tow_height[src] -= 1
   tow_height[dst] += 1
   tow_disc[dst][tow_height[dst]] = d
   call show
   sleep 0.5
.
proc hanoi n src dst aux . .
   if n >= 1
      call hanoi n - 1 src aux dst
      call move_disc src dst
      call hanoi n - 1 aux dst src
   .
.
call init
call show
call hanoi ndisc 1 2 3

* Maze

+ Generate and solve a maze using recursive depth-first search (DFS).

size = 15
n = 2 * size + 1
f = 100 / (n - 0.5)
len m[] n * n
# 
background 000
proc show_maze . .
   clear
   for i = 1 to len m[]
      if m[i] = 0
         x = (i - 1) mod n
         y = (i - 1) div n
         color 999
         move x * f - f / 2 y * f - f / 2
         rect f * 1.5 f * 1.5
      .
   .
   sleep 0.01
.
offs[] = [ 1 n -1 (-n) ]
proc m_maze pos . .
   m[pos] = 0
   call show_maze
   d[] = [ 1 2 3 4 ]
   for i = 4 downto 1
      d = random i
      dir = offs[d[d]]
      d[d] = d[i]
      if m[pos + dir] = 1 and m[pos + 2 * dir] = 1
         m[pos + dir] = 0
         call m_maze pos + 2 * dir
      .
   .
.
endpos = n * n - 1
proc make_maze . .
   for i = 1 to len m[]
      m[i] = 1
   .
   for i = 1 to n
      m[i] = 2
      m[n * i] = 2
      m[n * i - n + 1] = 2
      m[n * n - n + i] = 2
   .
   h = 2 * random 15 - n + n * 2 * random 15
   call m_maze h
   m[endpos] = 0
.
call make_maze
call show_maze
# 
proc mark pos col . .
   x = (pos - 1) mod n
   y = (pos - 1) div n
   color col
   move x * f + f / 4 y * f + f / 4
   circle f / 3.5
.
proc solve dir0 pos . found .
   call mark pos 900
   sleep 0.05
   if pos = endpos
      found = 1
      break 1
   .
   of = random 4 - 1
   for h = 1 to 4
      dir = (h + of) mod1 4
      posn = pos + offs[dir]
      if dir <> dir0 and m[posn] = 0 and found = 0
         call solve (dir + 1) mod 4 + 1 posn found
         if found = 0
            call mark posn 888
            sleep 0.08
         .
      .
   .
.
sleep 1
call solve 0 n + 2 found

* Eight queens puzzle

+ In the 8-queens problem you should place 8 queens on a chessboard, so that no two queens threaten each other. Two queens are therefore not allowed on the same row, column or diagonal.

+ This problem that can be solved using recursive backtracking. With backtracking you try to find a solution step by step. There are different paths with each step. If one step shows that the current path will not lead to a solution, go back to the previous step and choose another path.

# size of chessboard is 8x8
n = 8
# stores the position of the queen on row
len col[] n
# 
proc print_solution . .
  h$ = "┏"
  for i = 1 to n - 1
    h$ &= "━━━┳"
  .
  h$ &= "━━━┓"
  print h$
  h$ = "┣"
  for i = 1 to n - 1
    h$ &= "━━━╋"
  .
  h$ &= "━━━┫"
  for i = 1 to n
    s$ = "┃"
    for j = 1 to n
      if j = col[i]
        s$ &= " Q ┃"
      else
        s$ &= "   ┃"
      .
    .
    print s$
    if i = n
      h$ = "┗"
      for j = 1 to n - 1
        h$ &= "━━━┻"
      .
      h$ &= "━━━┛"
    .
    print h$
  .
  print ""
.
# 
proc is_save col row . save .
  save = 1
  for i = 1 to row - 1
    if col[i] = col or abs (col[i] - col) = abs (row - i)
      save = 0
      break 1
    .
  .
.
# 
print "First 3 solutions: "
print ""
n_solutions = 0
proc solve row . .
  if row > n
    n_solutions += 1
    if n_solutions <= 3
      call print_solution
    .
  else
    for col = 1 to n
      call is_save col row save
      if save = 1
        col[row] = col
        call solve row + 1
      .
    .
  .
.
call solve 1
print "Number of solutions: " & n_solutions

* Mutual recursion - parser

+ A recursiv top-down parser for an arithmetic expression. There we have a *mutual recursion* for the procedures *parse_expr* and *parse_factor*. To do this, we need to make a procedure known with a *forward declaration* before implementing it.

subr nch
  if inp_ind > len inp$[]
    ch$ = strchar 0
  else
    ch$ = inp$[inp_ind]
    inp_ind += 1
  .
  ch = strcode ch$
.
# 
subr ntok
  if ch = 0
    tok$ = "eof"
  else
    while ch$ = " "
      call nch
    .
    if ch >= 48 and ch <= 58
      tok$ = "numb"
      s$ = ""
      while ch >= 48 and ch <= 58 or ch$ = "."
        s$ &= ch$
        call nch
      .
      tokv = number s$
    else
      tok$ = ch$
      call nch
    .
  .
.
procdecl parse_expr . res .
# 
proc parse_factor . res .
  if tok$ = "numb"
    write tokv
    res = tokv
    call ntok
  elif tok$ = "("
    write tok$
    call ntok
    call parse_expr res
    if tok$ <> ")"
      print "error"
    .
    write tok$
    call ntok
  .
.
proc parse_term . res .
  call parse_factor res
  while tok$ = "*" or tok$ = "/"
    write " " & tok$ & " "
    t$ = tok$
    call ntok
    call parse_factor r
    if t$ = "*"
      res *= r
    else
      res /= r
    .
  .
.
proc parse_expr . res .
  call parse_term res
  while tok$ = "+" or tok$ = "-"
    write " " & tok$ & " "
    t$ = tok$
    call ntok
    call parse_term r
    if t$ = "+"
      res += r
    else
      res -= r
    .
  .
.
proc parse s$ . res .
  inp$[] = strchars s$
  inp_ind = 1
  call nch
  call ntok
  call parse_expr res
.
repeat
  inp$ = input
  until inp$ = ""
  call parse inp$ res
  print " = " & res
.
input_data
4 * 6
4.2 * ((5.3+8)*3 + 4)
2.5 + 2 * 3.14 
`

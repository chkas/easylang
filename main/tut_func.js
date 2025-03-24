txt_tutor = String.raw`+ Functions and recursion

-

+ Procedures are defined with *proc*. The syntax of a procedure definition is: *proc <proc_name> <value parameters> . <reference parameters> .*

+ Variables that occur for the first time within a procedure are local to that procedure. Global variables declared above can be accessed.

proc gcd a b . res .
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   res = a
.
gcd 120 35 r
print r

+ *a*, *b* are value parameters, *res* is a reference (or inout) parameter and *h* is a local variable.

-

+ Functions are defined with *func*. Only value parameters are allowed. *return* exits the function and returns the specified value.

func gcd a b.
   while b <> 0
      h = b
      b = a mod b
      a = h
   .
   return a
.
print gcd 120 35

-

+ *func$* indicates a string return.

func$ tolower s$ .
   for c$ in strchars s$
      c = strcode c$
      if c >= 65 and c <= 91
         c += 32
      .
      r$ &= strchar c
   .
   return r$
.
print tolower "Hello World"

* Recursive functions and procedures

+ The factorial of a number *n* is the product of numbers from *1* to *n*: *n! = n ** (n - 1) ** . . . ** 2 ** 1*

+ This can be easily calculated

func fact n .
   res = 1
   while n > 1
      res = res * n
      n -= 1
   .
   return res
.
print fact 6

+ The factorial can be defined recursively: *n! = n ** (n - 1)!* and *1! = 1*

+ It can also be calculated recursively

func fact n .
   if n = 1
      return 1
   .
   return n * fact (n - 1)
.
print fact 6

+ The function is called within the function. Each calling instance requires a new set of local variables and parameters. This and the return address are stored on the stack. The recursion depth is limited.

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
      tree x y angle - 20 depth - 1
      tree x y angle + 20 depth - 1
   .
.
tree 50 5 90 10

* Quicksort

proc qsort left right . d[] .
   if left >= right
      return
   .
   mid = left
   for i = left + 1 to right
      if d[i] < d[left]
         mid += 1
         swap d[i] d[mid]
      .
   .
   swap d[left] d[mid]
   qsort left mid - 1 d[]
   qsort mid + 1 right d[]
.
for i = 1 to 100
   d[] &= random 1000
.
qsort 1 len d[] d[]
print d[]

* Tower of Hanoi

+ There are three places and some discs of different sizes. The discs are in first place in ascending size. They must be reallocated to second place.  The third place can be used. Only one disc can be moved at a time. The discs must be taken from above and placed on top of the target, whereby the disc underneath must be larger.

+ The problem can be solved recursively: To move *n* discs to the target place, move *n-1* discs to the auxiliary place, then give the lowest disc to the target and then move the *n-1* discs from the auxiliary place to the target place.

ndisc = 5
len tow[][] 3
textsize 7
proc init . .
   for i = ndisc downto 1
      tow[1][] &= i
   .
.
proc show . .
   clear
   color 444
   move 0 0
   rect 100 10
   for t = 1 to 3
      linewidth 3
      color 444
      x = 32 * t - 14
      move x 12 + ndisc * 6
      line x 10
      move x - 2 2
      color 998
      text t
      linewidth 6
      for i = 1 to len tow[t][]
         d = tow[t][i]
         color 210 + (d - 1) * 111
         sz = 26 * d / ndisc
         x = t * 32 - 14 - sz / 2
         y = 7 + i * 6
         move x y
         line x + sz y
      .
   .
.
proc movedisc src dst . .
   print "move " & src & " to " & dst
   sleep 0.5
   last = len tow[src][]
   tow[dst][] &= tow[src][last]
   len tow[src][] -1
   show
   sleep 0.5
.
proc hanoi n src dst aux . .
   if n = 0
      return
   .
   hanoi n - 1 src aux dst
   movedisc src dst
   hanoi n - 1 aux dst src
.
init
show
hanoi ndisc 1 2 3

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
   show_maze
   d[] = [ 1 2 3 4 ]
   for i = 4 downto 1
      d = random i
      dir = offs[d[d]]
      d[d] = d[i]
      if m[pos + dir] = 1 and m[pos + 2 * dir] = 1
         m[pos + dir] = 0
         m_maze pos + 2 * dir
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
   m_maze h
   m[endpos] = 0
.
make_maze
show_maze
#
proc mark pos col . .
   x = (pos - 1) mod n
   y = (pos - 1) div n
   color col
   move x * f + f / 4 y * f + f / 4
   circle f / 3.5
.
found = 0
proc solve dir0 pos . .
   if found = 1
      return
   .
   mark pos 900
   sleep 0.05
   if pos = endpos
      found = 1
      return
   .
   of = random 4 - 1
   for h = 1 to 4
      dir = (h + of) mod1 4
      posn = pos + offs[dir]
      if dir <> dir0 and m[posn] = 0
         solve (dir + 1) mod 4 + 1 posn
         if found = 0
            mark posn 888
            sleep 0.08
         .
      .
   .
.
sleep 1
solve 0 n + 2

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
func is_save col row .
   for i = 1 to row - 1
      if col[i] = col or abs (col[i] - col) = abs (row - i)
         return 0
      .
   .
   return 1
.
#
print "First 3 solutions: "
print ""
n_solutions = 0
proc solve row . .
   if row > n
      n_solutions += 1
      if n_solutions <= 3
         print_solution
      .
   else
      for col = 1 to n
         if is_save col row = 1
            col[row] = col
            solve row + 1
         .
      .
   .
.
solve 1
print "Number of solutions: " & n_solutions

* Mutual recursion - parser

+ A recursiv top-down parser for an arithmetic expression. There we have a *mutual recursion* for the functions *eval_expr* and *eval_factor*. To do this, we need to make a functions known with a *forward declaration* before implementing it.

subr nextch
   if inp_ind > len inp$[]
      ch$ = strchar 0
   else
      ch$ = inp$[inp_ind]
      inp_ind += 1
   .
   ch = strcode ch$
.
#
subr nexttok
   if ch = 0
      tok$ = "eof"
      return
   .
   while ch$ = " " : nextch
   if ch >= 48 and ch <= 58
      tok$ = "numb"
      s$ = ""
      while ch >= 48 and ch <= 58 or ch$ = "."
         s$ &= ch$
         nextch
      .
      tokv = number s$
   else
      tok$ = ch$
      nextch
   .
.
funcdecl eval_expr .
#
func eval_factor .
   if tok$ = "numb"
      write tokv
      res = tokv
      nexttok
   elif tok$ = "("
      write tok$
      nexttok
      res = eval_expr
      if tok$ <> ")" : print "error"
      write tok$
      nexttok
   .
   return res
.
func eval_term .
   res = eval_factor
   while tok$ = "*" or tok$ = "/"
      write " " & tok$ & " "
      t$ = tok$
      nexttok
      r = eval_factor
      if t$ = "*"
         res *= r
      else
         res /= r
      .
   .
   return res
.
func eval_expr .
   res = eval_term
   while tok$ = "+" or tok$ = "-"
      write " " & tok$ & " "
      t$ = tok$
      nexttok
      r = eval_term
      if t$ = "+"
         res += r
      else
         res -= r
      .
   .
   return res
.
func eval s$ .
   inp$[] = strchars s$
   inp_ind = 1
   nextch
   nexttok
   return eval_expr
.
repeat
   inp$ = input
   until inp$ = ""
   print " = " & eval inp$
.
input_data
4 * 6
4.2 * ((5.3+8)*3 + 4)
2.5 + 2 * 3.14
`

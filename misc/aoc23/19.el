 # AoC-23 - Day 19: Aplenty
#
global name$[] rule[][] set[] start .
#
func n2id n$ .
   if n$ = "A" : return 0
   if n$ = "R" : return -1
   for id to len name$[]
      if name$[id] = n$ : return id
   .
   name$[] &= n$
   rule[][] &= [ ]
   return id
.
#
proc read .
   start = n2id "in"
   repeat
      s$ = input
      until s$ = ""
      s$[] = strtok s$ "{}:,"
      id = n2id s$[1]
      #
      for i = 2 step 2 to len s$[] - 2
         if substr s$[i] 1 1 = "x"
            cat = 1
         elif substr s$[i] 1 1 = "m"
            cat = 2
         elif substr s$[i] 1 1 = "a"
            cat = 3
         else
            cat = 4
         .
         n = number substr s$[i] 3 9
         if substr s$[i] 2 1 = "<"
            n = -n
         .
         dest = n2id s$[i + 1]
         rule[id][] &= cat
         rule[id][] &= n
         rule[id][] &= dest
      .
      rule[id][] &= n2id s$[len s$[]]
   .
.
read
#
func solve1 r .
   if r = 0 : return 1
   if r = -1 : return 0
   ln = len rule[r][]
   for i = 1 step 3 to ln - 3
      catv = set[rule[r][i]]
      n = rule[r][i + 1]
      if n < 0 : catv = -catv
      if catv > n : return solve1 rule[r][i + 2]
   .
   return solve1 rule[r][ln]
.
proc part1 .
   repeat
      s$ = input
      until s$ = ""
      set[] = number strsplit s$ "="
      if solve1 start = 1
         for s in set[] : sum += s
      .
   .
   print sum
.
part1
#
func solve r a[] b[] .
   if r = 0
      s = 1
      for i to 4
         s *= b[i] - a[i] + 1
      .
      return s
   .
   if r = -1
      return 0
   .
   ln = len rule[r][]
   for i = 1 step 3 to ln - 3
      cat = rule[r][i]
      a = a[cat]
      b = b[cat]
      n = rule[r][i + 1]
      rn = rule[r][i + 2]
      if n > 0
         if a > n
            return res + solve rn a[] b[]
         elif b > n
            a[cat] = n + 1
            res += solve rn a[] b[]
            a[cat] = a
            b[cat] = n
         .
      else
         n = -n
         if b < n
            return res + solve rn a[] b[]
         elif a < n
            b[cat] = n - 1
            res += solve rn a[] b[]
            a[cat] = n
            b[cat] = b
         .
      .
   .
   return res + solve rule[r][ln] a[] b[]
.
print solve start [ 1 1 1 1 ] [ 4000 4000 4000 4000 ]
#
input_data
px{a<2006:qkq,m>2090:A,rfg}
pv{a>1716:R,A}
lnx{m>1548:A,A}
rfg{s<537:gd,x>2440:R,A}
qs{s>3448:A,lnx}
qkq{x<1416:A,crn}
crn{x>2662:A,R}
in{s<1351:px,qqz}
qqz{s>2770:qs,m<1801:hdj,R}
gd{a>3333:R,R}
hdj{m>838:A,pv}

{x=787,m=2655,a=1222,s=2876}
{x=1679,m=44,a=2067,s=496}
{x=2036,m=264,a=79,s=2244}
{x=2461,m=1339,a=466,s=291}
{x=2127,m=1623,a=2188,s=1013}


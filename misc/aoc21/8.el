# AoC-21 - Day 8: Seven Segment Search
#
# "Simple" brute force strategy, which
# tries all possible connections
# (permutations) until all displays show
# a digit.
#
sysconf topleft
visual = 1
#
gbackground 000
gclear
proc draw x y cod .
   if visual = 0 : return
   d = 2.8
   s = 0.5
   glinewidth s * 6 / 5
   x1[] = [ x + s x x x + d - s x + d x + d x + s ]
   y1[] = [ y + d y + d - s y + d + d - s y + d + d y + d + s y + s y ]
   x2[] = [ x + d - s x x x + s x + d x + d x + d - s ]
   y2[] = [ y + d y + s y + d + s y + d + d y + d + d - s y + d - s y ]
   gcolor 000
   grect x - 2 y - 2 6 10
   gcolor 900
   for i = 1 to 7
      if bitand cod bitshift 1 (7 - i) > 0
         gline x1[i] y1[i] x2[i] y2[i]
      .
   .
   sleep 0.001
.
#
perm[] = [ 0 1 2 3 4 5 6 ]
global permlist[][] .
proc permutate_list k .
   for i = k to len perm[]
      swap perm[i] perm[k]
      permutate_list k + 1
      swap perm[k] perm[i]
   .
   if k = len perm[]
      permlist[][] &= perm[]
   .
.
permutate_list 1
#
func codeperm perm s$ .
   for c$ in strchars s$
      cod += bitshift 1 permlist[perm][strcode c$ - 97 + 1]
   .
   return cod
.
len digit[] 128
arrbase digit[] 0
#
proc init .
   for i range0 128 : digit[i] = -1
   s$[] = strsplit "abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcdfg" " "
   for i = 0 to 9
      cod = codeperm 1 s$[i + 1]
      digit[cod] = i
   .
.
init
#
global inp$ part1 part2 linenr .
proc procline .
   inp$[] = strtok inp$ " "
   for perm = 1 to len permlist[][]
      for nr = 1 to 10
         cod = codeperm perm inp$[nr]
         if linenr < 10
            draw nr * 6 - 4 linenr * 10 + 2 cod
         .
         if digit[cod] = -1 : break 1
      .
      if nr = 11
         val = 0
         for nr = 12 to 15
            cod = codeperm perm inp$[nr]
            if linenr < 10
               draw nr * 6 - 4 linenr * 10 + 2 cod
            .
            dig = digit[cod]
            val = val * 10 + dig
            if dig = 1 or dig = 4 or dig = 7 or dig = 8
               part1 += 1
            .
         .
         part2 += val
         linenr += 1
         return
      .
   .
   print "no match"
.
repeat
   inp$ = input
   until inp$ = ""
   procline
.
print part1
print part2
#
input_data
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce

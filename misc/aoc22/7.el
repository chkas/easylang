# AoC-22 - Day 7: No Space Left On Device
# 
global l[] .
# 
proc traverse . sum .
   sum = 0
   s$ = input
   repeat
      s$ = input
      until s$ = "$ cd .." or s$ = ""
      s$[] = strsplit s$ " "
      if s$[1] = "$" and s$[2] = "cd"
         traverse s
         sum += s
      elif s$[1] <> "dir"
         sum += number s$[1]
      .
   .
   l[] &= sum
.
traverse sum
free = 70000000 - sum
tofree = 30000000 - free
# 
min = 1 / 0
for s in l[]
   if s <= 100000
      part1 += s
   .
   if s >= tofree
      min = lower min s
   .
.
print part1
print min
# 
input_data
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k



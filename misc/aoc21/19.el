# AoC-21 - Day 19: Beacon Scanner
# 
# For each scanner position, convert the
# relative beacon positions to scalars and
# store them in a hash map that also stores
# the beacon. Then all scanners are tested.
# If there are enough matches in one of the
# 24 rotation positions (using the hashmap)
# then the beacons without matches are 
# added to scanner 0. 
# 
hashsz = 199999
len hashind[] hashsz
len hashv[] hashsz
# 
proc hashget ind . val .
   hi = ind mod hashsz + 1
   repeat
      if hashind[hi] = ind
         val = hashv[hi]
         break 2
      .
      until hashind[hi] = 0
      hi = hi mod hashsz + 1
   .
   val = -1
.
proc hashset ind val . .
   hi = ind mod hashsz + 1
   while hashind[hi] <> 0
      hi = hi mod hashsz + 1
   .
   hashind[hi] = ind
   hashv[hi] = val
.
# 
global c0[][] .
repeat
   s$ = input
   until s$ = ""
   scan$[][] &= [ ]
   repeat
      s$ = input
      until s$ = ""
      scan$[len scan$[][]][] &= s$
   .
.
len scan[][] len scan$[][]
scan[1][] = [ 0 0 0 ]
# 
global c[][] .
proc load id . .
   len c[][] 0
   for i to len scan$[id][]
      c[][] &= number strsplit scan$[id][i] ","
   .
.
proc rotall p[] s[] . .
   len c[] 3
   for i to len c[][]
      swap c[] c[i][]
      for d to 3
         c[i][d] = c[p[d]] * s[d]
      .
   .
.
global sca .
proc test . found .
   len beacon[] 100
   found = 0
   cnt = 0
   for k to len c[][]
      for l to len c[][]
         if k <> l
            hind = 100000000 * (c[k][1] - c[l][1]) + 10000 * (c[k][2] - c[l][2]) + c[k][3] - c[l][3]
            call hashget hind i
            if i <> -1
               beacon[k] = 1
               cnt += 1
               if cnt >= 12
                  ind0 = i
                  ind = k
                  found = 1
               .
            .
         .
      .
   .
   if found = 1
      dx = c0[ind0][1] - c[ind][1]
      dy = c0[ind0][2] - c[ind][2]
      dz = c0[ind0][3] - c[ind][3]
      scan[sca][] = [ dx dy dz ]
      for i to len c[][]
         if beacon[i] = 0
            swap c[i][] h[]
            h[1] += dx
            h[2] += dy
            h[3] += dz
            c0[][] &= h[]
         .
      .
   .
.
global todo[] .
# 
proc hashset_relpos . .
   hashind[] = [ ]
   len hashind[] hashsz
   for i to len c0[][]
      for j to len c0[][]
         if i <> j
            hind = 100000000 * (c0[i][1] - c0[j][1]) + 10000 * (c0[i][2] - c0[j][2]) + c0[i][3] - c0[j][3]
            call hashset hind i
         .
      .
   .
.
proc all_rotations . .
   for ry to 2
      for rz to 3
         for rx to 4
            call rotall [ 1 3 2 ] [ 1 -1 1 ]
            call test found
            if found = 1
               break 4
            .
         .
         if ry = 2 and rz = 1
            call rotall [ 1 2 3 ] [ -1 -1 1 ]
         elif ry = 2 and rz = 2
            call rotall [ 3 1 2 ] [ 1 -1 -1 ]
         else
            call rotall [ 2 1 3 ] [ 1 -1 1 ]
         .
      .
      call rotall [ 3 2 1 ] [ -1 1 1 ]
   .
   todo[] &= sca
.
# 
proc part1 . .
   call load 1
   swap c0[][] c[][]
   # 
   for sca = 2 to len scan$[][]
      todo[] &= sca
   .
   while len todo[] > 0
      swap todo0[] todo[]
      len todo[] 0
      for sca in todo0[]
         call load sca
         call hashset_relpos
         call all_rotations
      .
   .
   print len c0[][]
.
call part1
# 
# part two 
# 
proc part2 . .
   for i to len scan[][]
      for j = i + 1 to len scan[][]
         dist = 0
         for d to 3
            dist += abs (scan[i][d] - scan[j][d])
         .
         max = higher dist max
      .
   .
   print max
.
call part2
# 
input_data
--- scanner 0 ---
404,-588,-901
528,-643,409
-838,591,734
390,-675,-793
-537,-823,-458
-485,-357,347
-345,-311,381
-661,-816,-575
-876,649,763
-618,-824,-621
553,345,-567
474,580,667
-447,-329,318
-584,868,-557
544,-627,-890
564,392,-477
455,729,728
-892,524,684
-689,845,-530
423,-701,434
7,-33,-71
630,319,-379
443,580,662
-789,900,-551
459,-707,401

--- scanner 1 ---
686,422,578
605,423,415
515,917,-361
-336,658,858
95,138,22
-476,619,847
-340,-569,-846
567,-361,727
-460,603,-452
669,-402,600
729,430,532
-500,-761,534
-322,571,750
-466,-666,-811
-429,-592,574
-355,545,-477
703,-491,-529
-328,-685,520
413,935,-424
-391,539,-444
586,-435,557
-364,-763,-893
807,-499,-711
755,-354,-619
553,889,-390

--- scanner 2 ---
649,640,665
682,-795,504
-784,533,-524
-644,584,-595
-588,-843,648
-30,6,44
-674,560,763
500,723,-460
609,671,-379
-555,-800,653
-675,-892,-343
697,-426,-610
578,704,681
493,664,-388
-671,-858,530
-667,343,800
571,-461,-707
-138,-166,112
-889,563,-600
646,-828,498
640,759,510
-630,509,768
-681,-892,-333
673,-379,-804
-742,-814,-386
577,-820,562

--- scanner 3 ---
-589,542,597
605,-692,669
-500,565,-823
-660,373,557
-458,-679,-417
-488,449,543
-626,468,-788
338,-750,-386
528,-832,-391
562,-778,733
-938,-730,414
543,643,-506
-524,371,-870
407,773,750
-104,29,83
378,-903,-323
-778,-728,485
426,699,580
-438,-605,-362
-469,-447,-387
509,732,623
647,635,-688
-868,-804,481
614,-800,639
595,780,-596

--- scanner 4 ---
727,592,562
-293,-554,779
441,611,-461
-714,465,-776
-743,427,-804
-660,-479,-426
832,-632,460
927,-485,-438
408,393,-506
466,436,-512
110,16,151
-258,-428,682
-393,719,612
-211,-452,876
808,-476,-593
-575,615,604
-485,667,467
-680,325,-822
-627,-443,-432
872,-547,-609
833,512,582
807,604,487
839,-516,451
891,-625,532
-652,-548,-490
30,-46,-14



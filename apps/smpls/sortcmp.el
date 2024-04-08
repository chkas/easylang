proc sort n$ . d[] .
   if n$ = "Selection sort"
      for i = 1 to len d[] - 1
         for j = i + 1 to len d[]
            if d[j] < d[i]
               swap d[j] d[i]
            .
         .
      .
   elif n$ = "Heapsort"
      n = len d[]
      # make heap
      for i = 2 to n
         if d[i] > d[(i + 1) div 2]
            j = i
            repeat
               h = (j + 1) div 2
               until d[j] <= d[h]
               swap d[j] d[h]
               j = h
            .
         .
      .
      for i = n downto 2
         swap d[1] d[i]
         j = 1
         ind = 2
         while ind < i
            if ind + 1 < i and d[ind + 1] > d[ind]
               ind += 1
            .
            if d[j] < d[ind]
               swap d[j] d[ind]
            .
            j = ind
            ind = 2 * j
         .
      .
   elif n$ = "Quicksort"
      len stack[] 64
      sp = 1
      # this is sufficient to sort 4 billion numbers
      left = 1
      right = len d[]
      while 1 = 1
         if left < right
            #  partition
            swap d[left + randint (right - left)] d[left]
            piv = d[left]
            mid = left
            for i = left + 1 to right
               if d[i] < piv
                  mid += 1
                  swap d[i] d[mid]
               .
            .
            swap d[left] d[mid]
            #
            if mid < (right + left) / 2
               stack[sp] = mid + 1
               stack[sp + 1] = right
               right = mid - 1
            else
               stack[sp] = left
               stack[sp + 1] = mid - 1
               left = mid + 1
            .
            sp += 2
         elif sp > 2
            sp -= 2
            left = stack[sp]
            right = stack[sp + 1]
         else
            # finished
            break 1
         .
      .
   .
.
ty = 92
proc time_test n$ col . .
   color col
   move 4 ty
   ty -= 6
   text n$
   print "--- " & n$ & " ---"
   write "Length" & strchar 9 & "Time"
   move 0 0
   for r to 10
      len d[] len d[] + 2000
      for i = 1 to len d[]
         # d[i] = 1
         # d[i] = randint 1000000 - 1
         d[i] = randint 10000
      .
      write strchar 10 & len d[]
      t = systime
      sort n$ d[]
      h = systime - t
      write strchar 9 & systime - t
      line r * 10 h * 50
      sleep 0
   .
   print "\n"
.
drawgrid
numfmt 3 0
linewidth 0.5
textsize 4
# time_test "Selection sort" 900 1
time_test "Heapsort" 090
time_test "Quicksort" 009
#

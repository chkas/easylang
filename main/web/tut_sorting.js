txt_tutor=`+ Sorting algorithms

-

* Selection sort - easy to understand

+ Find the minimum value and place it to the left side of the array. Repeat this process each time, except for the leftmost element, until there is only one item left.

print "Selection sort"
print ""
func sort . d[] .
  for i = 0 to len d[] - 2
    for j = i + 1 to len d[] - 1
      if d[j] < d[i]
        swap d[j] d[i]
      .
    .
  .
.
func test . .
  d[] = [ 29 4 72 44 55 26 27 77 92 5 ]
  call sort d[]
  print d[]
  print ""
.
func time_test . .
  len d[] 50
  write "Length" & strchar 9 & "Time"
  for test range 3
    for i range len d[]
      d[i] = random 1000000
    .
    write strchar 10 & len d[]
    t = systime
    call sort d[]
    write strchar 9 & systime - t
    len d[] 10 * len d[]
  .
.
call test
call time_test

* Insertion sort - fast for small arrays

+ It is usually faster than *Selection sort*, depending on the hardware and software. It works like this: go through the array and keep the left side sorted. Move the current element to the left until it is in the correct position.

print "Insertion sort"
print ""
func sort . d[] .
  for i = 1 to len d[] - 1
    h = d[i]
    j = i - 1
    while j >= 0 and h < d[j]
      d[j + 1] = d[j]
      j -= 1
    .
    d[j + 1] = h
  .
.
func time_test . .
  len d[] 50
  write "Length" & strchar 9 & "Time"
  for test range 3
    for i range len d[]
      d[i] = random 1000000
    .
    write strchar 10 & len d[]
    t = systime
    call sort d[]
    write strchar 9 & systime - t
    len d[] 10 * len d[]
  .
.
call time_test

* Heapsort - fast for larger arrays

+ *Heapsort* is much faster than *Insertion sort* for larger arrays. It can be considered a much better variant of *Selection sort*: Each round, the maximum value is moved to the right side and the len of the array is reduced by one. The big improvement is that the maximum value is selected very quickly - this is achieved by keeping the left part in a *heap* structure. 

+ In a *heap*, each node has two children smaller than the node. In an array where the node is at *i*, the left child is at *2i+1* and the right child at *2i+2*. The first sorting step is: convert the array into a *heap* array. The maximum value in a *heap* is always at *0*. If you move the maximum value into the sorted part of the array, the left side of the array must be converted to a *heap* again. This can be done quickly.

print "Heapsort"
print ""
func sort . d[] .
  n = len d[]
  # make heap
  for i = 1 to n - 1
    if d[i] > d[(i - 1) / 2]
      j = i
      while d[j] > d[(j - 1) / 2]
        swap d[j] d[(j - 1) / 2]
        j = (j - 1) / 2
      .
    .
  .
  for i = n - 1 downto 1
    swap d[0] d[i]
    j = 0
    ind = 1
    while ind < i
      if ind + 1 < i and d[ind + 1] > d[ind]
        ind += 1
      .
      if d[j] < d[ind]
        swap d[j] d[ind]
      .
      j = ind
      ind = 2 * j + 1
    .
  .
.
func time_test . .
  len d[] 500
  write "Length" & strchar 9 & "Time"
  for test range 3
    for i range len d[]
      d[i] = random 1000000
    .
    write strchar 10 & len d[]
    t = systime
    call sort d[]
    write strchar 9 & systime - t
    len d[] 10 * len d[]
  .
.
call time_test

* Mergesort - fast but needs space

+ The speed of *Mergesort* is similar to *Heapsort*, but takes up much more space. This is how it works: imagine you have a stack of numbered cards to sort. The *Mergesort* method is: take two cards each and merge them into stacks of 2 cards. Then take two 2-card stacks and merge them into sorted 4-card stacks, and so on.

+ The *merge* subroutine merges two sorted subarrays into one sorted array. First the two subarrays are copied to a temporary location, then the temporary subarrays are scanned, with the lower element selected at each step and placed into the original array. 

+ The *sort* subroutine turns many small arrays, starting with size one, into larger arrays by merging two of each into one until a single array is created.

print "Mergesort"
print ""
func sort . d[] .
  len tmp[] len d[]
  sz = 1
  while sz < len d[]
    swap tmp[] d[]
    left = 0
    while left < len d[]
      # merge
      mid = left + sz
      if mid > len d[]
        mid = len d[]
      .
      right = mid + sz
      if right > len d[]
        right = len d[]
      .
      l = left
      r = mid
      for i = left to right - 1
        if r = right or l < mid and tmp[l] < tmp[r]
          d[i] = tmp[l]
          l += 1
        else
          d[i] = tmp[r]
          r += 1
        .
      .
      left += sz + sz
    .
    sz += sz
  .
.
func time_test . .
  len d[] 5000
  write "Length" & strchar 9 & "Time"
  for test range 3
    for i range len d[]
      d[i] = random 1000000
    .
    write strchar 10 & len d[]
    t = systime
    call sort d[]
    write strchar 9 & systime - t
    len d[] 10 * len d[]
  .
.
call time_test

* Quicksort - normally the fastest comparsion sort

+ *Quicksort* is even quicker than *Mergesort* and does not take up much space. It's not that complicated: imagine you have a stack of 200 numbered cards to sort. The *quicksort* method is: split the cards by placing the cards from 1 to 100 on one stack and the others on a second stack. Then you only have to sort stacks of 100 cards, which is easier. To do this, the 100 card stacks are divided into two stacks of 50 cards each, and so on.

+ At first a subarray is divided  with one element as comparison element - the so-called pivot element - into two subarrays. Lower numbers go to the left side and higher numbers to the right side. The pivot element comes in between.

+ The *sort* subroutine does this *partitioning* for all unsorted subarrays, these are listed in the *stack* to-do list. The larger larger of the two created subarray is added in the to-do list and sorting is continued with the smaller subarray. If the to-do list is empty, the job is done and the whole array is sorted.

print "Quicksort"
print ""
func sort . d[] .
  len stack[] 64
  # this is sufficient to sort 4 billion numbers
  left = 0
  right = len d[] - 1
  while left <> -1
    if left < right
      #  partition
      swap d[left + random (right - left)] d[left]
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
    elif sp > 0
      sp -= 2
      left = stack[sp]
      right = stack[sp + 1]
    else
      # finished
      left = -1
    .
  .
.
func time_test . .
  len d[] 5000
  write "Length" & strchar 9 & "Time"
  for test range 3
    for i range len d[]
      d[i] = random 1000000
    .
    write strchar 10 & len d[]
    t = systime
    call sort d[]
    write strchar 9 & systime - t
    len d[] 10 * len d[]
  .
.
call time_test

+ *Quicksort* is very fast - but for small arrays *Insertion sort* is faster. Combining these two sorting algorithms can make it even faster.

* Radix sort - a non-comparison sort

+ *Radix sort* works best with positive integers. 

+ First, the data is divided into buckets, with one bucket available for each digit (for *radix* 10). In the first pass, for example, the number 416 is placed in box 6. The numbers are then collected from the buckets and placed on a stack. At the next pass the same will be repeated with the tens, etc.

+ The runtime behavior increases only linearly with the number of elements. The bigger you make the *radix*, the faster it gets, but also the more space you need. Note that for each sorting bucket, the maximum size would be the size of the data, so it makes sense to let the bucket grow dynamically.

print "Radix sort"
print ""
func sort . d[] .
  # radix = 10
  radix = 256
  max = 0
  for di range len d[]
    if d[di] > max
      max = d[di]
    .
  .
  len buck[][] radix
  pos = 1
  while pos <= max
    for i range radix
      len buck[i][] 0
    .
    for di range len d[]
      h = d[di] / pos mod radix
      buck[h][] &= d[di]
    .
    di = 0
    for i range radix
      for j range len buck[i][]
        d[di] = buck[i][j]
        di += 1
      .
    .
    pos *= radix
  .
.
func time_test . .
  len d[] 5000
  write "Length" & strchar 9 & "Time"
  for test range 3
    for i range len d[]
      d[i] = random 1000000
    .
    write strchar 10 & len d[]
    t = systime
    call sort d[]
    write strchar 9 & systime - t
    len d[] 10 * len d[]
  .
.
call time_test

* Comparison

+ We see that with *Selection sort* and *Insertion sort* the required time increases in square order - 10 times more items result in about 100 times more time. This makes these sorting algorithms unusable for large arrays.

+ With *Heapsort* and *Mergesort* the time increases only by *n log(n)*. *Heapsort* and *Mergesort* take about the same time. *Heapsort* requires less memory, *Mergesort* can be better parallelized.

+ *Quicksort* has on average the same behavior in time but is usually faster. Even faster in combination with *Insertion sort*. With random selection of the pivot element, the worst case of the runtime - the growth of time with a square order - is so unlikely that it can be neglected.

+ *Radix sort* is a special case because it works "only" with positive integers or something that can be easily mapped to it. It is very fast and takes up space.

* Appendix: Quicksort recursive - watch the stack

+ The following *Quicksort* variant is recursive. The code looks clean and is fast. But there is a dangerous thing: the *stack* and its limited size. The stack size is different on different operating systems. For embedded systems, it may be very small.

func qsort left right . d[] .
  if left < right
    # partition 
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
    call qsort left mid - 1 d[]
    call qsort mid + 1 right d[]
  .
.
subr sort
  call qsort 0 len d[] - 1 d[]
.
#
d[] = [ 29 4 72 44 55 26 27 77 92 5 ]
call sort
print d[]

+ With the previous iterative variant and the reserved space for the uncompleted tasks we could make sure we were able to sort an array of a certain size. This is not possible with this recursive version - with a long list and "first element is pivot"  we get probably a stack overflow.

+ With *tail call elimination* and ensuring that the smaller subarray is sorted first, we can also make the recursive variant *stack safe*. With bad input we then get "only" the worst-case time complexity.

func qsort left right . d[] .
  while left < right
    # partition 
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
      call qsort left mid - 1 d[]
      left = mid + 1
    else
      call qsort mid + 1 right d[]
      right = mid - 1
    .
  .
.
subr sort
  call qsort 0 len d[] - 1 d[]
.
d[] = [ 29 4 72 44 55 26 27 77 92 5 ]
call sort
print d[]
`


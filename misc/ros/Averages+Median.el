proc quickselect k . list[] res .
   # 
   subr partition
      mid = left
      for i = left + 1 to right
         if list[i] < list[left]
            mid += 1
            swap list[i] list[mid]
         .
      .
      swap list[left] list[mid]
   .
   left = 1
   right = len list[]
   while left < right
      partition
      if mid < k
         left = mid + 1
      elif mid > k
         right = mid - 1
      else
         left = right
      .
   .
   res = list[k]
.
proc median . list[] res .
   h = len list[] div 2 + 1
   quickselect h list[] res
   if len list[] mod 2 = 0
      quickselect h - 1 list[] h
      res = (res + h) / 2
   .
.
test[] = [ 4.1 5.6 7.2 1.7 9.3 4.4 3.2 ]
median test[] med
print med
test[] = [ 4.1 7.2 1.7 9.3 4.4 3.2 ]
median test[] med
print med

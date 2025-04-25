proc roundrobin n .
   numfmt 0 2
   print n & " players"
   for i to n
      arr[] &= i
   .
   if n mod 2 = 1
      n += 1
      arr[] &= 0
   .
   for i = 1 to n - 1
      print ""
      write "round " & i & ": "
      for j = 1 to n / 2
         write arr[j] & "  "
      .
      print ""
      write "          "
      for j = n downto n / 2 + 1
         write arr[j] & "  "
      .
      print ""
      h = arr[n]
      for j = n downto 3
         arr[j] = arr[j - 1]
      .
      arr[2] = h
   .
.
roundrobin 12

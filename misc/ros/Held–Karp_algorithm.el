sysconf zero_based
#
proc held_karp &dist[][] &min_cost &tour[] .
   n = len dist[][]
   nn = bitshift 1 n
   len dp[][] nn
   len parent[][] nn
   for mask range0 nn
      len dp[mask][] n
      len parent[mask][] n
      for j range0 n
         dp[mask][j] = 1 / 0
         parent[mask][j] = -1
      .
   .
   dp[1][0] = 0
   for mask = 1 to nn - 1 : if bitand mask 1 <> 0
      for j = 1 to n - 1 : if bitand mask bitshift 1 j <> 0
         prev_mask = bitxor mask bitshift 1 j
         for k range0 n
            if bitand prev_mask bitshift 1 k <> 0
               cost = dp[prev_mask][k] + dist[k][j]
               if cost < dp[mask][j]
                  dp[mask][j] = cost
                  parent[mask][j] = k
               .
            .
         .
      .
   .
   full_mask = nn - 1
   min_cost = 1 / 0
   last = 0
   for j = 1 to n - 1
      cost = dp[full_mask][j] + dist[j][0]
      if cost < min_cost
         min_cost = cost
         last = j
      .
   .
   tour[] = [ ]
   mask = full_mask
   curr = last
   while curr <> 0
      tour[] &= curr
      prev = parent[mask][curr]
      mask = bitxor mask bitshift 1 curr
      curr = prev
   .
   tour[] &= 0
   for i range0 len tour[] div 2 : swap tour[i] tour[$ - i - 1]
   tour[] &= 0
.
dist[][] = [ [ 0 2 9 10 ] [ 1 0 6 4 ] [ 15 7 0 8 ] [ 6 3 12 0 ] ]
held_karp dist[][] cost tour[]
print "Tour: " & tour[]
print "Cost: " & cost

size = 15
n = 2 * size + 1
f = 100 / (n - 0.5)
len m[] n * n
#
background 000
proc show_maze .
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
#
proc m_maze pos .
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
proc make_maze .
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
   endpos += n
.
make_maze
show_maze

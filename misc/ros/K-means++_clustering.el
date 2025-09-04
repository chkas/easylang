NPOINTS = 30000
NCLUSTERS = 6
MAXITER = 100
#
proc genpts npts &pts[][] .
   for i = 1 to npts
      ang = 360 * randomf
      r = 50 * randomf
      pts[][] &= [ r * cos ang, r * sin ang, 0 ]
   .
.
func dist2 a[] b[] .
   x = a[1] - b[1]
   y = a[2] - b[2]
   return x * x + y * y
.
func nearest pt[] &centroids[][] .
   min = 1 / 0
   for i to len centroids[][]
      d = dist2 centroids[i][] pt[]
      if d < min
         min = d
         cluster = i
      .
   .
   return cluster
.
proc kpp k &pts[][] &centroids[][] .
   npts = len pts[][]
   centroids[][] &= pts[random npts][]
   while len centroids[][] < k
      dists[] = [ ]
      total = 0
      for i to npts
         min = 1 / 0
         for j to len centroids[][]
            d = dist2 pts[i][] centroids[j][]
            min = lower d min
         .
         dists[] &= min
         total += min
      .
      threshold = total * randomf
      cumulative = 0
      for i to npts
         cumulative += dists[i]
         if cumulative >= threshold
            centroids[][] &= pts[i][]
            break 1
         .
      .
   .
   for i to npts : pts[i][3] = nearest pts[i][] centroids[][]
.
proc lloyd &pts[][] &centroids[][] nclusters maxiter .
   npts = len pts[][]
   acceptable = npts / 1000
   for i to npts : pts[i][3] = i mod1 nclusters
   kpp nclusters pts[][] centroids[][]
   repeat
      for i to nclusters : centroids[i][] = [ 0 0 0 ]
      for i to npts
         ind = pts[i][3]
         centroids[ind][3] += 1
         centroids[ind][1] += pts[i][1]
         centroids[ind][2] += pts[i][2]
      .
      for i to nclusters
         centroids[i][1] /= centroids[i][3]
         centroids[i][2] /= centroids[i][3]
      .
      changes = 0
      for i to npts
         ind = nearest pts[i][] centroids[][]
         if ind <> pts[i][3]
            pts[i][3] = ind
            changes += 1
         .
      .
      maxiter -= 1
      until changes > acceptable and maxiter > 0
   .
   for i to nclusters : centroids[i][3] = i
.
proc show pts[][] centr[][] .
   gbackground 000
   gclear
   nclusts = len centr[][]
   npts = len pts[][]
   for i to nclusts
      c = random 8 + 1
      c += (random 8 + 1) * 10
      c += (random 8 + 1) * 100
      gcolor c
      for j to npts : if pts[j][3] = i
         gcircle pts[j][1] + 50, pts[j][2] + 50, 0.2
      .
      gcolor 888
      gcircle centr[i][1] + 50, centr[i][2] + 50, 0.8
   .
.
genpts NPOINTS pts[][]
lloyd pts[][] centroids[][] NCLUSTERS MAXITER
show pts[][] centroids[][]

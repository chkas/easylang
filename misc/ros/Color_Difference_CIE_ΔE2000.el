sysconf radians
#
k_l = 1
k_c = 1
k_h = 1
#
func exp a .
   return pow 2.71828182846 a
.
func ciede2000 l_1 a_1 b_1 l_2 a_2 b_2 .
   n = (sqrt (a_1 * a_1 + b_1 * b_1) + sqrt (a_2 * a_2 + b_2 * b_2)) * 0.5
   n = n * n * n * n * n * n * n
   n = 1.0 + 0.5 * (1.0 - sqrt (n / (n + 6103515625.0)))
   c_1 = sqrt (a_1 * a_1 * n * n + b_1 * b_1)
   c_2 = sqrt (a_2 * a_2 * n * n + b_2 * b_2)
   h_1 = atan2 b_1 (a_1 * n)
   h_2 = atan2 b_2 (a_2 * n)
   if h_1 < 0 : h_1 += 2 * pi
   h_2 += 2.0 * pi * (if h_2 < 0.0)
   n = h_2 - h_1
   if h_2 < h_1 : n = h_1 - h_2
   if pi - 1e-14 < n and n < pi + 1e-14 : n = pi
   h_m = (h_1 + h_2) * 0.5
   h_d = (h_2 - h_1) * 0.5
   if pi < n
      if 0 < h_d
         h_d -= pi
      else
         h_d += pi
      .
      h_m += pi
   .
   p = 36 * h_m - 55 * pi
   n = (c_1 + c_2) * 0.5
   n = n * n * n * n * n * n * n
   r_t = -2 * sqrt (n / (n + 6103515625)) * sin (pi / 3 * exp (p * p / (-25 * pi * pi)))
   n = (l_1 + l_2) * 0.5
   n = (n - 50) * (n - 50)
   l = (l_2 - l_1) / (k_l * (1 + 0.015 * n / sqrt (20 + n)))
   t = 1 + 0.24 * sin (2.0 * h_m + pi * 0.5) + 0.32 * sin (3 * h_m + 8 * pi / 15) - 0.17 * sin (h_m + pi / 3) - 0.20 * sin (4 * h_m + 3 * pi / 20.0)
   n = c_1 + c_2
   h = 2 * sqrt (c_1 * c_2) * sin h_d / (k_h * (1 + 0.0075 * n * t))
   c = (c_2 - c_1) / (k_c * (1 + 0.0225 * n))
   return sqrt (l * l + h * h + c * c + c * h * r_t)
.
proc test v1 v2 v3 v4 v5 v6 .
   numfmt 7 1
   write v1 & v2 & v3 & v4 & v5 & v6
   numfmt 15 10
   print ciede2000 v1 v2 v3 v4 v5 v6
.
print "     L1     a1     b1     L2     a2     b2      ΔE2000"
print "---------------------------------------------------------"
test 73.0, 49.0, 39.4, 73.0, 49.0, 39.4
test 30.0, -41.0, -119.1, 30.0, -41.0, -119.0
test 79.0, -117.0, -100.4, 79.5, -117.0, -100.0
test 15.0, -55.0, 6.7, 14.0, -55.0, 7.0
test 83.0, 98.0, -59.5, 85.2, 98.0, -59.5
test 59.0, -11.0, -95.0, 56.3, -11.0, -95.0
test 74.0, -1.0, 68.6, 81.0, -1.0, 69.0
test 46.4, 125.0, 6.0, 40.0, 125.0, 6.0
test 18.0, -5.0, 68.0, 20.0, 5.0, 82.0
test 35.5, -99.0, 109.0, 25.0, -99.0, 109.0
test 59.0, 77.0, 41.5, 63.3, 77.0, 12.4
test 40.0, -92.0, 7.7, 58.0, -92.0, -8.0
test 49.0, -9.0, -74.5, 51.1, 31.0, 16.0
test 88.0, -124.0, 56.0, 97.0, 62.0, -28.0
test 98.0, 75.7, 11.0, 3.0, -62.0, 11.0

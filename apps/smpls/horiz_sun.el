func getn s$ . v .
  write s$
  v = number input
  print v
.
call getn "Enter latitude: " lat
call getn "Enter longitude: " lng
call getn "Enter legal meridian: " merid
slat = sin lat
diff = lng - merid
print ""
print "    sine of latitude: " & slat
print "    diff longitude: " & diff
print ""
print "Hour\tSun hour angle\tDial hour line angle"
for h = -6 to 6
  hra = 15 * h - diff
  hla = atan2 (slat * sin hra) cos hra
  print h + 12 & "\t" & hra & "\t\t" & hla
.
input_data
48
15
0


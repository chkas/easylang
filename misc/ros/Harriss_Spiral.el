# Harris Spiral - translated from the Processing sample
# 
# the EasyLang canvas is 100x100 with 0,0 at bottom left, 100,100 at top right
# the following maps the Processing canvas to the EasyLang one
scX = 1
scY = 1
func scaleX v .
   return v * scX
.
func scaleY v .
   return 100 - (v * scY)
.
proc scaledLine x0 y0 x y .
   gline scaleX x0 scaleY y0 scaleX x scaleY y
.
# 
# the following implements equivalents for some Processing functions and Boolean literals
# false = 0
true = 1
proc size w h .
   scX = 100 / w
   scY = 100 / h
.
proc strokeWidth w .
   glinewidth w / 18
.
proc stroke rb gb bb .
   gcolor3 rb / 2.55 gb / 2.55 bb / 2.55
.
proc arc xCenter yCenter eWidth eHeight p1Angle p2Angle .
   rx = eWidth / 2
   ry = (eHeight / eWidth) * eHeight / 2
   arcAngle = p2Angle - p1Angle
   angleStep = arcAngle / 720
   angle = p1Angle
   for s = 0 to 720
      angle += angleStep
      x = xCenter + rx * cos angle
      y = yCenter + ry * sin angle
      if s > 0 : scaledLine xp yp x y
      xp = x
      yp = y
   .
.
# 
# Harris Spiral - translation of the Processing sample
# EasyLang angles are in degrees, so conversion to radians is not needed
# some values have been tweaked
# 
h = 600 ; # scalable (may be any value)
HR = 1.325 ; # Harriss Ratio
_wndW = 1000
_wndH = 1000
showLines = true ; # was false in the Processing sample
proc drawHarriss x y dAngle lngth iteration lineW .
   if iteration > 0
      startAngle = dAngle + 45
      endAngle = startAngle + 90
      # Calculate end point of lines
      xEnd = x + lngth * cos dAngle
      yEnd = y + lngth * sin dAngle
      if floor yEnd < floor y
         heading$ = "SN"
      .
      if floor xEnd < floor x
         heading$ = "EW"
      .
      if floor yEnd > floor y
         heading$ = "NS"
      .
      if floor xEnd > floor x
         heading$ = "WE"
      .
      if showLines = true
         stroke 255 255 255
         strokeWidth 3
         scaledLine x y xEnd yEnd
      .
      radius = 1.414 * lngth
      if heading$ = "SN"
         cntrX = x - lngth / 2
         cntrY = y - lngth / 2
         stroke 255 255 0
         strokeWidth lineW
      .
      if heading$ = "EW"
         cntrX = x - lngth / 2
         cntrY = y + lngth / 2
         stroke 255 0 0
         strokeWidth lineW
      .
      if heading$ = "NS"
         cntrX = x + lngth / 2
         cntrY = y + lngth / 2
         stroke 0 0 255
         strokeWidth lineW
      .
      if heading$ = "WE"
         cntrX = x + lngth / 2
         cntrY = y - lngth / 2
         stroke 0 0 0
         strokeWidth lineW
      .
      arc cntrX cntrY radius radius startAngle endAngle
      drawHarriss xEnd yEnd dAngle - 90 lngth / HR iteration - 1 lineW
   .
.
proc setup .
   size _wndW _wndH
   gbackground 555
   gclear
   startX = _wndW / 2 + 50
   startY = _wndH - 50
   initLen = h / HR / HR
   # Reverse Order Hides Joints
   drawHarriss startX - (initLen / HR + initLen / HR / HR / HR) startY - initLen / HR / HR / HR / HR / HR / HR / HR / HR 180 initLen / HR / HR / HR / HR / HR / HR 2 6.0 ; # level 3
   drawHarriss startX - (initLen / HR + initLen / HR / HR / HR) startY - (initLen + initLen / HR / HR) 270 initLen / HR / HR / HR / HR / HR 3 6.0 ; # level 3
   drawHarriss startX + initLen / HR / HR / HR / HR startY - (initLen + initLen / HR / HR) 270 initLen / HR / HR / HR / HR / HR 3 6.0 ; # level 3
   drawHarriss startX + initLen / HR startY - (initLen + initLen / HR / HR) 0 initLen / HR / HR / HR / HR 4 6.0 ; # level 3 rt-upper
   drawHarriss startX - initLen / HR / HR / HR / HR startY - initLen / HR 0 initLen / HR / HR / HR / HR / HR 2 10.0 ; # level 2 mid-upper
   drawHarriss startX - initLen / HR / HR / HR / HR startY - initLen / HR / HR / HR (-270) initLen / HR / HR / HR / HR 3 12.0 ; # level 2 mid-lower
   drawHarriss startX - initLen / HR startY - initLen / HR / HR / HR 180 initLen / HR / HR / HR 4 12.0 ; # level 2 lt-lower
   drawHarriss startX - initLen / HR startY - initLen 270 initLen / HR / HR 5 14.0 ; # level 2 lt-upper
   drawHarriss startX startY - initLen 0 initLen / HR 6 14.0 ; # level 2 rt-upper
   drawHarriss startX startY (-90) initLen 7 18.0 ; # level 1 base spiral
.
setup

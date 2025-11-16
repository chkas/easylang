func[] hsb2rgb hue sat bri .
   h = (hue - floor hue) * 6
   f = h - floor h
   p = bri * (1 - sat)
   q = bri * (1 - sat * f)
   t = bri * (1 - sat * (1 - f))
   if h < 1 : return [ bri t p ]
   if h < 2 : return [ q bri p ]
   if h < 3 : return [ p bri t ]
   if h < 4 : return [ p q bri ]
   if h < 5 : return [ t p bri ]
   return [ bri p q ]
.
proc cwheel .
   for y = 0 to 499
      dy = y - 250
      for x = 0 to 499
         dx = x - 250
         dist = sqrt (dx * dx + dy * dy)
         if dist <= 250
            theta = atan2 dy dx
            hue = (theta + 180) / 360
            r[] = hsb2rgb hue (dist / 250) 1
            gcolor3 r[1] r[2] r[3]
            grect x / 5 y / 5 0.3 0.3
         .
      .
   .
.
cwheel

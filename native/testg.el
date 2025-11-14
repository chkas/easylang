rad = 12
x = 50
y = 75
vx = 1.5
gcolor 700
#
on animate
   gclear
   gcircle x y rad
   x += vx
   y += vy
   if x > 100 - rad or x < rad
      vx = -vx
   end
   if y < rad
      vy = -vy
   else
      vy -= 0.08
   end
end

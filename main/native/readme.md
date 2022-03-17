##  easylang.online - native

### Build und run in Linux

#### Without graphics, needs a C compiler

~~~
$HOME/$DATA/easylang*/main/native/runc <<'EOF'
for i = 1 to 10
  print i * i
.
EOF
~~~

or with `$HOME/$DATA/easylang*/main/native/runc test.el`

#### With graphics, needs additionaly SDL libraries

~~~
$HOME/$DATA/easylang*/main/native/run <<'EOF'
set_linewidth 4
set_color 900
# 
move_pen 10 10
draw_text "Paint"
on mouse_down
  down = 1
  move_pen mouse_x mouse_y
  draw_circle 2
.
on mouse_up
  down = 0
.
on mouse_move
  if down = 1
    draw_line mouse_x mouse_y
  .
.
EOF
~~~

### Build und run in Windows

~~~
cl /O2 /D__NOSDL__ ..\kabas.c
kabas test.el
~~~



move 10 80
text "Press y or n"
repeat
   sleep -1
   ans$ = keybkey
   until ans$ = "y" or ans$ = "n"
.
move 10 70
text "-> " & ans$
# 
on key
   # 
.
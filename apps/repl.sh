#!/bin/sh

# on timer -> on set_timer

mkdir -p _save
for i in $(ls *.html 2>/dev/null); do
#for i in $(ls mk* *.js *.kab *.el 2>/dev/null); do
	sed -i '
s/set_timer/timer/g
s/set_textsize/textsize/g
s/set_linewidth/linewidth/g
s/draw_circle/circle/g
s/set_color/color/g
s/set_background/background/g
s/move_pen/move/g
s/draw_line/line/g
s/draw_rect/rect/g
s/set_rgb/color3/g
s/draw_arc/circlearc/g
s/play_sound/sound/g
s/draw_polygon/polygon/g
s/draw_curve/curve/g
s/clear_screen/clear/g
s/sys_time/systime/g
s/str_ord/strcode/g
s/str_compare/strcmp/g
s/keyb_key/keybkey/g
s/str_chr/strchar/g
s/time_str/timestr/g
s/str_join/strjoin/g
s/draw_text/text/g
s/str_chars/strchars/g
s/str_split/strsplit/g
' $i

done



global pok$[] pok[] fc[] lc[] .
proc init .
   repeat
      s$ = input
      until s$ = ""
      for pok$ in strsplit s$ " "
         i += 1
         fc[] &= strcode substr pok$ 1 1
         lc[] &= strcode substr pok$ len pok$ 1
         pok[] &= i
         pok$[] &= pok$
      .
   .
.
init
#
len chain[] len pok[]
maxchain = 0
#
fastproc search lng .
   if lng > maxchain
      for j = 1 to lng : chain[j] = pok[j]
      maxchain = lng
   .
   lastc = lc[pok[lng]]
   for i = lng + 1 to len pok[]
      if fc[pok[i]] = lastc
         swap pok[i] pok[lng + 1]
         search lng + 1
         swap pok[i] pok[lng + 1]
      .
   .
.
for i to len pok[]
   swap pok[i] pok[1]
   search 1
   swap pok[i] pok[1]
.
for i to maxchain
   write pok$[chain[i]] & " "
.
print ""
#
input_data
audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon
cresselia croagunk darmanitan deino emboar emolga exeggcute gabite
girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan
kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine
nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2
porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking
sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko
tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask

suits$[] = [ "♣" "♦" "♥" "♠" ]
faces$[] = [ "2" "3" "4" "5" "6" "7" "8" "9" "T" "J" "Q" "K" "A" ]
#
func rank card .
   return card mod1 13
.
func$ name card .
   return faces$[card mod1 13] & suits$[card div1 13]
.
proc take &card &hand[] .
   card = hand[1]
   for i to len hand[] - 1 : hand[i] = hand[i + 1]
   len hand[] -1
.
proc append &hand[] &cards[] .
   for c in cards[] : hand[] &= c
   cards[] = [ ]
.
proc war .
   for i to 52 : deck[] &= i
   for i = len deck[] downto 2
      r = random i
      swap deck[r] deck[i]
   .
   for i to 26
      hand1[] &= deck[2 * i - 1]
      hand2[] &= deck[2 * i]
   .
   while len hand1[] > 0 and len hand2[] > 0
      take card1 hand1[]
      take card2 hand2[]
      played1[] = [ card1 ]
      played2[] = [ card2 ]
      repeat
         write name card1 & "  " & name card2 & "  "
         if rank card1 > rank card2
            write "Player 1 takes the " & len played1[] * 2 & " cards."
            append hand1[] played1[]
            append hand1[] played2[]
            print " Now has  " & len hand1[] & "."
         elif rank card1 < rank card2
            write "Player 2 takes the " & len played1[] * 2 & " cards."
            append hand2[] played2[]
            append hand2[] played1[]
            print " Now has " & len hand2[] & "."
         else
            print "War!"
            if len hand1[] < 2
               print "Player 1 has insufficient cards left."
               append hand2[] played2[]
               append hand2[] played1[]
               append hand2[] hand1[]
            elif len hand2[] < 2
               print "Player 2 has insufficient cards left."
               append hand1[] played1[]
               append hand1[] played2[]
               append hand1[] hand2[]
            else
               take faceDown1 hand1[]
               take card1 hand1[]
               played1[] &= faceDown1
               played1[] &= card1
               take faceDown2 hand2[]
               take card2 hand2[]
               played2[] &= faceDown2
               played2[] &= card2
               print "?   ?   Face down cards."
            .
         .
         until len played1[] = 0
      .
   .
   if len hand1[] = 52
      print "Player 1 wins the game!"
   else
      print "Player 2 wins the game!"
   .
.
war

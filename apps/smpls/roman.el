func num2rom num . rom$ .
  values[] = [ 1000 900 500 400 100 90 50 40 10 9 5 4 1 ]
  symbol$[] = [ "M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "V" "IV" "I" ]
  rom$ = ""
  for i = 1 to len values[]
    while num >= values[i]
      rom$ &= symbol$[i]
      num -= values[i]
    .
  .
.
call num2rom 1990 r$
print r$
call num2rom 2008 r$
print r$
call num2rom 1666 r$
print r$
# 
func rom2int rom$ . val .
  symbols$[] = [ "M" "D" "C" "L" "X" "V" "I" ]
  values[] = [ 1000 500 100 50 10 5 1 ]
  val = 0
  for dig$ in strchars rom$
    for i = 1 to len symbols$[]
      if symbols$[i] = dig$
        v = values[i]
      .
    .
    val += v
    if oldv < v
      val -= 2 * oldv
    .
    oldv = v
  .
.
call rom2int "MCMXC" v
print v
call rom2int "MMVIII" v
print v
call rom2int "MDCLXVI" v
print v



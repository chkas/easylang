n$[] = [ "alliance" "archbishop" "balm" "bonnet" "brute" "centipede" "cobol" "covariate" "departure" "deploy" "diophantine" "efferent" "elysee" "eradicate" "escritoire" "exorcism" "fiat" "filmy" "flatworm" "gestapo" "infra" "isis" "lindholm" "markham" "mincemeat" "moresby" "mycenae" "plugging" "smokescreen" "speakeasy" "vein" ]
w[] = [ -624 -915 397 452 870 -658 362 590 952 44 645 54 -326 376 856 -983 170 -874 503 915 -847 -982 999 475 -880 756 183 -266 423 -745 813 ]
# 
n = len w[]
len set[] n
done = 0
# 
proc subsum i w k . .
   if done = 1
      return
   .
   if i > 0 and w = 0
      for j = 1 to i
         write n$[set[j]] & " "
      .
      done = 1
   .
   for j = k + 1 to n
      set[i + 1] = j
      subsum i + 1 w + w[j] j
   .
.
subsum 0 0 1

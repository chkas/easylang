# AoC-21 - Day 8: Seven Segment Search
# 
# "Simple" brute force strategy, which
# tries all possible connections
# (permutations) until all displays show
# a digit.
# 
visualization = 1
# 
background 000
clear
func draw x y cod . .
  if visualization = 0
    break 1
  .
  d = 2.8
  s = 0.5
  linewidth s * 6 / 5
  x1[] = [ x + s x x x + d - s x + d x + d x + s ]
  y1[] = [ y + d y + d - s y + d + d - s y + d + d y + d + s y + s y ]
  x2[] = [ x + d - s x x x + s x + d x + d x + d - s ]
  y2[] = [ y + d y + s y + d + s y + d + d y + d + d - s y + d - s y ]
  color 000
  move x - s y - s
  rect d + 2 * s 2 * d + 2 * s
  color 900
  for i range 7
    if bitand cod bitshift 1 (6 - i) > 0
      move x1[i] y1[i]
      line x2[i] y2[i]
    .
  .
  sleep 0.001
.
# 
perm[] = [ 0 1 2 3 4 5 6 ]
global permlist[][] .
func permutate_list k . .
  for i = k to len perm[] - 1
    swap perm[i] perm[k]
    call permutate_list k + 1
    swap perm[k] perm[i]
  .
  if k = len perm[] - 1
    permlist[][] &= perm[]
  .
.
call permutate_list 0
# 
func codeperm perm s$ . cod .
  cod = 0
  for c$ in strchars s$
    cod += bitshift 1 permlist[perm][strcode c$ - 97]
  .
.
len digit[] 128
func init . .
  for i range 128
    digit[i] = -1
  .
  s$[] = strsplit "abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcdfg" " "
  for i range 10
    call codeperm 0 s$[i] cod
    digit[cod] = i
  .
.
call init
# 
global inp$ part1 part2 linenr .
func procline . .
  inp$[] = strsplit inp$ " "
  for perm range len permlist[][]
    for nr range 10
      call codeperm perm inp$[nr] cod
      if linenr < 10
        call draw nr * 6 + 2 linenr * 10 + 2 cod
      .
      if digit[cod] = -1
        break 1
      .
    .
    if nr = 10
      val = 0
      for nr = 11 to 14
        call codeperm perm inp$[nr] cod
        if linenr < 10
          call draw nr * 6 + 2 linenr * 10 + 2 cod
        .
        dig = digit[cod]
        val = val * 10 + dig
        if dig = 1 or dig = 4 or dig = 7 or dig = 8
          part1 += 1
        .
      .
      part2 += val
      linenr += 1
      break 2
    .
  .
  print "no match"
.
repeat
  inp$ = input
  until inp$ = ""
  call procline
.
print part1
print part2
# 
input_data
cfgeda afcbg fbcdaeg gbdfa fdgcba cbdf becga cf gcf gbdefa | bfcd acgdfe cfabg dcbf
ge gbafde gbafc bfagdc cdebf fabegc egbfc ebg dbgacfe ecga | bge cfabdge fgeabc gcea
dce ecdbfa bacdg gfdabc egda gecbd ed dcabge bgecf cgadbef | eabfdc degacb ecfbg cgedb
bdae bfcedg gecadf gdaefcb bfcag egafb fdbeag edgfb ea eaf | gedbf abed bcafg gdfbe
cefgdab ba efdacb gfeabd abfg cagedf bcged eba egadb fdeag | eab afgb afgb fdeag
fecbdg edcgba cef gfacbde ebfa fcbead acdeb cfdag ef dafec | adcef ef fe fadgc
agefb dbfgca dfgea afgcde cfdbea agcfd gced def ed fbgedac | ed dgecafb cabdgf fed
gcafed ecabd bfa fdaebg bf febg efdba fgacdb aedfg dagecfb | defgacb bf bf dfeag
gcfabe gbdc bgdacfe gbecdf ebgfc bcdfe dc degfca ced befad | bdgfeca dceagf cefdga ebdfa
cfaeb bafg bcg dgefc fcbeg gb defcbag eafgbc adcebg cdbafe | bfag afgb gbc cgfeb
agcef fgdbeca bc efagbd cfbea cebfda bfdea dbac ebc gcefbd | acfge ecabf acdb bc
dacfbeg cegfb aecf cegbd fabdge bgafe agbcdf bfgcae fc gcf | cabdgf efcbg bgecf gdeacfb
daebg cgdabe afgde fbagcd eb cbagd baefcgd edb dcaefb bgec | edb begc egdacb eb
dbcfea dbfac adg gbac dbeagf bgafdc bdaegcf gdafc ga cgfde | ebdafg gacb agd dga
gcdf cda ebagfd egcfbda cbega aegdf eadcgf bcedfa eacgd dc | dcgfae cda bfgcaed acbeg
gcdbea cf dgeac gacefd bgcdfa fegc beafd fcd decaf egfdcba | geacdb cf gfec egfadc
aced fedcg efa cfgdeb fcadeg afcbge efadg ae bgecfad gdfba | fegacb bcagedf geacbf eadc
fdegca faedcb aecgd cfgde cef fe fgcbd fgea ebgdac bfeadgc | cgade dfgec fe fe
egdbac dbfcga egfadbc abe dcae dgfbe ae gabed bgcad acegbf | efabgc bdcag aeb gadcb
da dca dbfeagc gcdfb dage eagbc adcbg fadbce badegc ebfcag | gcabde egfcab adc dca
ecabd gc cbg befadc egdacfb edbfg edbgc cbeagf beadgc agcd | eacdb gcebd cadg cdeba
gcfdae bdgcefa acbge edbfgc aegdcb gdceb bdae cagfb cea ea | ecagdbf dbecg gbced dcageb
gdac gd ecbgdfa dagbe ebdgcf baecd begaf deg bdgace ecdabf | ebafg cdga dg dg
ca decabf dbgae ace dbacfeg cbafge ecbdgf defbc dbcea adfc | dabec bcdfe egbcadf eca
gfaed dgbaec gbf bf cfegba fgabd cfdb adgcfb dbcag dgacbfe | fcdb acbgd fdagb gbf
dceagf cge dbgacf eg fged afcdg eadcg cbgeaf cdfgaeb ebdac | gce cge agcedbf fadcg
cfbae edafc cb fbc fegab cfegdb dabc bfcdega efbadc deacfg | cedfa gdefbc adcb cfb
afbgdc acgbed gdae eabcf cda da gbcde bdcea gdacbef dgcbfe | aedg bcgde bfgdca da
gdbfaec aebcg egacf bcgd cegadb ebc badge aebfgd bc bfdaec | ebc bc fgace bc
fa cdeab fegbda beadcg gfedc cfade facb adcgbef fad dcebaf | dbgecfa dafcbeg cbadge cbead
egacf bdegfa df daf cbaged bgdf efbcad cebafdg daegf dbeag | badeg dbcgaef gedaf ebagcd
dcagbf gceba ecgadf dfeb cef afceb ef cebfda adcebfg afdbc | ef bcadf egdfcab cfegad
acbdf gbae feadg eb egbdfc ebfgcad efbad deb fgdbea adgcef | ebd eb bcadf fbdac
fde daegbfc fgabd deacfb egad gfceb gafbdc gbedf ed abegfd | bfadce cefbg fbgcad fabgd
cbade eab becfad acfbdg dbgcaef gdaec gfadeb eb cafdb bcef | edbca fbcdaeg fcdgeab afcbd
dacg gaf fbcdg bcgaf bdgeaf fcagbd fbeac ag gbcefd aebgcfd | cdbgf fga ebcfdag fgcadb
bed db dcageb gbdf dfgceb cebfg fcdae cbefd gebfac afgdcbe | egbcdf begdcf dfgceba bd
egcfd gbde defbagc cebafg dcg gd edcfa bdfecg fegbc gcdbfa | bcegaf cegdf fcabgd fdecg
fb fbeg egdcaf cbf efgcd fagbedc ecdbf cbgefd cfadbg bcead | fdeacg faegbdc gbedcf bcf
abefd bcgfeda bcage acbde ebacgf cd dcb ecdfbg dceabg dgca | gacd agcd dc debfa
cdbgaef cfd cf dfega edfgab dfegac ebfdcg fdagc gbacd caef | cegdfa fc feadg afce
afdgcbe gef bcafeg gfbad gecda ebdf ef gdefa bafedg fdbagc | fdbe ef egfcab dgbcaf
cageb gfebcd adfg caegfd cfdbaeg bdcfea ead ad agced dgfec | gecab bedacf efgcd gfad
bed bdfaec bgcedf bgadfec ed fgecb dcgeb dgcab gefd abcgfe | cegfb cgbdef gdef dacbfeg
gfbce ge egf dfagbc degcaf efacb bcgfd afebdcg bdegcf gebd | egbd fadgce gbed gbcef
bcgedf fgde dgebfac fg gfbdc dbcgea gfc decbg fcbad gcebfa | cbdgf fgbdc cbfdgea fgc
baecfd dfge agecfbd bgdae bgafcd fgadb ed cgabe deb defbga | dfbag degf eadbg fged
cbfadg gbec acebd cgfead bc beafd baedgc cbd cegad gefdacb | gacde dcfagb egdca aebcd
agef dea edcbfg dcgba dcefg cedgfab ecgda ea bfeadc cfadge | ecbdgaf bcdeaf dbacg bedgcfa
aegcb cbgfda gaedbc afcdebg ecdg ec facbde ceb efbga cgadb | cgbeadf cged egfdacb dfceab
bedfc dfegbc gcbad cbeagf egdf fdgcaeb ge cgdbe geb abcefd | eg cabfge efbacd gebdcf
dacef fegbadc bc cbfg dagbf dfgaeb afbgdc fcdab bgadce acb | cfbg gcbf afdec fdcae
ebgaf be bge fgbda afbcdeg cgaef bcdagf fbaedg efbd agebdc | afdgcb efbd gbe adbgf
agbdecf acgfeb cgbae fcae ae egfdba agbcd egbcdf ega gefcb | cfgeb cageb ea eag
cbe fdgbe ebdfag cabdefg ec fbdce cegdfb gcef gcadeb cdbfa | acfgdeb gcfdbea cbefgd gfadbe
gdcfeb bf bdf edgabc fgbc gbdce ecdbf gdeafb dfeac ceagdbf | fcgb gbdce fbedacg gfbdea
bag gbfacd egafc afcbed cdbg gadfbe fdcba gb becagfd afbgc | cagfdb bga fgcea bdacegf
gadbf cbaedgf dfeacb fg defba dfg fgeb gedbaf dagbc gecfad | degafb cefgda gdf dgafec
dbfaec fg degab bgfcde ecfagd fgaed dfg cafed bgafced agcf | gdaefcb gcaf acebdf gf
ebgfc eagdc eadf agbfcd gfa feacg cdegbaf dgbaec fa cfdega | edcagf gcdabef geacd fdae
gabcdef fadg aedfb dcgbfe afbecd egd aedgb cbega afebdg dg | bafed dgaf gbeac deg
fbgecad badfce eb befa efcda aedcb gfcedb edb bcgad afdecg | aefb facde cadgb bed
fabcdg bfc adbf cgdaeb fdgec acgdfeb gbecaf gcfbd fb bdgca | fb acbgde cabdgf bf
fdgcea ca bdfag cbdfgae acd bcdgea bdegc beca agdcb dgfbce | fdecag adc cad cdgeb
gfcb abgef deafbcg aebdcg ebgcaf caefg gb fdceag gba afdbe | eagcfd bgcf adgcfe bcfg
dfbcga ebdfac fcge bfcegd adbeg fg gfd beafdgc fdebg bfdce | gfacedb cbfagd ecfg afbced
gfecabd dacefg bade aeg bfgea cebfg ae fdbga bagcdf eafdgb | adbe beda edab degbfa
dbc cdbeaf gedbfa acdeg cb abcf edfba cfbegd aedcb defgacb | bc aecdg aefbcd egdca
fcbed cdg agbcf bgedcf gd cbefad bgdcf gbed gefadc badgfec | bcfgd bged dcg fdebc
fgdc egbfac eafdg gedac dgefbca ecdabg dbfae gdafec gaf fg | fdabe aedgf bdeaf gfdc
dg cdafebg cfgaed gbda gcbead deg cfbeg cdeabf gebcd adbce | dg bcgde gabd gde
cgb cbegd cg fecgab febcd gaedcb fadbeg gebad dgca efdbagc | cg bcg dgaecb ecdbga
egfbda dbeca fd gcbaf bgafedc fbd efcd dgecab bfadc ecdfab | eagbfd dbcea edcbga cfed
fceadgb beadf bdefca gfebcd bfca edafc fc cfd bgafde gcdae | acbf cf ebcdgfa daecf
eacdgb gbdcfae gdfe cfbea gedcbf cfdagb bfd df gcebd fdecb | df bcfea dcabeg gfcedab
ebgca bdfcge degbac dfbca gfbaecd eadg acgfbe de bde edcba | abgfced dbcgef adeg caegb
acebfg bfdecga dea cafdg gfadbe bdeg bfcdae egbfa de fdeag | de dfcbgae fcadg fadcgeb
aegcfb dbefg ebdc edfcg gfbeda agfcd cedbafg ce cfe decfbg | acbefg bgeadf dgefc faedbg
eadgb bdcae bc acbg fgbecd gfdeab ceb cdafe agbecd gaebfcd | bcaged bc gbca bedca
abfgc dbgeaf fc gdbfa dacf bgdfac gacbedf fcb egacb gdcbef | bcadfg cdaf fc bagce
fbde gdafe de dbfeag bdceag fgace gafcbd fbadg cfdeagb gde | edfb eacbgd efgda deg
cedaf ecfgbd dcg bdagef gbedf gc dcgbfa cgbe aecbdfg cfgde | cg cedfg cg dcg
fbe bfgda ef dfgebca gbedfc bgcde daecbg efcg fgdbe fedcab | fbadg fbe bcaefd bef
cega aefcb eabfg debfgca gfdba aefcgb bge fbcdge ge bdeafc | dafgb ebg fbcae fgeadcb
fb dgaecf bdgec gacdf edacbf bfc cdgbfa bagf adgfecb cgbfd | fgba bf bgfcd cebdg
facd cgbfd afdgbc agbfed af gaf acfbg becag cdgefb fgcaebd | gfbcad dafc dcfabg begfcd
cfaged cdgfe efdca aedcbf fgca feg fg cdbge egbfad febgadc | gef cdefg becdg gfbead
ecgdaf dbefcga bfg fbedga abcf cgfeb gbecd aecgf aebfcg fb | eacgfb cbaf caegfb gfb
bec caed aefcb eacgdbf agbdcf ec faedcb cafbd aebfg bfcdge | fagdcb fbcad ecdgfab abegf
gdecab cdaegf acgfb efbd bd edgabcf fgcdb gefdc gbd cebfdg | db cbgfa ebgcfd gcdebf
fbced cdaefgb ae abgced dcgab dae cbgafd acefgd acedb geba | agdcb deagcb ae baeg
adcef db ecgba gbfcde dabg fagbce bde cadebg cdabe gdbefca | edfca dcafe fdcegb dbga
cabed ecagdf fcadgb cbagd bgde fecdbag de acefb gcdabe dec | gbdfac de begd cdeba
dcegaf gc dbgfa dcbg dcgfab acbef edagbfc daegfb abcgf gac | gbcafed cg agdfb dcafbg
eag gfdab fgecda bcgdef deca fdaeg efcgab gecdf ae cfgbade | eagfcb ae fagcde aecd
aceb eadfcg gcadeb ea bgcda bagde dbfge badcfge gdbfac aed | ceabdg ead eda abec
fcdg bgc bdcafeg abefdg gfcbad cgabd cdbea fcegab cg gafbd | efacbg gdcba dcaeb cgfabd
gacbfe cedbga adecf ebcad abdcegf db cgaeb abdefg dcgb dab | bda ebcgfa acdbeg cedabfg
dceabf acefgd cgfe dabgc dagfe dec egdca ce abcgdfe fegdab | gcfade gefc gacfbde degcfa
aef gcbafe bgcfead gdaefc fgbe bceaf dbagcf abdce gcfba fe | gfeb ebgdacf efa fe
cebafdg cagedb eg gecaf facbg daecf cge fdge bafcde efdcga | gdcaef bcgfa dfge efcda
gfadc gbecf efagc cgdaeb gea cagedf ea fagdcb fgdacbe fead | bgcfdae ae daef gafec
gcd cdea cgafbe dfgce dcgaef dc debgf edbgafc bgcdfa cegaf | cdg cdg acde caegfdb
dbfgac gdabce fcdgb gbcefad adgecf edbcf bfag gbd gb afcdg | dbg agdcef ecfbd gfcaed
bdcae fcabed gafdecb fbdeag bafed bceag cd fgaecd dec dcfb | dbfc fabedgc gfebda eacdb
acgfd agcdbe bcfe gef afcgeb gdfeab ef gbedcaf beagc acgef | dcaegfb ef gdfceab efg
fadegc egd gd egafcb afdeg fdeab agfec fgedbca dcebag cgfd | faegc agfce dcgefa dg
fdgbeca bfecd becda gcdefa dagbfc edfbgc bfge fbd dfgec bf | fdbce fbcdag gbfe fbd
afeg gfecda bfgdc dfecab af gdfac gdecab cdaefbg afc ecdag | fega bdcgf afc agedcf
badec bgae fcade feadgbc becadg bfcagd be cabdg edb ecdfbg | gbea ecfad abdcg bcgfdea
gfbea cabedg ed dabcegf eabfcg deb fabdc egfd abfde febgda | aefbd fgde degf fdeabg
acdfeb fd gafcb egcfbad egadc gdfb caebgf fgadc fcgdab fad | fcgabd adf fd cfgba
eabfcd bcadg aceg gabfed ag aecdb cdfbg dabecg gcebafd agb | cbade bga ag gcbdf
fabgcd agefb cb dbefgc acefdbg fcgaed fabgc dbac dgafc cfb | bcgdfa fdbacge edgfca afedcgb
dbaeg efcg beagfc fg bfgae gfabcde bdefac dgcabf bgf ceafb | eafcb aegfb fg fbg
bdfeg af fcabged ecadg gbcaed fcadgb dgcfae faged dfa caef | deagc dfa gdafe fda
df acgbfe bcfdg bcgdaef edfg gbdac dbaecf cdf ebgfc ebdgcf | gfcdb cdf fegcb eagdbfc
daefb afcdg dbgecfa bgca dcbegf feadgc gb gfbcad gdbfa bgd | dgb gb fbeda gadcfb
efacg febdc dfgbce acdbge acebgfd bfdg dg cdegf dgc aedbfc | bgdf gafec dg dcg
fdgbe cbg gdfbc efgdba cbed bc bgafce cgafd bgcfdea gfedcb | bc gfcdb edbgf dfbgc
bgdce bfgae efbcgd deafcbg cdegaf ebgfd gecbad dbfc gfd fd | df df agfcde ebcdg
gcbda debga be gedcfab fbedga efbd fgaed bea gfaebc afgdec | aefdg adefgc acefgd abe
egbdfc fbac bc dcage bfeagdc ebafd baedfg dbcae faedbc cbd | adcfeb fgdceb fdcgeb bacf
ebfgd facedg begaf afbegcd def df dfgceb edgcab dbcf cbedg | fdcb fed dfcb bfceagd
dbgec ebad gbcdfe ceadgbf ceadfg gacbf bcdage adg cadbg ad | cgbde cbgde gcbfa gabcf
aebgdf fabeg da bgad cbfde bcagef cafbgde edfab fecgad ade | fdabe gafdbe edfab dea
bda ad bgaef ecbfag cdefb faedb badgef gabecd dagf cbeagdf | bad fdgbcae egbafd gdeabf
gf eabgd begfca bcgdae aebcgfd gaf gfed fbadg cbdfa dbeafg | fbcda fdabg acfbd fdeg
agdbce dcbfg gcefda acg ebdca defacgb fedabc egab ga gcbad | bega abge gac fceadb
ebfcdg afcbed bad dafge ba gacfbd gcebdaf dgabf abgc cbdfg | acbg bfgdec cgebdfa gfcbd
gabedf adfe bacgfe fgadb adbgecf fa gdaeb fdcbg gcdaeb afg | acegfb fa gaebd gaf
fegca afg gebfdca fa daef cabdge dceag dcfgae acbdfg efbgc | aefgbcd gebdca fga afdgbc
dagfe cfabgd dgefc gacedfb ga baegdf gfa bdafe egba fbedac | fbdagc egba cgdef gfa
bfadce fdagbe fgbde cgdfbe da ebcga badeg dbcfage fagd ead | fgdaecb dabgefc adgf ade
adbecg ab abe cdgeb dafec cgbdafe badce gcfeab cgbedf dbga | dgaefbc adbg abdgecf dabcfge
ebd abdec gbdafe bdgc bd ebfca gcdea gadceb cfabedg fcegda | bdcae bd aegdfc eadgcfb
ce cge bgfeacd fcbge cgdbfe aefbg dgacfb fced badegc bcdfg | gfabe dagcbe adfebgc cdaebfg
gecadb fb gbf gdbfeac acfgb eafcg bgadfe gdbac fcdb fcbgda | fdbc cdaefbg bf edcbag
ce cde bcdfgae abdfe fcagd bdgcae dagbfc dgafec egfc dfeca | cbadge bgfdeca dfeagc ecd
abcegd dagfc fgbdc fadecg agbf dcgfab fgdacbe bdg bg fbdce | bfcgaed ecdbag fabg dagecf
dafbe edgabf dcb cb fegcd becfda cbagfd aecb acdgbfe ebfcd | efabd aceb bdc dgbceaf
edgbcf bfacd efgb dabcge cdgef bg facdge fbcdg bagcdfe gcb | cefadg bgc cbdgfe bcg
dfbce baec gfbecda fbegdc cefadg edbcfa ea gdfba ead aebfd | aecb ea aceb ead
bfcaeg fag af egdcba egbdacf cbfa gfabde gceab ecgdf aecfg | bcega bcaf ecdfg dfbcage
ebadcgf eaf gdfbe baegdc fgac dgeaf af dgfcea acdebf aedcg | fdecga edfga efadg cdegfa
decagfb bdgfac efcba gfcdbe dbacf bec cdae ec becafd begaf | cefab bdecaf bcfdae cefgdb
eagdcbf abfde abcde daf dcbafe geabcd bgdfe fa gafecd cfba | af eagbcd ecdba defbg
cgfdab fdbe bdfcg cgfde de gaedbc egdbcf cedgbfa cfaeg deg | ecgdfb ged bedf bdcfg
afbgc egafd gdb gbfdea afdgb db edafgc dgcfeba debfcg abed | gdb cfgbde db db
degcbaf acfd fc gfbac dfcgbe eagbc degbaf dabfg fgc cabgfd | gdfbcea acdf eabgfd egacb
decaf eadcbf fcbgd ab facdb aecgbd efgacd cfadgbe abd feab | bdeagc cadfe beaf dcagbe
faecb adecf fbeagc gbec cbf cbadfeg bc bcfdag geafb fbdega | cgbe eacgfb edcfa cfb
bacdgf cfabe cdaegbf bacfeg cgdbae bf bcf ecfda bfeg aebcg | gebf bf cdfae cefad
bdgcfa bgcfd eb cgaefb adceg bfde ceb cbfedg agfbecd dcegb | dbfe fcdagb cgfeba bce
edfabg badge egbdf gbcdea fde befgacd fe aefb dbfcg cgadfe | gefbd gdbfe edf fbdeg
eaf gdecaf febacg egacb ef dcfab bgfe cgebad egafcbd cbeaf | fae fbacd cgabe agfcbed
ed egdf edafb efcab fgbdae eda cfagbd cabgefd debacg bdagf | eda ade fgde dgef
fcade be bgafc cedbafg caefgb bea dfbgea bfcae cbeg dbacgf | aecfb aeb ebcaf beafc
cfg bgdfeac bcdfe abfgd fdgbc adgfcb cg acdg gfceba fbeagd | bafdg cdebf acgbfe ceadgbf
gbecadf cadgbf dgefba bgcfe ga abg afbgc dcafeb dgac adcbf | bfgdac agcd bga agb
befdga ce gbafc baecdgf egc bedgac gfdecb bgead gcbea caed | ecg daebg ce aebcgd
edcag eacdf dfcba fe dcfgea degcab bacfeg cfe gefd agfbdec | gfecba ef fdeg edgf
ceafd cafbge df afd cdbea dfagce bgcedfa bdfaeg gface fcgd | feagbc cdgf cdfg ceafg
cfebg gcbdae bdaefgc ea gabdc eag fcabdg cdea abgec fegdba | bdcagf ceda feadgb ea
bacfe dbafe gbedac bfaged df fdb fadg edcgbf adbeg gecfdba | fgabde gdcabef efagdb egfcbad
cbafedg dcefa adgcb gabe degac gfbcad acedgb ecfdbg egc ge | gcfadb dabefgc aegb eg
bdaec gdeca dbc ecdbgf fbeagdc fbeadc afebc db gfbcae afbd | gbfecd gcebdfa fedacb gebcdf
cdgba agfcb cgfebd fb fcega gbecad cbf decafbg cdfagb fabd | fb gcdba badgfc cgbafd
agdeb adgec edcgba cegabfd cdfaeg afbgd dbe eb ebcg dabfce | cadgfe eb gdcbea deacg
gbdaf fgebda bda fgaecd fdgea dcbeaf bgea ab befcadg gdcbf | gedbafc ab cbdgf adb
bdfga fdcbeg bgcefa deafcb begdf fcbed agdbefc ge gced bge | fcbaeg ge fdceb ebg
agecf fedcbag fd ecbgd afcdeb fceabg gdfa daegfc cdgfe dfe | agfd gfecd dgcfe gfecd
bcfa egdbf eagcdf dbfec acfdgeb cdfea becfda bcd acedgb cb | cbd bdc edabcg bdefac
cgbf aegdc gdfeabc acfbed fec debgf fagbed dfecg fc febgdc | abcfed febdg cf bfecad
dfcbe dbcfgea cgaef gecfab bae bcga ba ceafb gefacd debafg | acbef fdcbe ab eba
aecfb becgdf cf fcag bdaec agcfbe agbef debafg cefbadg fce | cef cfe aecbd efc
fcgbad ebg fged eg gabef cbafe gbeadf fgdceba abdegc dbgaf | dabecg gedf gdaebfc bfeagd
fegbca cegbf cag bcafg ga gadbefc fdcega edbgfc fcdab geab | ag dbafegc ga acbfg
abcd dgacf fcedgb bfd db cfdbaeg agbfe fbcadg bfadg ecgadf | fdb dgecfba bfgda bcad
fbgde efbda bea adbfeg acdgefb eafg fecgbd ebdgac ea abcfd | abfde fbcagde edfgb abe
dafgbc adgec cbaegd bgdafec bgeac gbed dg edacf dag eagbfc | debg fbedgca edgb gda
eb abce bafge fgdbce ceabfdg agcbf fbcage cfgabd ebf gadef | fadeg cdegbf fcabdg gcbfea
gc dbcae aebgfc cbg gbeaf ecfg egfdab afebgcd cafgdb aegcb | fcge cbg fegc gfbea
fbegda bfd bfdace gceabd cfbga edgf bedfacg debga bgfad fd | bgfade acbdfe feabcd eabdgc
eadfbg ge cdaegbf bfgdc gcadbf ecfbg ecfab fbcdge egcd fge | fbace ceafb faceb degabf
gdba cbagfde gb fecdg gedbfa acbgfe dfgbe bafdce gbf adefb | dbefa dfbae decgf bedgf
fbe agfce ebadcf fbcdga fedagbc gfcdb egbfcd fbegc bged be | egafc gebd bgafcd edbg
bfcge efacg ae fdgac cea cbfdae bfgadc gfdcae gdae adfecgb | efdcab gface fcgbda gfebc
eagfc dacbfg cgefb cdfgea ebgafcd acde ae fae cgafd aefbgd | egcfa agcdf befgc gbacdf
gfecab gfdbac efcgdba cfabd gac dcbag ag cdebg dafebc fgda | gacebf adcbf bcgde cag
gbfcd cadeg cfbgde cfab adf af edbgaf dfgbca adgcf aefdbgc | adf afd fda fdacgb
cbg defgbc geafb bcda gdefcab cagfd cfaedg gfbac bc bdgfca | fcgba fbdcge cb gafeb
ca ebcgdf gadbec cda aedfb gfdbc baecfdg bacdf cfag adcgbf | cfga efabd ca badfc
cgabdf da fdca cebag bcdag cabdfeg fbgcd dab bedfag fdbecg | dba cdaf gbdfce eacgb
cbgf becfag cegad febadc afc gfcae becdfga adbefg cf gefab | afbdgec aegbf eagbf acf
bg edgfa dgcb dgbcfa fbagd dabcf edfcgab agb efacbd ebafcg | acdfb fdcab fdcba gb
de cged feadg fabedc cafgd fbage dfe edcbgfa agbdfc dgafce | gcde gfeab gafcd gabfe
abec fgbcdae gfcab ebfag cgaedf ae ceabfg eaf gabfcd gfbed | gfbaced bgfca ae gdbfe
fcdgba cagdfe cfbeagd bcfg afbdg cga cg gbadfe badgc cdbae | fdgeab cg dfgace gdabf
gfbdac dcfeag edfgcb dbc cb bdagc cbaf cdfag aebgfdc bdeag | gafdc bcd gdcaef bc


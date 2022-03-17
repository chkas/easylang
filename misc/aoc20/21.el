# AoC-20 - Day 21: Allergen Assessment
# 
global ingre$[] allerg$[] meal_ingre[][] meal_allerg[][] .
# 
func ingre_id s$ . i .
  for i range len ingre$[]
    if ingre$[i] = s$
      break 2
    .
  .
  ingre$[] &= s$
.
func allerg_id s$ . i .
  for i range len allerg$[]
    if allerg$[i] = s$
      break 2
    .
  .
  allerg$[] &= s$
.
func read . .
  repeat
    s$ = input
    until s$ = ""
    s$[] = strsplit s$ " "
    i = 0
    meal_ingre[][] &= [ ]
    repeat
      until s$[i] = "(contains"
      call ingre_id s$[i] v
      meal_ingre[meal][] &= v
      i += 1
    .
    i += 1
    meal_allerg[][] &= [ ]
    while i < len s$[]
      s$ = substr s$[i] 0 len s$[i] - 1
      call allerg_id s$ v
      meal_allerg[meal][] &= v
      i += 1
    .
    meal += 1
  .
.
call read
# 
n_meal = len meal_ingre[][]
n_ingre = len ingre$[]
n_allerg = len allerg$[]
# 
func allerg_in_meal allerg meal . is_in .
  is_in = 0
  for i range len meal_allerg[meal][]
    if allerg = meal_allerg[meal][i]
      is_in = 1
      break 1
    .
  .
.
func ingre_in_meal ingre meal . is_in .
  is_in = 0
  for i range len meal_ingre[meal][]
    if ingre = meal_ingre[meal][i]
      is_in = 1
      break 1
    .
  .
.
# 
len ingre_allerg0[] n_ingre
global allerg_ingre[][] .
# 
func search allerg . .
  len ingre_allerg[] n_ingre
  for i range n_ingre
    ingre_allerg[i] = 1
  .
  for meal range n_meal
    call allerg_in_meal allerg meal is_in
    if is_in = 1
      for ingre range n_ingre
        call ingre_in_meal ingre meal is_in
        if is_in = 0
          ingre_allerg[ingre] = 0
        .
      .
    .
  .
  for i range n_ingre
    if ingre_allerg[i] = 1
      ingre_allerg0[i] = 1
    .
  .
  allerg_ingre[][] &= ingre_allerg[]
.
for i range n_allerg
  call search i
.
# 
func part1 . .
  for ingre range n_ingre
    if ingre_allerg0[ingre] = 0
      for meal range n_meal
        call ingre_in_meal ingre meal is_in
        sum += is_in
      .
    .
  .
  print sum
.
call part1
# 
# 
len allerg_ingre[] n_allerg
func part2 . .
  for k range n_allerg
    for allerg range n_allerg
      s = 0
      for i range len allerg_ingre[allerg][]
        if allerg_ingre[allerg][i] = 1
          s += 1
          ingr = i
        .
      .
      if s = 1
        break 1
      .
    .
    if s = 1
      allerg_ingre[allerg] = ingr
      for allerg range n_allerg
        allerg_ingre[allerg][ingr] = 0
      .
    .
  .
  # sort it by allergen
  for i range n_allerg
    ord[] &= i
  .
  for i = 0 to n_allerg - 2
    for j = i + 1 to n_allerg - 1
      h = strcmp allerg$[ord[j]] allerg$[ord[i]]
      if h < 0
        swap ord[i] ord[j]
      .
    .
  .
  for i range n_allerg
    a = ord[i]
    ingr = allerg_ingre[a]
    write ingre$[ingr]
    if i < n_allerg - 1
      write ","
    .
  .
  print ""
.
call part2
# 
input_data
zdmhtpg mlcvjc kgdvd htxvfq lxgxp kqxz pfhfb fnkdvt ccn vhbjp hqhnh xcljh ndnlm shc ncrn nrdtprm skrxt qrdpc dcvtrq gdmv nxcrg hhxch mv dscm qzln zjlz qkbm dmjzc fjqv jqlp zcxthb sdclrlb bbtn jrspd lqbcg gdljd mvtkk zbhp hcc ntbqk lvft glj fsr hnh nvnx dvjrrkv fdqp lctltv hjn mknsj gtsslgk (contains sesame, shellfish, dairy)
gtdb nxcrg fzl gtsslgk sgdlhb fzckq mknsj kscd dgdn svzfl mlcvjc ntbqk ctkjrt gdmv tkvddn rzhktt zgcf jfm gzhlbn kphbtmkx mgbv pkrdz fsr drj lqgn tgkgj ndnlm zczht tlv qkbm ccn hhxch lgjsd dvjrrkv qfgbx rqxfdd hrtd ktsnt jmt kgfld mxm knfx kshg nhlxntg zdmhtpg qpp mv ssk tgxvz brjcp skrxt xjksh fsxf tpdc crjddsgj hcrsbr bgc jqlp dmjzc hxgdp xcljh xjqkbq hnh bsgnsc gqkf bzlnnv jjmmn gbmv zdqd zbhp (contains dairy)
hxgdp nkgzzg tgxvz tgkgj hqhnh fdjrml gnnzj fsxj zbhp rqxfdd ndnlm fsr nrgn hhxch gnq sgqrvd sm qjktms jjmmn xcljh qzln jqlp nxcrg bsgnsc jxftql lxgxp kgfld jmt ntbqk kvqq fnkdvt gppfld flg kscd jjdgtt nvnx vhbjp nhlxntg zkhpc bgjcg tpdc jkgf tnvtm rnln mgbv nrdtprm cntfq brhmkh rnsqjkq mv dvjrrkv crjddsgj mxm nqbjlf pkrdz xvzlpx dmjzc brjcp hcrsbr nkcl skrxt zfqhnt rglsgs pfhfb nsnzxsc ncrn fzckq rzhktt dcvtrq zgcf qgl (contains soy, wheat, sesame)
sgqrvd dvjrrkv qszr brhmkh znzx tkvddn mgbv kgpbh gtdb gdmv zjkt zdqd mhqxk cntfq hrtd sgdlhb lxgxp zbhp bgjs hxgdp rfcl lvft qgl ndvnj glj ptcnh xjqkbq zkhpc bgc rnln xntpsg xvzlpx zfqhnt xxbnf ntbqk tgkxxjm ncksb flg nrgn kqxz hkdls gqkf fjqv qpp krhmfb fdjrml tmlm tpdc rpqss qzln ckzg xcljh jdcbc kgfld ndnlm kvhbj svzfl jfm nrlbfc tkxxdnh fsr qjn lqbcg sdclrlb nxcrg gnq vchxzh rzhktt tvgcv (contains shellfish)
pfhfb rpqss bzlnnv vchxzh ctkjrt hjn ckzg hpsrqbl nzxs zcxthb jmt lqbcg ndvnj qbvxrbs dvjrrkv jvgbct zjkt ndnlm nrgn mxm xcljh rzhktt fnkdvt hcc knfx tgkxxjm hqhnh bhghks kgfld tkqp qgl tkvddn gzhlbn rglsgs jjdgtt kvqq gfq zmnflgt fsr qjktms ssk jdcbc kshg dgdn jfm gzthtlg mkmcq tpdc nxcrg mgbv xjqkbq qkbm qpp rnln zbhp chjqncr sm jxftql xjksh tnvtm gbmv tgxvz zczht tkxxdnh kssncfd ptcnh bdfmncs mvtkk rfcl zkhpc qjn xxbnf gdmv fzl lxgxp mhqxk (contains soy, dairy)
xjqkbq xvzlpx nqbjlf qbvxrbs gtsslgk bqjqf sdclrlb ccn qpp nsnzxsc zmnflgt pkrdz ndnlm bsgnsc zgcf zbhp tgkgj jfm lvft nrgn xcljh shc bpvmb ltjt jjdgtt dvjrrkv ckzg mgbv sm hxgdp fsxf nhlxntg kqxz kvqq gzthtlg pfhfb htxvfq nvnx jxftql lgjsd sgqrvd skrxt cntfq glj bgjs mxm bbxsn rpgrk tmlm fsr rqxfdd bgjcg qkbm fdqp hpsrqbl gppfld vchxzh svjp qjktms rnsqjkq nxcrg mv tgxvz krhmfb nxcsxc zcxthb hcrsbr qjn tnvtm qrdpc lvtj qfgbx fjqv rpqss nkgzzg (contains fish, wheat, sesame)
jdcbc prgj rnln zdqd zbhp cntfq mgbv gfq dgdn sm gdmv hkdls hnvhqczc ltjt ckzg skkt tkvddn lsll ndnlm flg nxcrg kgpbh zjlz dvjrrkv zgcf mhqxk gnq qgl ccn hcc hvrrhc bgc rpqss gqkf hqhnh nxbn bsgnsc lqgn gzthtlg xcljh jxftql nrdtprm bdfmncs bhghks kgfld zczht hrtd lqbcg rqxfdd bbtn dmjzc fsr mkmcq zkhpc (contains sesame)
nqbjlf dcvtrq cntfq sdclrlb kvhbj skkt jvgbct xjqkbq knfx lsll zdmhtpg hnh fnkdvt gtdb tgxvz xjksh gzthtlg bhghks qpp zgcf ptcnh mvtkk pfhfb jjmmn ktsnt kpzbxfp tgkgj glj rfcl fsr fsxf lqgn gppfld ssk mlcvjc mhqxk kqxz kshg jjdgtt tvgcv xcljh qszr prgj gfzjc jmt qrdpc hhxch bgc mgbv zbhp kssncfd nhlxntg hkdls bgjs gfq nxcrg hcc fdqp lpm jrspd bsdc nrgn dscm bzlnnv bpvmb qjn nkgzzg rglsgs fjqv xvzlpx xxbnf qjktms xcsxh lqbcg bdfmncs qbvxrbs nkcl skrxt hxgdp ndnlm vhbjp nxcsxc flg nxbn kgpbh (contains soy, wheat, peanuts)
zjlz jdcbc nkcl rpqss gqkf lsll flg zbhp ltjt jmt fzckq rnln mknsj ccn qkbm chjqncr lfgh bsdc bzlnnv bbtn fsr skrxt kvhbj hpsrqbl kgdvd lpm dvjrrkv ptcnh tnvtm sgdlhb rfcl gtdb tvgcv rpgrk mkmcq hvrrhc qjktms bsgnsc zsggkm pvnr shc zcxthb lhcm bqjqf fzl rnsqjkq lqgn brhmkh jkgf mv xntpsg mgbv fdjrml dgdn mhqxk ktsnt xcljh qfgbx tkvddn xjksh lqbcg pkrdz brjcp bbxsn (contains fish, peanuts)
xjcvt kgfld gbmv fsxj bqjqf qgl rnln hcrsbr nxbn zcxthb zfqhnt skrxt tgkxxjm dscm hkdls dvjrrkv lvtj gdljd zmnflgt pkrdz xcljh bsgnsc zjkt zkhpc xxbnf tpdc znzx tgkgj qszr bbxsn qfgbx rzhktt rfcl xcsxh ctkjrt bgjs mhqxk mgbv qrdpc ktsnt jjmmn fmcnhq tkxxdnh jrspd qkbm qpp qbvxrbs kshg prgjph skkt mvtkk ncksb hpsrqbl kphbtmkx dgdn ncrn fnkdvt dcvtrq mv nrdtprm kvqq zdqd gzhlbn drj vchxzh fsr nrlbfc zsggkm tlv bgc sgqrvd lctltv mlcvjc lsll hnnmrxh lfgh bgjcg ntbqk htxvfq rnsqjkq hrtd bhghks gtsslgk dftg lqbcg jqlp zbhp qjn bdfmncs (contains peanuts, sesame)
zkhpc lpm fdqp kpzbxfp hkdls mlcvjc bgjs qckqc ndnlm skrxt zdmhtpg dgdn nkgzzg qjn tvgcv brjcp bsdc kshg kgdvd xcljh crjddsgj jvgbct glj xjksh xvzlpx shc mxm gzhlbn ctkjrt ckzg fsr rnsqjkq mgbv rpgrk zdqd rnln gdljd dcvtrq fjqv fmcnhq svzfl fdjrml hrtd dmjzc nxcsxc sgdlhb mhqxk jdcbc qzln dscm zbhp bbxsn fnkdvt kgpbh zjkt tgkxxjm lhcm ptcnh skkt jqlp mv nrdtprm gtdb htxvfq cntfq tnvtm lqbcg (contains soy, nuts)
ntbqk ccn pkrdz krhmfb hkdls kgpbh bhghks bqjqf hpsrqbl bpvmb fzckq nhlxntg pfhfb xcljh bzlnnv nkgzzg cntfq zbhp jqlp ndnlm tlv qbvxrbs nrdtprm gdmv ssk mgbv gdljd dvjrrkv bsgnsc tpdc rnsqjkq znzx flg fsr zlfm zjkt nvnx glj knfx lqbcg hjn (contains wheat, sesame)
qjn sgdlhb rnsqjkq gdljd dvjrrkv nkcl jxftql kssncfd jvgbct kgfld bgc nxcsxc ndnlm nrdtprm kpzbxfp fsxf gnq vhbjp nvnx hvrrhc tgxvz nsnzxsc tvgcv xvzlpx prgjph kqxz fsr hnnmrxh lqbcg hkdls glj ctkjrt zdmhtpg qszr nhlxntg gqkf tlv hxgdp nrgn ndvnj qckqc xntpsg ltjt rnln zbhp gdmv xxbnf hhxch fnkdvt knfx xcljh kgdvd bdfmncs gfq lpm mkmcq skrxt hnvhqczc krhmfb dftg gtsslgk gzthtlg flg zgcf zkhpc brhmkh pvpfn ssk dgdn bsdc jdcbc (contains fish, sesame, dairy)
bpvmb jvgbct nrgn zbhp dvjrrkv bqjqf mkmcq xcljh fsxf mknsj kssncfd lqbcg skrxt tvgcv xbdhth tkvddn nrdtprm mhqxk chjqncr ndnlm lctltv hnnmrxh rpgrk ccn rnln jdcbc gdljd dmjzc svjp lsll bdfmncs rnsqjkq qgl prgjph hqhnh xjqkbq jjmmn hcrsbr xcsxh drj cntfq fsr bsgnsc rfcl pvnr flg tgkxxjm zczht shc (contains soy, shellfish, sesame)
mlcvjc prgj xntpsg pfhfb gtsslgk nrgn kvqq lhcm fmcnhq qgl nrdtprm hcrsbr tgkxxjm lctltv fnkdvt hjn tvgcv prgjph zjlz rpqss bzlnnv zbhp dftg mkmcq tnvtm rqxfdd mknsj fsr xjqkbq pkrdz dscm gdljd nxcrg sm svjp ndnlm zlfm bgjcg rglsgs lvft mhqxk kpzbxfp lpm rnsqjkq ccn skrxt gqkf mxm gzthtlg dmjzc flg tkqp bgjs qpp bsgnsc cntfq skkt gtdb lqbcg xcljh gnnzj hqhnh jjdgtt gfzjc zgcf brhmkh sgqrvd dvjrrkv (contains shellfish, sesame)
dvjrrkv ccn lqbcg lctltv jvgbct tkqp hxgdp lhcm zsggkm bgc qjktms zjkt nvnx nxcsxc kqxz skrxt bhghks gzthtlg chjqncr htxvfq mv rnsqjkq sgdlhb crjddsgj rglsgs nrgn ndvnj ltjt hhxch xcljh hrtd fmcnhq nkgzzg dscm ncrn zbhp mgbv prgj pfhfb tgkgj hpsrqbl kscd lxgxp bbxsn gdmv tgkxxjm glj nzxs tpdc fsr tmlm lgjsd bsgnsc qjn rqxfdd hqhnh cntfq (contains fish)
hpsrqbl brjcp qpp shc tgkxxjm bbtn xcljh gbmv znzx jkgf zcxthb jjmmn zczht bgc lvtj drj rzhktt tkxxdnh tlv dcvtrq nsnzxsc hkdls tvgcv dvjrrkv qkbm knfx zjkt mhqxk bpvmb ckzg bgjs gfzjc bhghks gtdb nzxs gnnzj sm jjdgtt zjlz rnln xjqkbq ctkjrt xvzlpx xntpsg htxvfq tmlm zdqd lqbcg fsr ndnlm rfcl kgdvd skrxt mgbv hhxch mknsj hxgdp fjqv ssk qszr hqhnh xcsxh chjqncr dmjzc crjddsgj prgjph dscm sgdlhb hjn cntfq bsgnsc qjn nvnx sdclrlb jqlp ncksb (contains sesame)
fnkdvt nxcrg sgdlhb kshg glj jvgbct tlv lgjsd qbvxrbs tgkxxjm xcsxh jfm fdjrml mgbv kvqq xbdhth fsr rpgrk qkbm hjn rfcl dftg tkxxdnh mhqxk nsnzxsc zgcf dvjrrkv fzckq prgjph lqbcg skrxt bgc hpsrqbl lsll tmlm bgjcg gtdb nvnx qszr lxgxp zbhp hcc tgxvz xjqkbq nxbn fdqp zdqd xxbnf fsxf ltjt ptcnh xcljh tkqp tkvddn nrlbfc jqlp jrspd (contains fish, peanuts)
nzxs ckzg nrlbfc nsnzxsc xbdhth pvpfn tvgcv tmlm mvtkk ncksb mhqxk ltjt zbhp fjqv rfcl tkqp lpm gzthtlg hkdls hcrsbr qckqc bhghks qgl kvhbj nkcl jmt lhcm bgjcg flg nqbjlf kvqq kqxz xcljh nrgn pvnr bzlnnv lqgn gnnzj bdfmncs ccn lvtj xjcvt dvjrrkv jjmmn qrdpc ntbqk sgqrvd kscd hcc cntfq gnq tgkgj jxftql jrspd fzl fsr lqbcg qkbm mgbv brjcp bgjs gtdb drj qjktms bqjqf hxgdp skkt prgj kssncfd xntpsg hhxch fsxf hqhnh qpp nxcsxc jvgbct qjn lfgh ndnlm mknsj zjkt mlcvjc lgjsd (contains shellfish)
qgl rnsqjkq hnnmrxh lsll nkcl fsr qjktms ndnlm krhmfb rpgrk xcljh jfm lfgh xntpsg skkt gdmv dvjrrkv zbhp kphbtmkx lhcm vhbjp mgbv zsggkm fsxf ccn nrgn nrdtprm bpvmb znzx bbtn dgdn bhghks zjkt svzfl jjmmn tlv bsgnsc bgc qkbm skrxt bgjcg fdqp ltjt rfcl bgjs rnln gtsslgk zjlz (contains wheat)
nhlxntg hqhnh qfgbx kssncfd zkhpc bdfmncs zcxthb drj sgqrvd lqgn rqxfdd hvrrhc prgj tgkgj nrdtprm skrxt jxftql fsr xcljh qpp shc zbhp qjktms zsggkm ccn chjqncr znzx pkrdz prgjph ntbqk ndnlm nrgn kgdvd tkxxdnh tpdc dvjrrkv qzln knfx nkgzzg rnsqjkq kpzbxfp bbtn tkqp mgbv rzhktt lhcm rglsgs fdqp fmcnhq gzthtlg nvnx ssk bhghks kvhbj hhxch tlv fnkdvt htxvfq zfqhnt xvzlpx lpm qszr hnnmrxh hcrsbr jqlp nsnzxsc (contains dairy, peanuts, wheat)
gfzjc hhxch rzhktt gtdb ssk zbhp zfqhnt jkgf tkqp dvjrrkv kgpbh mknsj bsdc lgjsd mgbv zcxthb hrtd nqbjlf mlcvjc hxgdp tgxvz gqkf fmcnhq tpdc lxgxp hcrsbr znzx zlfm fjqv kvqq nhlxntg zjlz brjcp zkhpc skrxt nrlbfc jdcbc qfgbx svzfl fzckq kgfld prgj gzhlbn lhcm qkbm fsxj hqhnh kscd vhbjp fsr lsll qbvxrbs gfq tnvtm lqbcg nkcl ndnlm sgqrvd xjqkbq (contains wheat, shellfish, fish)
gdmv bbxsn kvqq hnvhqczc lqbcg xjqkbq jvgbct mlcvjc gfq jrspd lxgxp jkgf tkvddn bsgnsc lqgn xcljh fsxf qjktms dscm mgbv fsr ndvnj nrdtprm jjmmn xvzlpx nkgzzg rnln nxcsxc zjkt sdclrlb nhlxntg kphbtmkx gnq zbhp fzckq zlfm hvrrhc zsggkm xcsxh ntbqk skkt jdcbc bgc bsdc prgj shc nzxs bpvmb hcc ncrn xjcvt nrlbfc jqlp ktsnt nvnx gnnzj tkqp nxbn ndnlm sgdlhb bqjqf kqxz qzln zjlz tkxxdnh bdfmncs kpzbxfp hrtd fzl skrxt sgqrvd zdmhtpg dftg fnkdvt lgjsd mv (contains nuts, fish)
nxcrg jqlp xcljh nkcl qjn rpgrk xbdhth vhbjp kqxz zfqhnt nrdtprm ltjt tkxxdnh rqxfdd fdqp bsdc gzhlbn bpvmb ndnlm bbtn skrxt jdcbc fmcnhq pkrdz zsggkm rzhktt ccn gbmv ncrn rglsgs dmjzc sgdlhb prgjph lpm zcxthb dftg qjktms pvnr hnnmrxh kssncfd bdfmncs bhghks lhcm lgjsd ssk bgc fsr gfzjc rnsqjkq zbhp lqbcg krhmfb mkmcq zlfm brhmkh xntpsg hnh bsgnsc dvjrrkv tvgcv sm fdjrml prgj hhxch tpdc fsxf nkgzzg nzxs gnq tmlm (contains dairy)
nrlbfc nxcsxc jvgbct dvjrrkv prgjph gqkf ndnlm lhcm mvtkk xcsxh gtsslgk mgbv kgpbh zbhp qbvxrbs kshg gfq ktsnt bbxsn hjn jfm jxftql jmt xbdhth xcljh zmnflgt kgfld nrgn fnkdvt fdqp skrxt svzfl bgjcg sgqrvd ssk svjp sgdlhb vchxzh kgdvd dgdn xntpsg tpdc zjlz zgcf rnsqjkq zlfm chjqncr tmlm dftg tgxvz jkgf lpm hcc qjn tkxxdnh lqbcg kscd lctltv pvnr ntbqk lsll qszr mv hvrrhc fjqv (contains wheat)
vhbjp fsxj jxftql tkxxdnh nzxs fnkdvt fmcnhq lgjsd chjqncr xcljh brjcp hrtd kssncfd ssk mgbv xvzlpx bgjs rpgrk kgfld gbmv ndvnj ccn rnsqjkq xjksh ncrn brhmkh lxgxp qzln zdmhtpg tkvddn lsll nrgn pvpfn lqgn nxbn lvtj dvjrrkv dscm bsdc hqhnh mxm fsr nrdtprm skrxt nhlxntg tpdc mkmcq bqjqf lhcm hxgdp jkgf hkdls fsxf jmt fzl kshg xjcvt lqbcg jdcbc flg rnln ktsnt zbhp gqkf kphbtmkx rglsgs (contains wheat, sesame, dairy)
fmcnhq prgjph jdcbc gtsslgk xcljh fsr zdqd hnh bzlnnv krhmfb mknsj nrdtprm kgpbh lpm tnvtm zbhp fzckq xcsxh lvft hqhnh hcrsbr jfm bsgnsc qfgbx mgbv lsll qjn hrtd tkvddn sdclrlb dscm lxgxp jjdgtt kqxz zjlz tlv xjksh fdqp ptcnh rglsgs dvjrrkv flg ntbqk bsdc xjqkbq gdljd jmt zjkt gdmv fjqv nxcrg zczht bbxsn nkgzzg zmnflgt skrxt ndnlm brhmkh glj zfqhnt tkxxdnh gqkf (contains peanuts, shellfish)
svzfl bdfmncs mlcvjc xjksh fsr shc ssk mknsj tkqp znzx hqhnh zdqd jjmmn svjp ndnlm lctltv tkvddn bzlnnv jrspd kssncfd zjlz pvpfn fdjrml tgkgj nrgn nvnx bqjqf hpsrqbl hnh rnln zjkt fdqp zlfm xjcvt gbmv tkxxdnh kgdvd mgbv dftg jdcbc fnkdvt tvgcv pkrdz zkhpc lqbcg jmt kvhbj nxcrg nsnzxsc gzhlbn zbhp gdljd skrxt skkt mv qjktms dvjrrkv (contains shellfish)
zjlz gzthtlg vchxzh zfqhnt dftg bdfmncs ndnlm dvjrrkv vhbjp shc znzx fdqp fsr svjp nrdtprm tgkxxjm zbhp nxcsxc ndvnj jjdgtt qjktms mhqxk skrxt rglsgs pvpfn xvzlpx jfm prgjph mlcvjc fmcnhq gppfld tvgcv qszr pvnr bsdc bqjqf jxftql hpsrqbl qjn zkhpc qzln crjddsgj lsll bgjcg fdjrml tgxvz ssk lpm brhmkh zczht zcxthb jrspd ltjt lxgxp lqbcg xcljh dgdn gdljd rfcl rqxfdd tpdc (contains nuts, sesame, dairy)
qjn nrgn pvpfn bsgnsc xxbnf jvgbct pfhfb lqbcg zsggkm xbdhth lvtj xcljh tlv lsll lqgn nrlbfc qckqc hrtd shc sgdlhb zcxthb ssk bdfmncs hkdls tnvtm nxbn jfm hnnmrxh dvjrrkv skrxt jdcbc ndvnj jjdgtt jjmmn gtdb hjn tmlm gdljd ndnlm nhlxntg hnh kpzbxfp bgjs fsr jqlp qjktms zczht rnsqjkq zbhp vhbjp brjcp (contains wheat)
hqhnh fsr zbhp nrgn zlfm ndvnj nkgzzg kgdvd ssk qckqc sdclrlb ptcnh bpvmb brhmkh dvjrrkv rpqss fnkdvt lfgh gdljd tvgcv nxcsxc dmjzc fmcnhq qzln sgdlhb qjn zmnflgt vchxzh tkvddn xcljh dgdn bgjs hhxch pfhfb lqbcg kscd lhcm nrlbfc pkrdz htxvfq skrxt znzx ntbqk hkdls ktsnt bzlnnv rnsqjkq ndnlm sgqrvd tlv hcc zjlz gzthtlg jkgf svzfl tkxxdnh pvpfn nxbn ccn gzhlbn rqxfdd qfgbx rnln bqjqf qrdpc kgfld hnvhqczc gnq knfx tmlm nvnx zdqd zsggkm hjn jqlp gqkf bgjcg fdjrml (contains shellfish, dairy, sesame)
dmjzc qgl jjmmn mgbv qjktms qszr zlfm kgfld qkbm xjksh hnvhqczc xjcvt fsxj hjn fjqv rglsgs zbhp ccn kshg bsdc pvnr bgjcg nvnx hnnmrxh cntfq rpgrk gqkf shc nxbn qrdpc jrspd ktsnt brjcp dvjrrkv tgkxxjm jkgf kgpbh kgdvd zfqhnt lfgh ncksb nrdtprm vchxzh fsxf zdqd kphbtmkx skrxt flg gtsslgk zgcf tvgcv dftg lpm nxcrg dgdn xcljh qfgbx nzxs gbmv sgdlhb gdmv jdcbc fsr zjlz ctkjrt xntpsg hcc tkqp ptcnh gdljd rfcl znzx hpsrqbl xjqkbq jfm lqbcg nqbjlf mlcvjc tgkgj xbdhth zkhpc kscd nkgzzg svzfl sm jvgbct htxvfq rnsqjkq hnh mkmcq (contains wheat, sesame)
rnsqjkq zsggkm jqlp zdmhtpg bpvmb svjp pkrdz fsxf tkxxdnh zczht dcvtrq ndnlm cntfq jfm nkgzzg rqxfdd nrlbfc bzlnnv mkmcq fjqv tpdc hnh gtdb nxbn bbxsn mgbv pvpfn ncrn qfgbx sgqrvd knfx xjcvt brhmkh tvgcv gqkf prgjph qgl nvnx hqhnh dvjrrkv lfgh mknsj qzln jxftql kscd gtsslgk kpzbxfp hjn xcsxh gnq dmjzc xjksh tgkxxjm gzthtlg rzhktt zjlz kphbtmkx fsr fdqp sm bbtn lqbcg crjddsgj shc zbhp rglsgs nkcl hxgdp rfcl kgfld qrdpc skrxt gdljd znzx drj mlcvjc (contains shellfish, nuts, dairy)
svzfl fsxj jjmmn chjqncr lqbcg mxm zkhpc rqxfdd gnq kshg zczht gdljd ndvnj fzl rfcl dftg qbvxrbs qfgbx ndnlm mlcvjc mgbv bgjcg bpvmb vhbjp htxvfq lpm nrdtprm hnvhqczc gppfld brjcp jkgf rnsqjkq fzckq rglsgs dmjzc skrxt nsnzxsc kssncfd xcljh zbhp tgkgj kphbtmkx dgdn fsr knfx zdqd jqlp zfqhnt svjp (contains dairy)
nrlbfc bgc hhxch lsll qfgbx bsdc hqhnh tnvtm gnnzj gtdb dmjzc fsr lqbcg hrtd kvqq lgjsd jjmmn xjksh ncksb jvgbct vchxzh ndnlm htxvfq zkhpc fsxj ctkjrt lxgxp gdljd mgbv sdclrlb hnh kscd gzhlbn zdqd flg ncrn ckzg vhbjp mv jfm ptcnh gbmv sm kphbtmkx hcrsbr rpqss skrxt kgpbh kssncfd lvft bgjcg zczht bgjs nrdtprm xcljh bpvmb qckqc nzxs kqxz gdmv bzlnnv ndvnj jxftql hkdls jkgf xjqkbq hnvhqczc lfgh prgj mlcvjc pfhfb zbhp dgdn qrdpc nvnx prgjph bdfmncs nxcsxc tmlm jqlp tkqp sgdlhb fnkdvt qjn fzckq bsgnsc qbvxrbs (contains shellfish, peanuts, dairy)
bzlnnv zcxthb ndnlm jrspd lctltv mvtkk zjkt hqhnh fjqv gppfld zbhp sgdlhb knfx qfgbx hkdls jqlp pkrdz jxftql kvqq zkhpc gbmv fdjrml sgqrvd fmcnhq dcvtrq hnnmrxh tpdc kscd skrxt bsdc qzln xcljh lqbcg pvnr rpqss qckqc shc rnsqjkq dvjrrkv qrdpc znzx mgbv ssk gtsslgk bgjcg kqxz pvpfn hnvhqczc ptcnh bpvmb bbxsn hrtd hvrrhc gnq bgjs nxbn nxcsxc tkvddn qgl ndvnj (contains shellfish, nuts, wheat)
tgkgj kgpbh brhmkh bbxsn rnln mgbv bpvmb pvpfn rqxfdd hrtd kpzbxfp gtdb bbtn dgdn gfzjc kshg ltjt flg nrgn qrdpc chjqncr jrspd nrdtprm crjddsgj bdfmncs bhghks ncksb hkdls zlfm dvjrrkv gtsslgk sgqrvd sgdlhb xntpsg zbhp dcvtrq lxgxp gfq kphbtmkx lqbcg bqjqf qjn zkhpc xbdhth qzln bgjcg jkgf ncrn nxbn znzx nxcsxc brjcp nqbjlf zdmhtpg tgxvz fsr nrlbfc prgjph gppfld qkbm xcljh rzhktt ndvnj ndnlm fjqv hvrrhc (contains peanuts, dairy, soy)
tpdc nkcl nqbjlf ncksb crjddsgj prgj htxvfq gtdb bzlnnv nvnx hkdls fzl dvjrrkv sdclrlb tkqp xcsxh bqjqf hrtd dscm pfhfb svjp rqxfdd hvrrhc nrdtprm mgbv xjqkbq zkhpc zczht rfcl fsr rnsqjkq zbhp nhlxntg ndnlm jqlp bsdc hjn ntbqk gtsslgk brjcp rzhktt tlv tgkxxjm knfx ssk xjksh nxcrg dmjzc kgpbh nrgn lvtj svzfl shc mlcvjc lgjsd gbmv kvqq mhqxk nxcsxc gzhlbn tmlm zcxthb zfqhnt qpp xcljh lctltv hcc kscd fjqv mxm qrdpc zdmhtpg kvhbj skrxt qszr ptcnh xvzlpx zgcf dcvtrq bbtn zlfm jjdgtt jxftql fdqp xntpsg (contains fish, shellfish, sesame)
fsr dvjrrkv ckzg zjlz cntfq hcc nqbjlf svzfl ssk vchxzh nkcl zbhp mgbv hcrsbr fsxj xcsxh ccn rpgrk bhghks qckqc ptcnh gdljd hxgdp qkbm mvtkk rnsqjkq rnln prgjph gppfld dftg mlcvjc gtsslgk bgjcg bgc jdcbc zczht lctltv gfzjc svjp xvzlpx sdclrlb skrxt qfgbx nxcrg dcvtrq shc sgqrvd tgkgj kphbtmkx fzckq bqjqf crjddsgj nhlxntg jqlp gzthtlg zgcf ctkjrt zmnflgt bbtn drj ndnlm rpqss lvft xcljh (contains shellfish)
pkrdz ndvnj znzx xjksh zbhp hrtd kscd kgdvd ctkjrt zsggkm fzl zjkt zdmhtpg xcsxh tkqp lqbcg kssncfd bbxsn bzlnnv mgbv kgpbh krhmfb nsnzxsc ssk prgjph fmcnhq lfgh bgjcg fsr bbtn brjcp kqxz nxcrg skrxt rfcl kvqq brhmkh qbvxrbs hpsrqbl lgjsd kphbtmkx nzxs ndnlm bsgnsc mv xvzlpx ncksb nrgn rpqss tmlm nkcl dvjrrkv tnvtm lpm xbdhth sgqrvd lxgxp ktsnt mkmcq nhlxntg (contains fish, shellfish, nuts)



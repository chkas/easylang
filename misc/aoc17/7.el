# AoC-17 - Day 7: Recursive Circus
# 
global name$[] childs[][] parent[] w[] root .
func name2id n$ . id .
  for id range len name$[]
    if name$[id] = n$
      break 2
    .
  .
  name$[] &= n$
  childs[][] &= [ ]
  parent[] &= 0
  w[] &= 0
.
# 
func read . .
  repeat
    in$ = input
    until in$ = ""
    h$[] = strsplit in$ " "
    call name2id h$[0] id0
    w[id0] = number substr h$[1] 1 len h$[1] - 2
    for i = 3 to len h$[] - 1
      s$ = h$[i]
      if i < len h$[] - 1
        s$ = substr s$ 0 len s$ - 1
      .
      call name2id s$ id
      childs[id0][] &= id
      parent[id] = id0
    .
  .
  n = len name$[]
  for i range n
    if parent[i] = 0
      root = i
    .
  .
.
call read
# 
print name$[root]
# 
done = 0
func bala node . wr .
  for i range len childs[node][]
    nd = childs[node][i]
    call bala nd w
    wsum += w
    if i > 1 and (wp <> w or wpp <> w or wp <> wpp) and done = 0
      done = 1
      if wp = w
        ind = 0
        w = wpp
      elif wpp = w
        ind = 1
        wp = wpp
      else
        ind = 2
      .
      nd = childs[node][ind]
      print w[nd] + (wp - w)
    .
    wpp = wp
    wp = w
  .
  wr = wsum + w[node]
.
call bala root w
# 
input_data
fjkfpm (69) -> kohxzh, liwvq, eqkio, xvoyybs
dsiixv (52)
fhimhm (66)
mdlubuq (73)
ulobwyb (41)
cbgnzhz (70)
hrheyzf (946) -> fixqj, msyvs, pdwjcd, tlgdija
yrnjhqc (31)
xlglga (714) -> hohft, funabvw, zhxnpoh, unpdcwm
hcvwov (240)
qnhvjec (35016) -> pimzjjp, ghatw, tbakk, olgmto, qeaqiuq, wnmnz, aabbf
efgdfa (405) -> uyedi, rxkmf, syhipz, zozcoqd, uwprsvh, dqhoh, rcbhgw
vofrtf (55)
gipbso (52)
cviwy (426) -> ildgly, syojg, tgoztyw, doavm
okzkfw (159) -> ndteuz, bkmepbs
ylfvgv (5)
ydxuhqe (72) -> bfftnj, uwrll, njlaepf, kbfpx
hwfcy (54)
iqtdzrh (65) -> qoppte, jcsqqxv
ddumyx (220) -> yjowio, gefjk
edagh (12)
kefudoj (82)
indjoox (36)
cliojs (35)
lrvmyj (79) -> fadkfic, pcikcq, fgeup
mvyzuw (73)
nholw (52)
sjbqzk (212) -> sijon, bcedyx
majskr (49)
qjutng (15)
iavwfbb (19)
ywonug (50) -> dgjyf, kobwktw
taxky (77)
lufkiy (44)
lcwqdxx (34)
felksho (204) -> vkile, ihadu, qfczh, wvgzlw, axawjtm, eutun, vkzmf
rvtus (94)
zjxjhwc (53)
bnmsz (95)
cvcyykp (31)
bfxvxpl (35)
niavkxg (16)
zwcsjgs (7)
gtqwrrx (44)
vszpkfs (107) -> rubvop, qsvjd
axawjtm (12) -> gtbocpw, oxlvr, mvfjras, vgyzdkt
ulvbf (82)
vkzmf (252)
jnedlwi (100) -> rkftwvy, gwyrtw
sztry (247) -> vddarvs, tlzlq
anwbrxk (69) -> ybnsg, rfwgt, pcppql
pfxoef (66)
ghqixh (171) -> cjcytbb, dmare
jwrmi (130) -> mhrzazo, qeuwgn
umsrz (7) -> jwrbg, wqpahuv, zquvn, sfjyf, uebmnqa, qqkqhzb, gmbup
wtsqx (46)
rzldn (31)
usmtdk (166) -> pikelbw, edwlns
pyhecs (59)
shwsf (56) -> wtbst, ryjqaz
jhkkrg (63)
eaagt (40)
wkbqm (59)
iivwxhd (150) -> yfgyi, grdimrp
nlkwsrn (50)
idnsypp (94)
aixwgk (41)
yhhnavm (84)
lngdxkd (146) -> hkkzpzh, ihvfxeo
dkwwoa (73) -> sntbr, xbywgft, xlkvx, akght
jevqne (8)
vurnn (81) -> fkehyrg, qhktzou
ngoog (20) -> uusec, rrnkqx, jafsqqu, ryeiot
hxhguzh (75)
kohxzh (1765) -> mjpmw, cbmkr, vmofl, wsjizsy, redeub
twpvnu (56)
kzumm (132) -> czgxag, vytlfm, qowepn
fgnye (44) -> pxcjw, bnmuprs
jvqfj (60)
yvllxxw (55)
hsmaze (34) -> fxzqvoh, fcvsqp, okzkfw, vwtsdsf, ipbbnp, txdprek
aujdy (14)
yjcevge (61) -> rpyxxhm, tfbqaoe
blcpm (217) -> qibrsjj, wcfykko
pfltnc (44)
anqas (63) -> riuwg, jhkkrg
rtseps (51)
vmkfcpw (92)
pcppql (78)
tqrqs (43)
syxdt (12)
ejlecie (79)
xpdmegi (16)
dgjyf (62)
uxhpm (51)
znchnta (66) -> sutzt, kvjyw, hlshpkq, corcne, rflrj, yhadh, ouypz
zmdvl (50)
fixysjm (1386) -> zjylql, ytadaxm, fgnye
yevywe (63) -> qeayjnt, ixyeq, hgaoiz, rcfaaml, zuzhmf
rxkmf (811) -> yedvssr, xvwgxm, wfeurd
mcmzs (53)
vsmdkp (60)
oyurf (27) -> zhjtcdl, jswxshd, hfwpcsa, lbvfwz, obolmhh, grgkv
yawmlbb (191) -> iavwfbb, xjjvneg
fblsn (44)
doavm (223) -> drasjw, cwwwcge
udyivld (18) -> osrdt, jpyojky, vhnnnv, gyxqc
ddqnllo (167) -> cdfij, quohxia
bwbym (55)
ufpdyq (22)
hkjcnv (73) -> nderndc, owjtoo
ndhravs (10)
qjkkohe (25)
jrott (44) -> jgylf, kaitdu
unvqq (173) -> lxdji, ldkojcj
zrgqfb (81)
csbgxs (29)
qeaqiuq (1106) -> nwlkk, ytyhmux, nxmtm, izpta
rqeftjw (51)
tbakbq (62)
vnhhu (62)
grgkv (85) -> xgmrufk, cvvkno
pggrr (29) -> bttvl, zrmzpo, upatvy
zumdwwu (43) -> jfssr, aujdy, adkyx, mragx
euxvn (105) -> qtazfdw, uzarat, mikalda
tpbcg (98)
kdnwlnz (36)
pncda (183) -> uswszht, zeebqts
zlvjnx (130) -> vctupmx, gmxdpc
iljdm (203) -> emqwt, leknm
lmgxknk (49)
pikelbw (34)
kqqegw (89)
eigsdc (20)
qbhvu (94)
kqoae (61) -> tqrqs, bfozr, kkqeg
bozfw (5)
silwwua (20867) -> kzocw, ymhsa, mzcebu
fcxninx (473) -> pmxzfd, kbvzpv, zskam, oyurf
ihvfxeo (14)
rkftwvy (52)
kccra (26)
vkxbeox (353)
suiagk (59)
lnqzgti (60)
leknm (50)
yxvmxzg (35)
jezubi (54) -> lnqzgti, hvsiuf
bzqhk (33) -> ndmpgss, kcoayj
xaovjvs (74)
mjuyo (263) -> psrup, boeuyxx
tvoptyn (1776) -> xjbtfms, tiphry
jbhohbx (25)
kqfgnql (22) -> pmozz, hspqr, ydxuhqe, txhxoib, cncoep, ripidvx, qezvrjl
pdkfixk (22)
kxzwel (80)
sykmuwo (243) -> zvogn, esmbu
livul (40)
rvmntl (346)
xqztuq (24) -> pyhecs, jqgkz, bsythck, ranlxct
edyohkw (79)
hszzxp (64) -> xcdswr, oukuy
yfgyi (56)
pmozz (74) -> ngaawt, oaknu, cgbkrnc
tfglbeh (56)
wpvozgo (53)
njaig (77)
jwrbg (134) -> fymyi, utpyp, ulxscm, cliojs
olnfe (33)
jcsqqxv (52)
fvkew (21)
nkdbmjv (34)
fhjgv (55)
tvqlaw (14)
wqpahuv (274)
myoyl (82)
pjzcs (38)
pcehxbx (1859) -> hlfmvdt, ngoog, mwhraq
kqohkg (56) -> hezkdc, kgfudu, omeew
adtpk (1655) -> unvqq, bpbwl, anqas, kmnzz
afihdk (65)
rtiaapt (18)
obolmhh (109) -> lufkiy, kiryhz
dkegbrt (45)
rbiarxk (81) -> erngeah, cqcjys, bxjqibv
hmrzqlh (87)
biemun (295) -> ejbtu, hszzxp, kcxiq, khixwdd, usmtdk
mvfjras (60)
uqktn (246) -> gtqwrrx, qtshuo
kmpmdb (8)
lylxk (22)
nxmtm (84)
goapac (88)
zlxlwv (43)
nirov (74)
fcjjqev (78)
finxtiu (92) -> vgdsszs, gofjvi, mxpvph
uvpwrf (73)
vgnkq (104) -> jczkx, iydqii
gsbmh (84)
ssblis (86)
knvxq (1845) -> pvbgvb, mcghosj, qocnylk
kvjyw (57) -> livul, eaagt, rukzsa, gsdzpjh
zhpdhat (76)
ypjnmr (39)
yauryvu (97)
ucahbv (82)
rkswk (70) -> kccra, lqasevp, bdvtnul, swqres
bqvtbsr (39)
cmfcqh (149) -> wlwnand, zikmmr
ouypz (67) -> mxelfv, fogmaih
nlrbcxx (41)
mrmuat (21)
kcxiq (150) -> mdvnu, dcwcs
aabbf (881) -> dsoyvp, hwraaxu, lrvmyj
mjxfsc (53)
dmare (55)
iruee (89)
gpsnzs (76)
wnpkwy (27)
zvnzep (174) -> tvqlaw, aufxtq
yysyjbk (1630) -> wpvozgo, mjxfsc, iality, vwupkmh
cgbkrnc (62)
mnfknb (41)
kcoayj (89)
vybmch (79) -> ebyfpmf, dnqdmxc
lmrzi (87)
tiyvea (30)
pcikcq (36)
mlqoz (20)
brmvw (144) -> qjutng, janbnmh
zgkxkj (72) -> bwrpc, wntfmtn, hwjmzs, vkxbeox
gzcbv (54)
nsqpaq (55)
hohft (69) -> hfjtksr, efzjseb, ypjnmr, bqvtbsr
kkqeg (43)
gafjq (74)
haano (296) -> rlburl, njkvleo
tvbmh (99)
fvsitx (212) -> nsvwcl, hohrape
yhtpdwu (71)
qxsjs (95)
qseqsgt (22)
vkhdfmv (36)
ikicwez (69)
tdrdq (24)
bgudw (94)
zhjtcdl (134) -> ceutto, fhynmi, qmyohe
pavtnxe (38)
xvoehjz (301) -> zznjih, wseim
klfyu (40)
zhxnpoh (119) -> ltyxiwk, wkgouh
bezoxx (184) -> afihdk, jevfpj
ivldghm (64) -> enmxpmj, wsrrryh
osnpbou (111) -> zpuktmx, itlno
uofuvf (70)
mgvcyl (51) -> nsqpaq, fhjgv
lluabej (97)
hwjmzs (273) -> agsfbkx, znswber
udlhalx (26)
gewlsr (476) -> uqktn, nknpwkc, udyivld
fsjvyxv (27)
birtjxh (78)
eplltu (84)
sdixs (54)
kqdseyh (46)
lfrfa (76) -> ejlecie, mvxud, wgevvca, carfsnj
lbwgsap (33) -> gpsnzs, santsu
pnjtt (45)
rcfaaml (157) -> avemxf, ehwcxy
tbutks (36)
xmhdsio (91)
byjcsn (51)
amslmyk (96)
jtdvzj (62)
xnaam (88) -> lylxk, sybcl, kuqsuy
boeuyxx (53)
pxcwhq (30)
mckyvtt (52)
pctkyat (25)
lomxh (53)
ltccbob (297) -> ndhravs, qlryl
vgyzdkt (60)
pyzbqz (74)
cjkieim (519) -> myeecwt, agtab, rhtqj, mmriyf, mfcutqz
ducdc (41)
mnxoac (30)
umtmwow (30)
qsxqwub (94) -> klfyu, mlzfw
pdwjcd (105) -> vcoszdq, fkmpv
wifaf (41) -> dnunil, gafjq, gwgchq
tpabsyz (91)
uwrll (47)
dcjiqny (1371) -> npblyaq, qeoetnp, qoeviy
rlburl (9)
itlno (37)
ehpdfno (285) -> bcrso, jqwaifx
njkvleo (9)
uswszht (24)
qvpou (180) -> sndject, bzmhwwo
ngaawt (62)
kyhezqn (45)
arouwsi (59)
uyoez (99)
quoqibc (195) -> znuldtj, bljppq
tiphry (33)
lbvfwz (89) -> qypsl, gzcbv
bzmhwwo (5)
tcbxnrf (285) -> ybgdelp, aqrpio
arjgn (392)
qfczh (218) -> ivhtlxa, jdazgj
jpyojky (79)
zinjsj (30)
qfsmgqe (982) -> mgvcyl, cekchxh, qnscg
mlzfw (40)
ulszlax (42)
myeecwt (69) -> veiljb, wydtqax, pnjtt, sxwbzyj
vkuucpv (260) -> fenymdp, uwehdau
qezvrjl (212) -> jdqhjk, htwzu, lzevbng
qnscg (161)
wkkkv (11)
bpbwl (149) -> mlqoz, miwjfr
icspwbg (83) -> iljdm, sztry, anwbrxk, ddqnllo, gtbmrcp, cpzwgk
bddlvs (70)
mragx (14)
vdyhna (166) -> glori, azttml, jxraf
zjylql (78) -> fsoqc, hefjuue
jdqhjk (16)
etkzf (11)
grdimrp (56)
tlics (101) -> twpvnu, tfglbeh
kskkjn (1081) -> uxmjgh, kqoae, wswwck, zwymlsj, qvpou, mtxzek, elxccty
qsvjd (31)
uurqa (33)
gytzi (18)
xsvage (27)
gefjk (21)
vpbec (263)
mocpa (79) -> ldvcrw, atxfply, ogtxa, rbbkdj, blcpm
wsdqchf (71)
zznjih (11)
ryjqaz (73)
hspqr (66) -> hjxzwnq, ojrixty
phkzo (263) -> licst, nbkzscx
haayebg (39) -> ogziig, pyscsi
kbdnbnd (94)
ioyealn (51)
nuoic (20) -> pmssap, bzuago, tvbmh
kuqsuy (22)
hvsiuf (60)
werskvv (78)
hohrape (90)
sybcl (22)
ksnxlcl (117) -> sdjxpp, yzpyzu, ulobwyb, afbnq
qlchz (5277) -> doxfeq, luiiv, hsmaze
ihadu (144) -> dquqam, ctvrea
dquqam (54)
pjamo (113) -> vnhhu, jtdvzj
xeypnpr (183) -> qiund, kdnwlnz
loaft (59)
loykzr (16)
bsbsdiu (81) -> ssmhkwq, alolk
efzjseb (39)
lbkrk (17)
ipbbnp (127) -> iauetan, tbakbq
uilvahq (1076) -> oztxjfl, oiufrau, ewyrp
gmbup (274)
gldvef (18)
evvfcyi (13)
nbhdty (97)
ncbrxsy (15)
dnunil (74)
zcggn (56)
mbcwjt (225) -> wxyaqte, kpffozq
vgkjgy (16)
bcnqhw (298) -> ohqivu, jzwusi, jzcstbe, xayqwyj, kmwkft
gyxqc (79)
ripidvx (148) -> rergyy, rwhjmp
mxpvph (67)
iauetan (62)
voawog (34)
mzcebu (11) -> rlgrkq, xlglga, hrheyzf, gbwfjf, mhkrny
sexuv (92) -> ednlrw, zcggn
fezoyaj (78)
uxmjgh (70) -> mnxoac, pxcwhq, ytjheqk, tmtfhr
tvfptpz (73)
rywggm (78) -> gxuovng, ragcph, epstabj
ymhsa (7457) -> zzqtmxd, yfwwrkp, yahzcyp, hmugaom
ygvvvq (392)
izssdb (215) -> ycseeag, ytzdrvj
bttvl (95)
abjmd (30)
mspxpr (1837) -> fvhvq, guvto
enogehk (45)
cqcjys (44)
rfllomn (107) -> lqndkq, tzkgrjf, lcius, lhlgijf
wvdswpz (34)
ocqrpkf (46)
oaknu (62)
qvrtwdt (1289) -> jnedlwi, sexuv, vcauqo
prnno (95)
wgjst (177) -> bozfw, salxel, jrrhzc
teapi (35)
adkyx (14)
huxtvqc (16)
mznsk (11)
fcvsqp (183) -> ebjgfh, bnvjfq
iwkotv (89)
mkykc (90)
dlrznye (83)
gtxdtf (42)
ahism (144) -> gkitfsr, osbndxb, zielffk
znztzxd (29183) -> jcsjaxj, hrwtz, fcxninx
jsbug (85)
kfkhxg (51)
tcpvyfj (18)
fpdoney (16)
kfefhun (27)
iufvcm (38) -> xjejd, goapac
fzltz (8)
rukzsa (40)
doxfeq (154) -> kzumm, vurnn, fzbwmsz, bsbsdiu, pncda, rtromur
dfrzb (53)
rpbeiqg (170) -> qseqsgt, qmeawpu
ycseeag (28)
blfinsi (52)
kvsprca (65)
uzarat (35)
zzlocxd (62)
iality (53)
daxbf (805) -> iktev, xqztuq, bsvoy
hfjpir (19)
bsiwtqq (58)
qnepf (88)
dasmiiw (56)
wseim (11)
lvgrmfu (180) -> ngiol, iwidsj
nsoju (38)
zqaxyz (59)
qocnylk (41)
fhynmi (21)
xeege (12)
mfslhp (95)
alolk (75)
qtazfdw (35)
sijon (37)
zzpevgd (17) -> smqtcaj, emxwr, uezxhid, blvyrzh, lvgrmfu, vkuucpv, eivaf
glori (15)
ssmhkwq (75)
dmkhzgg (149) -> fuwekd, bwbym
xqrrpu (29)
yjowio (21)
mhrzazo (36)
jakmbx (39) -> egyfwny, khdzsr
qzgdlb (33)
lwysj (49)
czgxag (33)
drasjw (20)
pxcjw (41)
hwfzj (321)
ssxqkhq (67)
ndteuz (46)
rwhjmp (56)
xsuxhbq (1268) -> injlqnw, vdyhna, bzqhk
aufxtq (14)
nknpwkc (164) -> pwyfdan, jsbug
dqhoh (787) -> xeypnpr, quoqibc, wisdd
lqndkq (54)
vabii (89)
pmxzfd (747) -> xnaam, iaoxdmm, hsywhj
fuexyx (8)
wkxyxtf (20)
bfftnj (47)
hoqti (6514) -> jviven, znchnta, daxbf
aqrpio (24)
otsyp (54)
vgdsszs (67)
lswutyd (60)
egyfwny (73)
wyiec (56)
qeayjnt (31) -> qbaig, yhhnavm, eplltu
tjzkwy (59)
vwtsdsf (251)
jzbnq (78)
gtbmrcp (303)
pzoaqn (94) -> ierop, llepsqz
oqfiqf (185) -> nirov, pyzbqz
kjtwz (97)
gmrkqq (86)
nnkru (16)
nnpvdm (5)
rlgrkq (9) -> uakxuru, qvzjgne, xhrqzk, xatzz, hwfzj
oukuy (85)
gsiokvq (80) -> tcbxnrf, mfunt, tyqnwi, yzxqqx, ehpdfno, oqfiqf, clizzo
qluzb (58)
bzorz (66) -> ulgrn, kjmvhpa
iqckb (103) -> zuaamot, knfath
zikmmr (87)
ugplhkq (58)
vddarvs (28)
agsfbkx (40)
riuwg (63)
mmprixv (66)
pimzjjp (58) -> dresofi, riogonj, encjlzj, rvmntl
eiekcd (66)
gxuovng (38)
vfdulx (6) -> bhnwdot, qxqdyx
iizpgi (84)
ctvrea (54)
qscadxk (28) -> hrrqb, yxfmelm, roojn
qxqdyx (50)
vmkib (527) -> ltccbob, lvktp, nuoic
mwpejh (82)
gwgchq (74)
hjxzwnq (97)
wisdd (75) -> vsmdkp, vzxet, jvqfj
bsvoy (260)
pmunsu (17)
kbvzpv (24) -> vybmch, nkwisjd, ihkcorh, bmyme, pjamo
xlkvx (55)
uezxhid (58) -> brapqvt, cbmkl, ijpzp, werskvv
qoppte (52)
oxlvr (60)
fuwekd (55)
qgytb (10)
vhbtdr (5)
rtromur (217) -> qbtixl, nrphw
mmriyf (149) -> zpkhzqb, kmegj
nukpse (7)
hdvcgn (56) -> tjzkwy, arouwsi
ghatw (920) -> jezubi, kpwvh, ywonug
vcoszdq (31)
vcauqo (166) -> hfjpir, toaan
fenymdp (55)
rrnkqx (41)
bsythck (59)
uyedi (1348) -> uxhpm, rtseps, kfkhxg, byjcsn
xwydsz (85)
fecwfs (20)
vxfyyd (60)
atxfply (233) -> mckyvtt, blfinsi
skrsezs (93)
cncoep (72) -> bgudw, qbhvu
awyhreh (57) -> htuuzu, eudowc, knvxq, felksho, dcjiqny
kpwvh (146) -> kgbjthh, iljkad
gmxdpc (42)
xxleimo (37)
hjbac (80)
twblj (191) -> tbutks, indjoox
qbtixl (7)
hubzsdn (102) -> zeiqoz, ukbzl
yhadh (85) -> twqkuk, fhimhm
injlqnw (37) -> hmrzqlh, lmrzi
vwmyqub (96)
omeew (73) -> kbdnbnd, rvtus
efsanp (33) -> loaft, wkbqm, suiagk
frkjf (114) -> ziyive, mdcxis
uybuil (44) -> vabii, iawzjqd
mjrfrb (35) -> nbhdty, lluabej
xhrqzk (311) -> aktnest, ixoas
yzxqqx (66) -> acbakwi, kqqegw, hmxxv
ikyzq (4037) -> oykurjk, qfsmgqe, biemun, zatfti
akght (55)
mbzzt (877) -> kxbmr, iivwxhd, ddumyx, kcxllz
ztpawhz (52)
zzkusct (77) -> qrwzvrb, wnjjug
gujegtc (27) -> bddlvs, lcjjc
rulju (14) -> dgwrgu, iruee, awxygg
djodqp (82) -> tqepyv, huxtvqc, loykzr
vrhltmp (77)
zozcoqd (487) -> alvjc, ahism, zzkusct, tlics, rbiarxk
ymxqafr (93)
vmttcwe (2318) -> zumdwwu, lvazjz, qhiav
prcclw (18)
gicwr (21)
ukwlfcf (1818) -> twblj, vpbec, wifaf
fvhvq (32)
jvtky (25)
tcjsqp (96)
rdgowwr (18)
yfwwrkp (156)
sejncwk (626) -> sjbqzk, acfnchg, pzoaqn
edwlns (34)
qiund (36)
cmenpt (53) -> ygmnsct, xwydsz
syojg (99) -> mwpejh, myoyl
aqbnaso (91)
ovrgyv (90)
ilpjk (8)
fvydfl (68)
fxzqvoh (231) -> rmmxnk, vhbtdr, xmjpazn, sbbbog
quohxia (68)
funabvw (153) -> vkhdfmv, igceh
mvxud (79)
rttwi (35) -> tcjsqp, amslmyk, vwmyqub
yjyyq (75) -> uknqlj, trqlfrt
ulgrn (20)
sfpnzbo (16)
iiwpsx (1466) -> coxpxpj, tlxdji, euoskfi
rhtqj (249)
sdjxpp (41)
qmyohe (21)
bljppq (30)
zskam (845) -> tpabsyz, wynyd, gtmud, aqbnaso
iqhpby (1769) -> zlvjnx, iufvcm, nfwcuci
brabcb (99)
byvwheg (82)
epstabj (38)
phdeae (92) -> zwcsjgs, kdqctmq
xyjsuy (8)
owtswi (167)
htlfqi (60)
ybgdelp (24)
ehwcxy (63)
corcne (217)
tlzlq (28)
hlfmvdt (12) -> meqla, yywjam
jwmjz (5)
syhipz (76) -> qwror, rzsggfj, mjuyo, zitvhwp
nfwcuci (214)
pvniw (42)
wknmdh (836) -> thbazqq, rpbeiqg, lyvdkxe
guvto (32)
isispf (151) -> kvsprca, yoiej
hasclc (46)
kxbmr (116) -> jsdbgko, mvyzuw
akgfzo (46) -> glblkz, lpfahc
jfssr (14)
bxjqibv (44)
jxraf (15)
hfwpcsa (197)
htuuzu (30) -> cmfcqh, xvoehjz, jabfysb, rfllomn, mvybmye, rttwi
wfcqzm (95)
quolxjw (84)
rergyy (56)
awnafxx (29)
bzuago (99)
ytzdrvj (28)
yoiej (65)
ffijsc (81)
rjqjwjy (73)
wnjjug (68)
ybnsg (78)
ygmnsct (85)
qiaej (82)
gzriygp (58)
zeiqoz (14)
jqgkz (59)
iawzjqd (89)
sxwbzyj (45)
faqxj (33)
gixsbr (1173) -> qvrtwdt, wkxlf, iiwpsx, icspwbg, qhfmjrm, mspxpr, xsuxhbq
ktffksv (29)
mfunt (165) -> quolxjw, tgwiasr
lzevbng (16)
azttml (15)
hezkdc (193) -> mpieb, voawog
dsoyvp (55) -> pfxoef, eiekcd
ildgly (137) -> pvniw, ulszlax, gtxdtf
paaqws (214)
chcnreg (33)
rpyxxhm (53)
kemxmk (332) -> umtmwow, yahsymr
enmxpmj (64)
owjtoo (63)
iaoxdmm (138) -> xyjsuy, fzltz
oykurjk (868) -> hkjcnv, qscadxk, phhumfd
eawwls (73)
kiryhz (44)
janbnmh (15)
sbbbog (5)
sfjyf (210) -> xpdmegi, niavkxg, eevdo, vgkjgy
lwnlk (47)
cthyz (62)
wsrrryh (64)
yahzcyp (64) -> sddoa, yscpg
kigsmv (22)
rubvop (31)
ajgvmuy (80)
htwzu (16)
xatzz (157) -> ucahbv, qiaej
uzprj (58)
ltceq (99)
dnqdmxc (79)
pmpxq (13)
ebyfpmf (79)
qeuwgn (36)
osbndxb (23)
qunom (178) -> jxhhgvz, jjfoqtv
xinxep (1670) -> tewltq, qtmvya, gixsbr
clrhsr (19)
ierop (96)
wkxlf (1022) -> drwwnwd, finxtiu, dkwwoa
ogziig (64)
nsqiicp (27)
fkehyrg (75)
zielffk (23)
upatvy (95)
jxhhgvz (16)
swqres (26)
ndmpgss (89)
wzvsi (69)
ihkcorh (183) -> fsjvyxv, hmemann
elgvwug (67)
ujzxlx (98)
veiljb (45)
hrrqb (57)
lrlhwat (22)
xlkdss (7)
qibrsjj (60)
ytjheqk (30)
ojnxwzq (2529) -> tvoptyn, yysyjbk, kqfgnql, uwrcgnq
kbfpx (47)
afbnq (41)
yscpg (46)
yatdg (50)
acbakwi (89)
bcedyx (37)
aktnest (5)
fkmpv (31)
kgbjthh (14)
gtmud (91)
alvjc (139) -> qdemebr, xxleimo
yedvssr (205) -> fvkew, gicwr
ejlya (66)
mhkrny (672) -> bezoxx, haano, pggrr
edfxg (74)
bmyme (95) -> wsdqchf, yhtpdwu
uedozkm (5333) -> tntns, mkslglr, zgkxkj, sejncwk
hsywhj (154)
licst (9)
gtbocpw (60)
vdwutc (90)
ulkdq (82)
ceutto (21)
sivsece (73)
tntns (1094) -> djodqp, ixuvbk, hubzsdn
qhfmjrm (1628) -> xmhdsio, myzut, dfupxk
rzsggfj (317) -> udlhalx, narnhty
hlshpkq (99) -> zpuwyqp, zqaxyz
ijpzp (78)
qtmvya (14) -> gsiokvq, wanxt, kskkjn, adtpk, iqhpby, pcehxbx
ktoxuar (83) -> eawwls, tvfptpz
uwehdau (55)
advjges (20)
iuubp (62)
encjlzj (49) -> ltceq, brabcb, uyoez
pabkgnq (10)
ulxscm (35)
rcbhgw (832) -> jrott, hcvwov, akgfzo
nevhjg (17)
agtab (41) -> ztpawhz, dsiixv, gipbso, nholw
xjbtfms (33)
mfcutqz (219) -> ncbrxsy, bnwotj
txhxoib (240) -> qgytb, pabkgnq
miwjfr (20)
vkmxs (75)
hidzw (55)
whjbc (54)
ivhtlxa (17)
jgylf (98)
iydqii (55)
gkitfsr (23)
carfsnj (79)
pxkzk (5)
wlwnand (87)
khdzsr (73)
tqepyv (16)
gsdzpjh (40)
wnmnz (290) -> rywggm, hpfmhy, frkjf, ojpghb, wgjst, ivldghm
msyvs (32) -> kyhezqn, dkegbrt, enogehk
uusec (41)
ufdbsy (132) -> mrmuat, seuaftr
vwupkmh (53)
pthnz (34) -> fjkfpm, uedozkm, hoqti, efgdfa
jzwusi (188) -> edagh, xrknksz, syxdt, xeege
npblyaq (35) -> mnfknb, jdjkbwr, aixwgk, ducdc
mdvnu (42)
qcglune (68)
jafsqqu (41)
nderndc (63)
qtshuo (44)
twqkuk (66)
fcdutzs (8)
olgmto (702) -> lbwgsap, jakmbx, aufwfrp, osnpbou
pfekvok (34)
cbmkr (93) -> pjzcs, pavtnxe, nsoju
igceh (36)
blvyrzh (10) -> vdwutc, cneww, mkykc, ovrgyv
mtxzek (136) -> kfefhun, wnpkwy
bsxtebe (71) -> idnsypp, iqfnj
bntzksk (37289) -> vmttcwe, ukwlfcf, zzpevgd
eudowc (1052) -> mjrfrb, uxsisng, yawmlbb, ktoxuar
mcghosj (41)
ojpghb (156) -> prcclw, gytzi
osrdt (79)
vqrrii (60) -> zrgqfb, ffijsc
wkgouh (53)
nsvwcl (90)
eumefa (84)
zuaamot (32)
lxdji (8)
zeebqts (24)
yktye (24)
wswnja (117) -> fnkrew, mcmzs
vtqzf (17)
kmnzz (5) -> wtsqx, ocqrpkf, hasclc, kqdseyh
ednlrw (56)
yxfmelm (57)
fgeup (36)
oiufrau (43) -> ajgvmuy, kxzwel, hjbac
bdvtnul (26)
xayqwyj (168) -> wvdswpz, fvaeyq
vzxet (60)
cvvkno (56)
wctihs (31) -> ikicwez, wzvsi
cpzwgk (209) -> lwnlk, xvudg
fsoqc (24)
hkkzpzh (14)
wfeurd (165) -> nlrbcxx, kbbwe
klexq (30)
ebjgfh (34)
vctupmx (42)
psrup (53)
ngiol (95)
kryvxoc (18)
tzkgrjf (54)
gcrugvi (62)
jxhhc (17)
wntfmtn (254) -> faqxj, qzgdlb, uurqa
wuyjdn (95)
dbrcg (11)
dcwcs (42)
dsuchz (88)
hlykzp (31)
pwyfdan (85)
hmemann (27)
yjmjnm (77)
cjcytbb (55)
sutzt (169) -> fpdoney, nnkru, sfpnzbo
lvazjz (39) -> zinjsj, abjmd
bfozr (43)
gfvzrt (84)
wanxt (1603) -> lgqwxgu, shwsf, zvnzep, jwrmi
fntaap (43)
dfupxk (91)
uxsisng (95) -> elgvwug, ssxqkhq
rflrj (181) -> niklue, yjcggu
narnhty (26)
ziyive (39)
tkvip (279)
xjjvneg (19)
toaan (19)
tgoztyw (201) -> yrnjhqc, rzldn
nrphw (7)
bhnwdot (50)
negxuk (217) -> nsqiicp, xsvage
tyqnwi (155) -> kigpl, iwkotv
qbhyq (98)
qmeawpu (22)
xjejd (88)
pvbgvb (41)
snsyzbk (20)
vkile (164) -> pdkfixk, ufpdyq, lrlhwat, kigsmv
jdazgj (17)
cdaazt (54)
qtcnfy (50)
gwyrtw (52)
sgznbm (50)
gkqxb (65) -> ioyealn, rqeftjw
mgoym (83) -> kslvs, snyio
cneww (90)
fixqj (116) -> ybzqe, nhcmgrr, nevhjg
kjmvhpa (20)
sntbr (55)
bnwotj (15)
xvudg (47)
ltyxiwk (53)
brapqvt (78)
zrmzpo (95)
xcdswr (85)
erngeah (44)
zvogn (8)
ranlxct (59)
oztxjfl (239) -> eukyl, pjpbcq
bcrso (24)
ogtxa (89) -> iuubp, gcrugvi, cthyz, zzlocxd
utpyp (35)
rmmxnk (5)
nogoyp (70) -> rdgowwr, kryvxoc
afqwh (30)
nedjj (54)
lyvdkxe (42) -> ssblis, gmrkqq
ybzqe (17)
bnvjfq (34)
sklld (24)
eqkio (2131) -> eefmcrp, cmenpt, wswnja
qypsl (54)
wcfykko (60)
luiiv (898) -> vgnkq, coenr, paaqws
mjpmw (101) -> lomxh, rqvifq
wswwck (40) -> zmdvl, yatdg, sgznbm
yjcggu (18)
pjpbcq (22)
yahsymr (30)
liwvq (1960) -> axqifwm, qunom, euxvn, efsanp
euoskfi (135) -> nnpvdm, jwmjz
hpfmhy (176) -> fuexyx, fcdutzs
jczkx (55)
jvwfxp (330) -> cvcyykp, hlykzp
pyscsi (64)
jevfpj (65)
zitvhwp (75) -> tpbcg, ujzxlx, qbhyq
sndject (5)
aufwfrp (53) -> mmprixv, ejlya
riogonj (346)
dhecgkl (73)
eevdo (16)
kslvs (42)
zpuktmx (37)
nbkzscx (9)
pbvcu (73)
zwymlsj (118) -> tcpvyfj, rtiaapt, xikbq, gldvef
fzbwmsz (187) -> dbrcg, wkkkv, mznsk, etkzf
tmtfhr (30)
eukyl (22)
hmugaom (156)
ixuvbk (130)
santsu (76)
buplpb (26) -> negxuk, imuhew, izssdb
imuhew (77) -> yauryvu, kjtwz
niklue (18)
zuzhmf (137) -> pbvcu, sivsece
lgqwxgu (202)
emxwr (262) -> nedjj, hwfcy
iqfnj (94)
ixyeq (273) -> pxkzk, ylfvgv
wvgzlw (87) -> hidzw, vofrtf, yvllxxw
kbbwe (41)
jcsjaxj (2792) -> buplpb, slntf, kqohkg
tlxdji (145)
hgaoiz (283)
tgwiasr (84)
ewyrp (259) -> jevqne, ilpjk, kmpmdb
kmegj (50)
axqifwm (98) -> dasmiiw, wyiec
jrrhzc (5)
cftggo (20)
xvoyybs (56) -> ygvvvq, kemxmk, jkfrln, arjgn, fvsitx, lfrfa, jvwfxp
daiaot (60)
avemxf (63)
yzpyzu (41)
wtbst (73)
seuaftr (21)
dgwrgu (89)
kpffozq (27)
qoeviy (129) -> yxvmxzg, bfxvxpl
uwprsvh (1502) -> qjkkohe, pctkyat
ldvcrw (299) -> clrhsr, elmmtp
yywjam (86)
elmmtp (19)
coenr (56) -> edyohkw, vspquqe
khixwdd (54) -> vxfyyd, dltbolj, htlfqi
jsdbgko (73)
llepsqz (96)
smqtcaj (250) -> daiaot, lswutyd
thbazqq (180) -> pmunsu, vtqzf
kaitdu (98)
fvaeyq (34)
glblkz (97)
vmofl (39) -> eumefa, gfvzrt
dqktd (95)
mwvbcqg (58)
gbwfjf (777) -> tkvip, mbcwjt, sbimooe
hmxxv (89)
wynyd (91)
jdjkbwr (41)
elxccty (54) -> fvydfl, qcglune
bnmuprs (41)
kgfudu (45) -> otsyp, sdixs, whjbc, cdaazt
hfjtksr (39)
tlgdija (81) -> fntaap, zlxlwv
qrwzvrb (68)
nchgm (49)
gofjvi (67)
jjfoqtv (16)
tfbqaoe (53)
zzqtmxd (116) -> fecwfs, eigsdc
qhktzou (75)
wydtqax (45)
ytyhmux (84)
qqkqhzb (274)
trqlfrt (92)
eivaf (370)
njlaepf (47)
bkmepbs (46)
mpieb (34)
sbimooe (89) -> dqktd, bnmsz
dltbolj (60)
lvktp (32) -> prnno, qxsjs, wuyjdn
lcius (54)
mxelfv (75)
hrwtz (17) -> mocpa, fixysjm, cjkieim
jzcstbe (236)
mikalda (35)
xrknksz (12)
knfath (32)
pmssap (99)
eefmcrp (209) -> nukpse, xlkdss
nkwisjd (149) -> pfltnc, fblsn
ragcph (38)
eubjf (58)
snyio (42)
zquvn (108) -> nvrpd, dlrznye
uakxuru (169) -> zhpdhat, uymdj
egrit (73)
dlvttmo (95)
xikbq (18)
xgmrufk (56)
cbmkl (78)
jqwaifx (24)
qowepn (33)
clizzo (227) -> dfrzb, zjxjhwc
tbakk (935) -> wctihs, vszpkfs, iqtdzrh
qvzjgne (36) -> dlvttmo, wfcqzm, mfslhp
mvybmye (207) -> awnafxx, xqrrpu, ktffksv, csbgxs
mkslglr (189) -> dmkhzgg, sykmuwo, bsxtebe, yjyyq, znmav
jkfrln (342) -> jbhohbx, jvtky
znswber (40)
rqvifq (53)
fnkrew (53)
jabfysb (91) -> gzriygp, eubjf, qluzb, ugplhkq
dresofi (346)
zpkhzqb (50)
hwraaxu (89) -> majskr, nchgm
uebmnqa (88) -> ymxqafr, skrsezs
qeoetnp (173) -> evvfcyi, pmpxq
sddoa (46)
qdemebr (37)
kobwktw (62)
fogmaih (75)
wgevvca (79)
phhumfd (35) -> ulkdq, ulvbf
zpuwyqp (59)
txdprek (83) -> gsbmh, iizpgi
cqmvs (14) -> bntzksk, mvpqv, pthnz, xinxep, qnhvjec, znztzxd, silwwua
wazlg (92)
unpdcwm (153) -> yktye, sklld, tdrdq
uknqlj (92)
qwror (369)
awxygg (89)
uwrcgnq (1176) -> uybuil, vqrrii, arejh
nvrpd (83)
znuldtj (30)
wxyaqte (27)
xbywgft (55)
iwidsj (95)
kcxllz (43) -> mdlubuq, dhecgkl, uvpwrf
arejh (188) -> lbkrk, jxhhc
qbaig (84)
mvpqv (5522) -> ojnxwzq, qlchz, awyhreh, ikyzq
lpfahc (97)
fadkfic (36)
xvwgxm (63) -> wazlg, vmkfcpw
tewltq (4134) -> cviwy, wknmdh, bcnqhw, vmkib, ezaobs, gewlsr, yevywe
rfwgt (78)
wsjizsy (33) -> bsiwtqq, uzprj, mwvbcqg
rbbkdj (191) -> rjqjwjy, egrit
cwwwcge (20)
ejbtu (58) -> qnepf, dsuchz
hefjuue (24)
coxpxpj (5) -> cbgnzhz, uofuvf
nhcmgrr (17)
iktev (194) -> chcnreg, olnfe
vhnnnv (79)
kmwkft (88) -> edfxg, xaovjvs
kdqctmq (7)
slntf (309) -> dmxlfzb, phdeae, vfdulx, bzorz, nogoyp
ohqivu (82) -> yjmjnm, taxky
lqasevp (26)
roojn (57)
ojrixty (97)
xmjpazn (5)
salxel (5)
lhlgijf (54)
zatfti (60) -> phkzo, ghqixh, rulju, ksnxlcl, isispf
znmav (95) -> byvwheg, kefudoj
myzut (91)
cekchxh (59) -> lcwqdxx, nkdbmjv, pfekvok
ukbzl (14)
bwrpc (41) -> jzbnq, fezoyaj, birtjxh, fcjjqev
ytadaxm (26) -> nlkwsrn, qtcnfy
qlryl (10)
vytlfm (33)
jswxshd (127) -> teapi, ugssydn
emqwt (50)
ugssydn (35)
iumsmx (20)
kigpl (89)
cdfij (68)
esmbu (8)
izpta (84)
jviven (416) -> gujegtc, owtswi, haayebg, yjcevge, mgoym, iqckb, gkqxb
qhiav (99)
ixoas (5)
dmxlfzb (16) -> afqwh, klexq, tiyvea
redeub (57) -> hxhguzh, vkmxs
fymyi (35)
mdcxis (39)
lcjjc (70)
acfnchg (246) -> advjges, cftggo
ldkojcj (8)
nwlkk (84)
kzocw (2306) -> umsrz, mbzzt, uilvahq
meqla (86)
drwwnwd (139) -> vrhltmp, njaig
vspquqe (79)
uymdj (76)
eutun (192) -> iumsmx, snsyzbk, wkxyxtf
ezaobs (434) -> lngdxkd, brmvw, hdvcgn, ufdbsy, qsxqwub, rkswk
iljkad (14)
ryeiot (41)
mwhraq (86) -> lwysj, lmgxknk


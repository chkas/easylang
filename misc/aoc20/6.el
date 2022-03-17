# AoC-20 - Day 6: Custom Customs
# 
repeat
  s$ = input
  until s$ = "" and sp$ = ""
  inp$[] &= s$
  sp$ = s$
.
# 
# Part 1 
# 
len a[] 26
while inp < len inp$[]
  repeat
    s$ = inp$[inp]
    until s$ = ""
    for c$ in strchars s$
      a[strcode c$ - strcode "a"] = 1
    .
    inp += 1
  .
  for i range 26
    sum1 += a[i]
    a[i] = 0
  .
  inp += 1
.
print sum1
# 
# Part 2 
# 
len b[] 26
for i range 26
  a[i] = 1
.
inp = 0
while inp < len inp$[]
  repeat
    s$ = inp$[inp]
    until s$ = ""
    for c$ in strchars s$
      b[strcode c$ - strcode "a"] = 1
    .
    for i range 26
      a[i] *= b[i]
      b[i] = 0
    .
    inp += 1
  .
  for i range 26
    sum2 += a[i]
    a[i] = 1
  .
  inp += 1
.
print sum2
# 
input_data
qpicundo
fiqcdbkyuoz

rahgpijvyfd
biwvrajyp
ajbrvopeiyw

cv
v
qwvo
v

ftsvmcrbxn
zkvdfsjxrablnpoutg
nbxferitsv
nvfhytbrwxs

hdamqjxnipezgrwutc
vmszeqacbiuwpokxn

kushbeg
fjarlmdhvspkbie
cesznhbxkg
buekysxh
zbkhse

hrxgtupf
gmhfxutje

cnajtoldrhkmiqx
onmqriltahxjkcd
jqimcxkrdoanhlt

fhbtngdzq
ndbghqftz
qfhdgtznb
nbdgtfhzq

dxeoijmbprfaug
ohspnculriwexbk
zuviobjraeqxgp

oitgeazcqrkyvmphl
bapolshcnvekdyrijz

hxaiwmzpglyrunqkdfvjbsc
jsymwqnfzhbvrdxcupglika
bqzsuwpkfjxnildehagvyrmc

agkfyuvncr
kvucyrfgan
cankyfurgv

qrikblojp
wtvfscqiyh
cfwynimq
wuqxmegszi

egvjnhmwuszotipdc
nzgvmjshpcuetiwod
dqwpiyzmcaoxuhetvngs

xae
xaet
xea
xae
exa

jizaflhpxdwumgs
duaflpzwxmsgjhi
wfsmilagxhdzujp

ijeyq
ezqji
zqeboij
qeijb

bad
dba
debta

h
x
x
x

ulfkv
kuly
kuly
kjul
klu

gpr
tkr
rd
r
dr

mlcybiwua
owg

cokrh
bomzakugxtwveiyn
osklqp
ofkq
cpqohk

hcmyonbsarvldkgfpw
eslkdgounrvbfmywh
slkdhzvbfnymorgw

efvugtbyzmdh
fumqpbvyej
ypcmbivuesf

mdgfxrjycuwepi
sdtmejcyubgqlox
xdmyecujkgzafr

arhevtgdomli
idvraethmglo
ehivtolgrpwa

zrjkgal
rcjga
rljgasp
wrbhjnav
jslra

go
goxw

nfycq
fnyc

m
kf
j
d
q

wcx
xfcqw
qxwtu
oxkpiyg

ud
qr
somtbxcv
diae
ij

vftcjdgs
cdtvfgsj
gvfsdcjt
vgfksjdct
gtefcdjvms

khgdmzlcae
zedcslqka
tfdckeaxmzlhr
aezkdrlcs
wycukdlvaezb

hzakytmxgcqvunsbjoidwe
touhjicbexangskvzdwmq
ubdepshljqaivfnzgxwromctk

hxgcwlvzujrsbe
zxceuhvwgrnldbsjm
rvczewuhsxjlgb

rhiuambjzqn
imqzjpburanh
brmziaqujnh
aqifozjubhrnm

ukrpajtcnlvysdhwf
rnytlpwaicjusd
ljyarntxhsbwucpd
lrjwscyvdntuap

xwgtyqkf
wvuinb
zlmewri

vajupxzg
bpzaux
pxzua
zpuax

wmqd
dqmw
gdqwm
wqmd
umqrdw

wrfhtn
rofwht
pwsrthf

manfclbyrdxjik
bxflmyadknjcir

sduzqohjtnkmi
hjtnyimzqdsuk
mjquhntdiksz

ofr
qrl

yhjzgdmslpn
zygdpjlmsn

ailyqtfmzsopr
iazfmqslyrjhpt
tlpvqgaiuzsnmwfbeyx
dclofymkatspizhq

clypfnqvimtuxwab
msogekqrzhjf

hnvgmwrfj
rhfjgmw
igdfsrhj
hjfewlrg

julft
fuijtqyc
owfjskvtg
ituejqfc
yuztqfdcirj

rubfcosnikjzmyav
fymjibrucozavkns
uzanfkocrsyjbiv
yrbvncsjuoamkzfi
sfcjvyaqodezubnipkr

qkgwlfhdy
nbjkrsveifz
foypxtcak

cjqwymzgbxilsednupfovk
fgqevluowysidbnmxjkzp
liekuxymdsvbzqjnofwgtp

sgfnmoljbdihqaeyuwcx
ojuwiqhdlnzfcsegxymab
wbftqhedrmikaluxsgpjncov

paxhq
cos
fdb

ognxqwer
qwgoxenr
gwqroxen

fsdgo
kdocfslx
osbdif
hosdprf
gsvofzd

oamvucfhpq
hquvglbsw
qrvhu
uvjhbltdq

jfltodbmwxpcai
dwfihozpbcatljxm
pbwotmcldjxaif
txkbipfwdjmlcao
ajfmdxlipbtocws

lkbehfsx
hxlksfebp

lm
whnogp
kicyqtudszf
jn

gcsewnmqdthv
gsbucadrmz
rocjzgsldm

uprsfb
gfqnmlbjtev
fhwb

awpv
a
a

t
rtn
t

yrfmxdnkel
lmdzewkxnr
drempnxkl

kyh
yfh
kyh
yhk

ybqx
xbyq
xnbqoyi

rkelsyhwmjqoaxgbndzicu
swlgkjmbqhacioedvnur
dqorcpgjmhieunklwabs
uoijceghaqxlbnrwskdm

xmd
mxd
xdm
xmd

unjqpocarmtgfikxzsdhwlyebv
gwklmrhxdvpfbzyacueitqnso

wfhlcpe
fqechzwal
hlwfec
ywbefclh
hecwlf

v
v
s

gzhspvqbtiyl
ltqiyurkhb
tbhlyrqi

hepdy
ydephi
edsrhpy
edyph
pyhde

upcjxiwvqmhafetsronkbl
atflkcnqumpohixbzsrjwve
wlovimkcxftspajbquerhn
ikqrstefvolhdwcbmapjuxn
ipsecmgurbxqtonvwjfkhal

nrhjbowi
wiornbhv
bnwhroil

szfukhordxjb
rfbunjtdsk
ndbjrkufzhso
ukrjbndfs
eukgdjmrfsyb

gbzd
vdz

oqfzdjk
kedfj
buwinxdrjgyh

gy
euy
ywz
yk

qfglvert
eftjpsln

ujqwnmhszxcopivfgbe
wgunfyqopmzesadcvxjbt

baiykdzpg
payezibmdgk
ikyzgpbda
pbdgakziy
pkdbazigy

pojhgwqdycz
yldpsuwco

lqiox
khglw

iknzjfuqcx
qnkcovzui
zpnrqauywtdlme
gqunsfvzo

ayhdk
ojybpl
yvpb

ubmxehjto
xbtmoujeh
xmoejubkt
juoetxbm

kvcbe
eckbpv
wceqvkbm

hdojvxsbaiy
elwbsq

mrng
wlz

pbiluamrejsownyfkgx
odbpxnuizywltqvcs

yhgoj
inls
vqzmeawutpf
cdyjxr

weviflqhaotpu
csybrknxgm
zjmdkr

wnp
wpn
pwn
wpn

trfmhxeociukg
ecioxufhrmtk
thfxmenokcuir
ikxehroumftc

jgxzko
jizkl
xoukjzv

rkwnxumvyigodejlfp
okerwlypnvxdi
qztwohyxkcenadvbpr

xtisomdj
uncyzkoesravi

yrplsicjnox
riopycxsjlun
olyjcpsixnr
nxiprjclytos

lypqxvjrueastb
lvpruqbatyx
ynvurplqabtdx

a
aq
w
uzb

b
b
b
b

bdhtie
bthedi
dihebt
bqihdet
dbethi

bmcfdeuhykarnxq
buxaynpetdkhmifqg
yabdjmxqunkehof

hbjle
pyr

ga
ga
ag

hit
eft

bls
sl
ysl
bsl

qjtvniz
jit
iyjt
tij

cindevpkljyarzqwh
zgtdpmsxnofbyiru

phismdwurq
ximrwtlyzqh
hfmjziqraw

ay
ay
eya
ya

elnvry
ckiyeqnvml
yvenlzrs
vzneyl
revluny

jbqenozxgd
xdjqgnoezb
nxqgeozbjd
gzeqobndxj
bqdegnzoxj

wfroqvpdjyu
jprvwouqfdy
voudwqypfjr
jwuqyfpdrov
pjdwovyufrq

wpmbq
bqmpw
mphqwb

q
q
q
e
q

mpwuo
opbwa
owgp

rbmveola
eoizbmv
lqbaormve

enqk
kqn
knq

fdoajsxqhlinrywbgu
hxnuolryqdajgbifs
oaduxbjnigqflrysh

r
i
i
i

dngie
igdne
djfrgiwenmk
gdnie
gidne

ompatvbu
pkmuxavbt
szufycrimbapw
vbuapm
kabupm

quonbdt
otuybq
botqu
uqotb
qubozt

j
j
yj
j

duqnjebpv
lquynhc

hndkojuxyslvrm
ovmndkwyhxuisjlr
kjlyhsdguprvoxnm
lsomkhyrjdxunv
gudhsnlrjkxmvyo

vtpamce
ovzaryjmetpc
ncavpt
tpcavy
bwptvxdqhaikufc

o
o
o
o

jqluihoeak
ikeujqoalh
joahkluqie

fqrmvtxas
zoiwqlmt
xvqhgebtsm
tpmeq

fkaeotvzuwyxdjs
xafmzeycqbshvdgkl
tyxasdvkefz
vxoaksyzfed

rkfvodejlb
qahc

urabynscomx
bvmaqynlecf
khjlyzcdigpbtanm

losbxwmapcdrzfyj
ujmlczgbwxyehkoq
jcgqylwbmzxo

g
g

bvs
s
s

bhjwfznyraolkce
fbqjlrcwaokte
bvlrwotfecdkja
rwkflbxijougmepac
kfwajczeoblrt

lhdcfskwxaerjiotzvn
zaiefvhslwrcjoxk
zoxjibkalmshrevcup

egvpws
epwgsv
vcpsgem
ozvyetksrxagqp
lpmgseuv

oupbzjesrfwnvklxtiygdc
iyjudbvzegtscownlrkfp
gwfzvlynutkprosedbicj
wdkhujnigopzbcystelvrf
dgrlvbtfzinpkusjwceoy

xupqorents
pensurtqxo
orensquxpt
prsuxonteq
snxqrpotue

obryetcjszpnuwgxilkd
ropejxinuskybcgwltz
zuvrgmwftjnelqsxkpcyi
nxkzhlpgsdyrwejtciu

yzriohapbgs
isprgzobahy
riyabgohszp

lxczkmearuhnf
mxfnkczruhela

krcoivbedawtzuhq
wnksyfjarde

xsguj
usxjg
gsujx
gjxus
ugsjex

hy
hsn
pz
c
n

wdnzt
wqzrdkbc
nzwdtf

h
mh
bh

kqalzofbu
wyncpf
ixf
hf

tihepcdnxg
scfhe
cefh

zxlhgpuowimedyjktqrc
zgcirhetqjmlpdokuywx
oqykmcupwridlxhztjge

xvstwya
vtywxas
yvxtaws

gsnij
gpjshn
ogjsnlze
jzongs
swljegdn

teaxnu
atreuxn
axlwtnu
pvukhadbjtxcn

uvgz
zsm

xrjduek
djuiker

mgbsqftv
bgvsfmqt
ftsvmqgb
tvgfbmcqs
mbfsqvtg

opjuwfskvclrxgtbnzemqhia
jsutkmcybpgowzaqxrnfhliev
wmhbsitkclvzfxgjpurneaqo

xblyaorpvdjqfehuszi
pyihjwadusfqbv

lhtxfsockq
hsoflktqcx
lkfhtxocsq
fqocxklhst

zwt
zhtbw
wzitlb
wtbz
zqjtw

pnowugqirtlmzadsv
uoqpznmldrtwjvsi

meavkwnigcbjplhd
minwphevajckdtgl

udqekwjaxm
xujwqmkead
emauxkdqwj

sxtnmaechq
qnesxcth
ntkxshecq

fl
yt

pnjmvxgd
xeqdpmsvgnj
nvjpxmgd
pxngjvdm

ezfswkgqrjnbmpvliycxua
ubzspxqgnejywkmirfv
pbigrvjshkxemnfuwyqz

unc
cnua
rknluc
zebcntou
func

ucbipqmenafw
cqiamwenufb
bqveahpzcuniwf
uatniwcdbqxjeyrof
faeincqbuw

mkbtyagfurhszxcpqjweivld
zygiwpcnuxqjdlmvfeohsb

qtczamlod
qovpdgfla
ldaqi
dwnarbsheyxl
atvuljqocdf

cjxpytmesknol
esxcmpoyljtn
eosljxtcpknmy
ptsoyjmclbxnve

gsmxqruzwhtb
gwrthqmisbv
tgbhqmrsw
sqwmgrhvtb
hqrbsmfwtg

xdzjpkolmgchyatnbqv
yiuprfwxnosme

aruewcdm
nroei

yxh
xhy
hyqx

a
a
a
a
a

gkrsznedvcwxpymtu
irqenbkaox

kajrbfgdlmenh
mflgandejrhkybx
afbmqelnjkhgrd

vfmns
zonlxhfrvm

zcjhsuikpbaqgwnxrvedmfyt
dvpnabeuwzqhrsgfyioxjtck
qjwdzgurbcsehtxvkfanyip
ajivfcuzwhrnptxyqbdskeg
xjwdfupbnzsqygheiarkvct

s
b
i
b

wqoxgkjatmlcynhs
mojxlyhcnatwsk
clktjowxayhsmn
sxonlyakmtjhcw
mawkojnhlystcx

hovsj
ujvso
jsvo

wljeskzntydaqfg
plxzvtwdrqosfckhnjb

aswnqfrcoe
oecaqf
ziqayfjum
avfrq

iortchugjyax
mlxsbgzrvfaun

ispmrkfvyhczdotnjua
kqcvmrasoblntihzxufjydp
cptoryiszakdhjmuvfn

qstwglyd
qylwdstg
tgsdqwyl
wsdygtql

shcbwqgu
bdqmn
vaesbq
lrptqfijxy
qkz

svoxw
zxwbkvo
owzxve
xwogbnvzk
vtwfqjiox

wq
rwq
qw

nrxyvf
yfpnrx
fnxpvyrj
edwsaytzfhnxr

jdpfyteizvkc
ypjmnvlwtfdcezgk

bcpwnkgsvtxdoryifh
gfscykroibnxdhtv
bgyjnckfsrziqvohxdtu

jxwqdnocstrzvhybguilemf
bmcqdgrlznwsexfavhyioj
wxamfqjrobyzicesdnplgvh
ngjixrfmsvdopqbecwlyzh
gnfdcimovhbjxrszwyleq

rpgdzmcneyjthsvflb
tnmfyjrzbosldg
ndszyijtbfrlgm
tzslbmrfoynqjdg

rekgsioqlu
unjlczqkbdvgahm
qpxrtusklgyo

iwupkfsxnoqzcd
pvzwkmdejybqhtrcn
zswapofucqgndk
ukqgpdlocnwz

yxzpgn
xzypng
xyzpng

ibg
igbf
igb
big

krqgmdcbxeuvsaihj
jsiartydzuqhvowp
qvbrdskexjauih

bgaoqndvurhy
ursayhgpqbonc

nrzwfeqdmui
rdjmwnkzpq

aihrwbyjzt
wcajbti

sizktqxjyohd
khzqdtxosjyi

qclmepht
qdplucnb

maxvquihzfskdbglj
wvisljfgbkrmqzca
nafgikszlbqjvm
kfmsbcgvizalqj

ub
beu

dxhnelp
mpfiselg
lpexzoaytv

gmuvyxln
wkxoegvjhumdal

x
x
x
x
x

skvxydbqmzehnlcwo
vcnkdequzxloghybwp

uslq
sluq
qsul
osqul

euknogsl
jbvrnkgoslu
npmcutyihaogwsxqdfl

qbfoiukvea
pgdzhc

njdlgbus
judbcghtnf

calds
lcsa

dvcnlxhkt
bvzhingdrykjsxo
vkphfxdn

bsferyztuikaq
fsbayqukrtzeic
ebksiyzlqrfuta

spmkwhd
nhbz
bqxclfh
hjnli

hsmqoplv
hopqvsl
olbhfvwusp
hoqpslve
svoplnh

tpnuwvzabcmjfiod
avwntjdbzcupfo

bdvyenjktqcgawm
rvgteckqmb
kqrvmtfbgec

fu
sdc
jzrginhoalw

hpwdfomy
shwjzmpfikoydb
yfwmhdopl
yhwdmfpo

q
q
m
h
m

qg
gq
qg

d
do
d

pebzkhvxmicuwgoynrjdsf
dchofjsmzrkgwxpyvqeiunb

ljfm
mflj
ljmf
mvjufl
mjfly

juvli
luvji
lviuj
vliju
lijvu

qyokiecwgxsdpf
pwqfselocinxgdky
yoksiqgwdecpfx

y
xpofmyg
vyhz
y
yz

rihacgdmbn
abcmigdhnr
ignabdmchr
gdhmirabnc
rdhganmicb

bizqcode
zdp
dpazjrt
wzxd

cmfihuwqnzbtglp
itnwhuzlpgjmfqcdb

ut
ut
ut
ut
tud

klhufpyioetxngj
jxuhfpiyntkgeo
hkefjnpgixuyto
igknoteuxpfhjy

uysoaqjzmgcrvkdnlebpwtx
enlrwtxomaqjupvsczydkgb
vdsziegptqljwabxnoruycmk

nycf
mcxo

ytivwfslq
ftvqli
fvitquel

nybhaiupejdxkgs
xyajdsbuekinp
ayjpbnuxksedcw
peynrkadsuzjxb
nugdjbypkxashe

nvdaqfkbyomhxptiswugrzce
xzkhfsjotigcypdnmubavweqr
ndhyrzqaekivtxgcfwosubpm
cdzatkpnvesrqgomybuwxifh

sujzvcnoy
zusnxef
tsqdwghnaulizp
yusnjbz
mosjenukz

rqwov
vqdgorw
ovrwq
opwvqr

dktvrwchflapu
prlxwcavdfsu
vadwuqfrpxlc
cwuvraplfd

qsjpxud
qpdixsu

xvktceduf
tuedxcrv
xcutdev
edvrxuyct
eqcdxtyuv

sbmhyidelk
eldbhmsiky
hkmoyisxledb
kmebisyhdl
elihmyskdb

ycnp
ycnqmsp

rhyjefcnpsqt
fsqretnhjycp
efrjhqscptyn
qscfhrjlypetn

jtwuhekpbqaoizgcdym
omuyzaiedpkwgsqhb
eghavourqipwmdnkbyz

xyejzbknatlrimf
lrfyqejnxamzdktb
natmyzjxevqrfwhkbl
qmjfzrtlnkeaxby
ycblzpfmektoanjxgr

quwatziscogfnj
hravz
xlbmkza

qtjslp
czikofeuy
ptxbvwal

icmd
ipc
oxftiscgzyb
ciej
nwkcvqi

mk
o
dwxb

rzg
rewg
rge
rg
rwg

o
th
o

jtkifz
ltmikzj
fceztlmipj
pjzati
jgzdbhsytwni

ablqpzxmoingerywf
xpmfezbayrilngoqw
mixpnyqrfaeglbozw

pjewrkfisbo
jkeaprhbfswog
tojwpfbsekr
fwbeprkjscmdo

udpjifbsevlwqxgkmtrco
yimjwpcnukrsdavqxohf

acrljesyth
aontchrvljy
talszhrbcfjqey
chrjtwyqla
mhxlytjuiagrpkdc

ockyq
dy

e
ex

uz
zd
uhz

rqvhze
hrezqv
zovfeqhr

boekypjtz
zktoyjebp
epbktyojz
opbktycezj

vpladrzxbwh
pvgizarljdxbwh

soalndurh
ruhosadbmvf
arudhnos
lspqurhadoj

ualpstjky
psujtykal
skaujpylt
tsapujkyl

hxagklitebnmdrqcfwvsj
ehdxmkqaycvsonbrfwi

xzfmroh
dntb
g

vdmbkqil
sbkwqm
kqbyrxm
bkqsm
muwkqbzy

qljpfbimaswex
lwmsbijafpq
bdalifmpwqsj
jlamqpiwfsb

gtck
ckmwt

wqvp
ws
wu
w
wu

fglbvteoinduycjqksmxzrphwa
fixyhqwlnkszvoregcudbtpjma

oqjb
gbkqj
jblq
qbj

yiurdl
uidlyr
liuyrd
ruydneli

qznajfvr
zrjnavfq
fjqrzanv

ndwpjqyx
yzpdqcnmwxf

avnxlomwtjdhqei
dqfxmreculykgvtjon

fqotuvxki
ovywiuqkf
uiqhkofve
ioukvqf
quiwvftokp

mcxhanksj
exnjhocfm

m
m
s
m
m

mkq
akmql
mkq
kqm

zxldabvrtwoyicp
rlpbqfwdcovaet
crgujdvbkpswmolat
nwhdbcvpotalr

asngcw
zxafhgp
yjegdutvorm
iqngs
nkgzx

z
my
d
ohfc
s

k
r
m

ihelxwpygbo
oebglxywhupi
lgbxpiyhwo
biwoxgplshy

ygqnkm
mknqg
nkqimgfz
gnqmk
glmnqk

peax
ealx
eax

whgsjnbd
whgsnjdb
wpgdhjnbs

pbzmysjve
ebofukvyjpsh
jvyberpwstq
viyjcdesbwp
rpsvejbyi

uymlzeihapo
yleivfaupz
pxzgqlayscbjeiwu
azeuiyfpl
ryphizkaeul

kyiuectd
uykdeczi

mf
zf
mf
fn
f

lksmjwceqfpngyxzd
jmlcsvqdxkyuewngozbp
wlmeiyqdskgzhjpxnc
jdapwmsxznehqgkcly

xujsqncmrgkflohyewzpa
qoatelunckgydifmhjpxrvwb
pykmhgazwjncuerloxfq

efyo
nlcwbjef

nzpwo
znwcop

wxeguptj
mgstu
otgu
gut
utg

tbpcqyvwizmgs
scmqvizpytgwb
iqzygwsptvcbm
ybimcptsgqvwz

hlgwbevrqcjxsf
njifcqghxrvewtl
gwjcfmhqexlovrb

xzs
zxs

frjzu
uetgiqm
uaeov
sbgyqu
bquo

yepgsojubnzxrhmtlfq
husqezbwxngmrtplf
gxqneopzrhdslbumft
hslbzwgeoiuqrnxftpm
fmunresxbhgaptqzvl

opwuibl
piluwob
olwiubp
wibluop

obvzhrmkn
oprkbvnmzh
zovnbhmrk
vnomkzjrbh
obmkrnzvh

rbgsywpzifanclt
hfwndizxkjtsuypvcbra
cznwbamiyptrfs

yopvb
obpy
ybop
oybp

tcr
tc
tc
ct
ct

owztrcxfgy
ftzlorxgwbmk
wrgoxtfz

qd
zcn
mo

jpghwqsofrcuatkexy
sfcxkwaoytjeurhpg
ycwtxehprjfaogsku
rjfognzhatpecwuykxs

urtsinfxlmqgzhd
fsrhtuixzgqnmdl
rtuzixmsfqnhdlg
yqglzisofmtnrduhx

iuawhprfkdqnjsxct
qihkjosclamtyuvbwnp
hsdipzjuetkcaqwn
zpsfhktcqujgixanw

dpey
zjmyedpx
nepyd
dyep
epnyd

luqyb
blqtuy
yjlubq

niulkzgvmpyseqacdjrowb
lcaozsimjbuqdfygwvker

gzyfw
zyfgw
yzgfw
wyzgf

z
z
z
z
z

ymfsvlrk
yfmsrvlk
fmvykslr
ksfrvlym
vrsklfbym

ent
nwetal
tne
nte

nbwkjt
wbtkj

sydlfim
yixfumpt
ofkwymbaiz
qfyendmi
yfmix

lrdzymgabtexswqn
xrotnmkzdlgqsc

bilqfktvxanemzgusrph
snpakrugbyfmwhqxetizlv
mehpaftzvlsbqikngxur

kxsnoemdalq
ubptrgfvdcyz

xzvsnur
snrzu

ejrnailgkmhutwbvdfpyz
tlmcgefjuvaiyrwkz

ftlzhxs
ohxflzts

kzijpbnmfhaxtvl
flibzjwhtamkxp
bskirxmthdjflozep
tujiphbfxmzkl

ambtcpgq
qbmpgtca
abtqmpgc
mtpcagqb

taofbg
tfoabg
outgafb

biurh
hriqbu
biuhr
rbuzih
ubirh

rvjxdbitgc
tbrgxjucvid
jmortivxcdbg
gbrjcvxtdi

qvngfmuyozdbkwaphcr
haiufrkzvwydboqjp
wnukvpfzlhrayoqdb
zduckowqyebhfsrvpa
dvrqoswbpaehtyzfuk

yzhmrogndc
fxzb
evkwjbpz
jatpvz
suqzbi

rxfdvumlhntsowpiycabzgejq
iopsjqmnwhcfuargbytkxvzled
icaybhzfvpuoeswxqnrlmgdjt
sneioplcdjfxuvtazqbrgymhw

xjas
fyhux

gwistylekhruxovq
lythgqivuowksxer
igekwlosqturxvy
royckiudglevxwsqmt

xvblauri
rduxqmnt
xzruo
uxqrjn

bunsrlgk
qnyrc
rwnyq

zkyqfrnbmuatojxvwihel
zeaxtqjonbrfuklmwivh
tkbsquaojwvnhzgeriplxmf
hzikjfvmtruabqexwlon
lqodamkfxjerunhzibtvw

y
q

c
cu
qkv

ervnoqgafw
oscminrewf
wofjbr

b
b
ro
b
b

ylpedbjm
jmyqepfb
peyjbm

srba
gioz
aluw
baseu

wamvctoexzgf
bsyjrxdeo

epbf
rfobeq
bfe
etfichnybuv

idyq
lqiy
yqil
iyq
yqi

dhkv
spcnm

mpuijvlgbd
bdpfmreatciv

phj
jph
pjh
jpbh

hvox
odxh

tkiamnuv

enukxohqzridb
dioqhnrubkxze
xqokdubnirzhe
iudqxoknhrezb
hdxrnuqkbseozi

zxjg
xnak
kix

qoflemvucnta
lvaqmncftoeu
elqmofnvcuat
yvqlrcafenthom
vqotfncaelm

czrtsdaiw
sziwdatcr

vsytnpgefkwxqaouhcmb
oaeldkpvhbcryuxtfsi
ezxktcyfophsabvu
ctuaehvobkyspxf
yehbrcsovtakpxzuf

wjrd
drjw
rdwj
djrw
wjdr

t
v
t
d

micqdwj
rqjmownes
pqtmwj
yxwjiadmq

wmlsot
ufypiewba
vtsqzrwdk

xd
ux

gfyrh
vet
bml
pka

konhiwejsydptz
htwiogdpnjsy
sqbfvoywhdjnxtiu
nstohyjidzwp

oulvcfs
cfvslou
lvodsucf
tsvcuolf
sfoclvu

omfdtxpnqgwhrlac
qtmxpdngcfarwolh
ptrlngqxchmaodfw
zxmdcqfrtlhgpaonw
mtrhldnwpqxgoacf

hfmbnlwtujeqacxo
bjolymcdfhxaqwu
mcfahwxjsqboul
hyobucwmaqlxfj

okxygwhp
wvkxgpho
xyufhgwkop
okgpyhwnbx

ct
c

mrajcxniesvqtzhygfkp
nmaxyrvsczhipkgejqfot
ecmirqgjkhftzpansx
uaesfjdmixkgqcpthlrzn
qnpojcfksgtmhzaxrie

oinruztqxj
rvoumlcwdbik

swa
sayj
rxygsab
rzlxs
usdqnecvmt

kacytqiemxbwrl
nodjpvuhgt

tu
pte

nyat
nzft
rnftd
potnbg

pu
up
pu

swftrvkn
fnvwtriks

zvukcgfm
prdgtfkqh
gvckxzf
fkgi
fkzg

kyojecwftxlq
kymipznvgh
wjoukyse

jikgxfnpl
zkupgjrxilmn

l
l
ral
l
l

feuprzgydcvmniqtbhwsloa
yzguptfnihbemvqsdjkxc

wlpaenfhz
ehawliznq

nw
bw

vdtqpkxbrczjfiayumhgo
umoerhdfcazgtj
jldrhtzawcmfugo
zahcgrtdufjmo
muaglcntdjrfzoh

fq
fq
vfq

ldcsbpxaq
qcbalszxgd

nzvuexwaqbtkjdhpfls
vnfdayzbxlqskjuhewp

bejuodklarwyqmftv
wovrdtyqmbuf
bfoqtumdywrv

pcatgvxsfnemhd
juyahm

hsgfnxpyirz
pkychzfjasrqni

jvhzlgfsreoaqimytdn
ltcaybovrmhinws

hvpaxkrbyf
yprhbv
yhzvbpr
vpjhebymr
ypvbrh

vxbshtzumdg
gzhdbkvnymt
mghlcvjibrqewao

qwatcjvglnkoxbz
jlanewzf
ewryzpjnla
hapjrwlnsz

wedijntshvckmuagqroyz
aygdzjuvqetrcnkmhiwos

h
h
y

tkzajcrnldp
ptrdkcezajnl
lrkcdjspnatz

wpbavnk
pbnawkv
awmygpbfnqkv
wbvnkap
anwxvkbp

ciojha
ergycubzds

stxylmiduhbek
cdyluksmixh
leixuymskhd

ckmb
hcbskxmj
kcmqba
ckubm
cbqkm

zimehj
ekhjmz
zjmehx
ejzpmh
zadjhemo

uiyfxjtwhzgam
rzsbqkl

hij
cxhqiyj

dc
di
nahc
kzegxs
hqd

gwcmavtzudlyhbi
tczmgyaihdvwlu

knmowxtrgysei
owhxyln
xnoyw
owxnvy

awcdeyhxp
haidv
ajdzh
roamdnih
djhqba

wikxntvrqobmslp
pvskylqtmiouxgerbzwa

vtsodwufbxqagzjcirn
swbrznlvtdqgcuixoaj
xnbtowaqukpivrszcdjg
bdxiqvsoanwtgjcruz

tknlrhyecmdpgavfwxiq
etgzofqjhbxisrlwakm

qlapsncudif
lcpaubo
upcla

q
q
q
q

wthxvqcmkrnufij
cxumyjefhridbtk
itxcmpfjrukhv
usqhkciwmxjfzrt

ovqmbrgjxzehayts
rvtojeyghszmbaqx

wkdgt
dtgwk
ztcgwkdf
kdwtg

bnqdcjklozxsvhaip
tsboknhvzmpdxa
bydonswmearvkzpxuh

xouwszgd
zwuhdo
ouwhnczdxj
uodkfmqebwz
uzltdwon

ea
zae
xae
eax

glpjnaiuqhtcbvxkezsymow
myspguazhtokexidjvbfnrw

gtiykcduephanslqxbvzf
acbtimgdpoefuvlyzxhn
rltacidghyevpxzbufn

qbnlweychiavojgtpkxm
zwqlmncaxpouti
qntcxlismwoarp

ywkxe
sywkex
yexwk
kyewx
wkxye

uiegcdfsh
ugseifdnhc
defishcapgumb

otaj
sjdaoqtbc
jatuo

fymlhq
lifym
lpkmfhiy
muyfl
jlymwcsf

ijlhukadenrqsvxgbo
kcidnlqrhubegxsjavom
lkjidgnrusewohbvxq

kym
yk
yk

yzdjwag
anxrbdiq

bcmoyupkj
dhgzlx

tjhagzlncpqe
hoqbcpzgujnt

rtgifbclnsaehdqouyjk
wvjdyotzpmhubsaifkclqgre
tyjasohbcgxfukreqidl

jarxzitusmqcd
wmupfblqejszyd
jdwuqsonmez

lgfksnjtydbomcx
fmwgnksxbjcldeo

kfiroa
frkayo
nkaflrwo
rceokmfat
frbktyaco

msrjkzt
cer
rd

agvf
afvg
gfav
vfag

mjnwpxdzsg
lpdjfawbyiz
puvztdkojwh
gdzqretwpj

yxnubi
xibenu
unbixy

cfhxsvmuebgowktiyqz
hizkuswbefvcqtmoxlg
xtyogvkmbwscuizehfrq
gujihqmopzdfvwxksbtec

vntrdelmwsfhk
stlgfmrkvdq
krmvtdslf
tksvfrdlm
efmrkvwdlts

rujwcahnzpe
bfhzxdpjawtnu

fxjnvwmbgrdeqlh
rdwgmhevljbxqfn

orqvkhczeis
kieshrpomqvzt
svehozikrq
skrhezvqioc

wxgqml
gxwslo
wgysplo
lhgzw

oj
o
o

u
u
jeu
u
u

yiqxngbhocswjrfeudvt
ibygehckxwquomdnjp
bwcjixudyoqhgeanp

hydfix
yihxd
yndxih
miwodlxsgehvytk
nxidhzyb

qaz
zaquh
qazu
qclzba

dvofyzwgjt
fowjydztgv
fdzjwgyvto
yfzdtvwgoj
vzfyotdgjw

a
swa
a
a
a

lf
f
f
f

ehf
hef
ehf
hfe
ehf

xpwgek
ujmts

bfzl
nlkcqzb

claus
uacse
vhucajsk
lacus
uasc

bsdpxarynwm
ybawdxpsm
pmbdwasxqy
xwaqdbpyms

ayodzjplqursvtciexbkfm
xisupbmazlvdkyjterfqc

nqorupyxeicwljsbmhza
upcrsmlbojzqinxhyaew
pjysnwubqcomaheilzrx

nfilv
fwbohynv
elkfvn
evanf

ykzi
zjmck
zkm
pzk
kcz

rcwpgdonmz
owzdyrcgvnm
wognrzycmd
rgblkszmodnciwxq
wgmornhdzc

mu
um
rum
um

wdjskfix
wdkxjfsi
ixwjrfdks
sdxwjkif
dsgklwhxifj

wqvfmpctjga
mqcoafgntj
qjtgrfcam
fmawcjgqt

fmqectkvuborwidgj
gobjtfrqkiumvc
hnmctagybvzpuriskfqo

bpnwmazxdov
vnbxadleczwqo
wxodinbzav
xwnivzadbmo
dvoxzanbw

pkumcqohndlxstvbijy
vxwuqmcydjzenpbtlriksf

iduobhrnsat
otqruabhdnsz
ditrubnwhs
kvydthunsrpmcbgl
botunsrdh

idyepasroklnwuczhqjg
orijbtsuvlqphfmcgya

zohpdrxsm
dpjzohfmxr
prhgocxmzd
rmhzxlpobdw
zpocdymgxrh

epjurdmqkiszfow
umpqkgcoeldf
dmekufqgpo

jesvpxdraoyuzctklnqhgi
fbsqcraxhdzejgilytpvon
eshlqwkraypgojmxvzndcti
cdlieavgjphtqrusxnozy
cgotlexyhidaqsvpjmrknz

n
a
n

imwtv
iuw
riwx
ixpfruw

ghuwqisktymp
syuwmgithn
gwyustmhij
trhwyafugsliom
sphtquwdzygmic

mhrcbwsv
hmcvrws
hrwcmvs

otm
bvtmo
rtosmuxc

fcelpwgamhnquzbsrtdxivjk
tdjwzsaqhxunkfcvpbrmgil



# AoC-17 - Day 4: High-Entropy Passphrases
# 
name$[] = [ ]
func name n$ . ret .
  ret = 0
  for id range len name$[]
    if name$[id] = n$
      ret = 1
      break 2
    .
  .
  name$[] &= n$
.
# 
func sort . s$ .
  d$[] = strchars s$
  for i = 0 to len d$[] - 2
    for j = i + 1 to len d$[] - 1
      if strcode d$[j] < strcode d$[i]
        swap d$[j] d$[i]
      .
    .
  .
  s$ = strjoin d$[]
.
# 
repeat
  in$ = input
  until in$ = ""
  name$[] = [ ]
  for s$ in strsplit in$ " "
    call name s$ r
    if r = 1
      ndbl1 += 1
      break 1
    .
  .
  name$[] = [ ]
  for s$ in strsplit in$ " "
    call sort s$
    call name s$ r
    if r = 1
      ndbl2 += 1
      break 1
    .
  .
  n += 1
.
print n - ndbl1
print n - ndbl2
# 
input_data
sayndz zfxlkl attjtww cti sokkmty brx fhh suelqbp
xmuf znkhaes pggrlp zia znkhaes znkhaes
nti rxr bogebb zdwrin
sryookh unrudn zrkz jxhrdo gctlyz
bssqn wbmdc rigc zketu ketichh enkixg bmdwc stnsdf jnz mqovwg ixgken
flawt cpott xth ucwgg xce jcubx wvl qsysa nlg
qovcqn zxcz vojsno nqoqvc hnf gqewlkd uevax vuna fxjkbll vfge
qrzf phwuf ligf xgen vkig elptd njdm gvqiu epfzsvk urbltg dqg
sfpku viwihi fje umdkwvi ejzhzj qrbl sfpku sad nawnow ksnku
nzhj mfudick ueaa jnhz kpy pzk
euiin xvl elaoelu wbdd xlv jtm nohtq gfdbgdg gdfggdb edtym
xfmkn wyww woe hwysuh gjw dtk utryasc dela eluk vmmun
nmag qfwe cwslmgd nlhf hpf
ifs sszo iod isf jna
pjptwg wreera leyb hmlbpf qcrbma ylgue
rwlpo jhla rprxvgs quguh pyybwgl qqvcb
rxtcpdy wmpci mpcwi vwvdzdn nfpnj rcsxinl itatg ycy hrctg ron wveju
zmkfn wip pyiz pyiz tnyg dvftf elks ezhotbj wip
sgmtfdd xdl sch sch yaxzh wphgksh knzrixp yaxzh etm czqbaa jldta
gnbr rnpd upe eeb sbq sbq oxc rwvugoj
cshk thcc emfxx emfxx pbtcf jpim vltkqar czy iudkac jhpcc nqs
uzbvx fkiuyk izxdiu yutntvn dixuzi hkyfnud oyz ynutntv
ewl mfns idy fphu yqccb pte unukirt unukirt fdx
lzn tin fgena qbql qycbdw gbtn lctlysx adhjfq blu aiv
ites ites pbxzunl vljzh lqgerta pbxzunl
vmk wjfzvhn pqkidze qfwh
tqprmc exypl caf kwikh mdyyljc pbo hhxxo skna
sqxgejb ejc fvup hpesvs luz fcxqwhr ypxof fxlcp pxyk xiczjri
vjg qcw fsyqaoj mxf jha feclqqr vzdqnk verw mvmvm pvdqtcd xsfu
fwwn ktvdh aecfv acfve yjozxwo cnujw bcgde lphnk knlph bqwlqju
uwwapm dlln uwwapm uwwapm
huupab ewetcte huupab ewetcte
wjs zipivpd klwafr ipcczg wbv uujstsw hykn
mgojdyh hlm xruta lbmaxit pabqrnp vkyigd ptpzr glin gfau pbo
tbwx baqxq vtz jwex tvz tzv
efopwx wfknzb ogaxln tqzrh jne zugd zpxikma
rdjsa arjds hqdldw fjrtl midt qjv jfrlt
dggqohj bidaaty iah lgmug wwmlbc lggmu laonaoq erkqrb tqolnns iygv qnonlst
msc glwn xjfnij itt pka irrafjd euazydj silo
zsyut znsht ldky zsyut dzcdft znsht
iit cyteu pib fgvrs iux ffctql pib zuzp zsbb ieoi
xxtwlu kqfxjhq isj xqjhfkq dohrs haovzc cgfwfrt munqon vuyexz nouqnm
eptpqgi uiflvd acj livzq ejtt bniud cjdh jkrcken lspfy tpxri zibj
zxme dpo fumup gly bkdcwxn lsly eglhe
uoshw ijoyiql rcskaa vjbqv roiinzi fppqdu
xuw vdbxie oypcx khxq xebjt oypcx uitqep vdbxie hoz
lrjv tdksk uebo wktebvx nlapmp udhhxh uliqbm cklyyf jlzw xrmdlvx
fosspck fosspck fosspck qyidyur hxnxmb dkpj
rmrvlms susvos idw hzy idw tjgxbc lhgqxr tjgxbc uuq
etjmbdr hwqe lnfwzni lnfwzni good eisci etjmbdr
yqde bmlcc yuel vpyplss vyvhho kslgiu lllhc jtkijdj uclz hfbqsf
tlohlvv tlohlvv bdqahw tlohlvv qavcqrn penia saafy
lvtzyt qffe eaikhv eaikhv wbnl mdkg mdkg utfrm
luowwk magp luowwk oyao oyao hsb yms
gnxply vsdqum nprf jik axdp ariqjpc hjqcc
izbo nkqkb xpqg pgxq qpxg gpm jxbkvu resj
hsgyxar hvsl ner zzmcn lcpdvqn ern
rfjlhu xkyh hafs cvvk drg vjsk mymc iab ycmlubx kpwemiw
wlci qhhpr vhpr oyrili cnynh sivdso ldjya wilc ioiyrl
cdfwd mbtk sienxui jsmxzo yxbeyl bybtc covxaq yuxn ktbvztl ktbvztl rcekjhk
ptenhqv tzdt phetqvn mfkdz
hmezeak pqvqld amsih jxqacc uferfyh nfqjsz rtuqdzz pohcx qia cpxho hgpqs
iygny dluc uxqz nlujm xkdtlm xbdgepg jwn ohl wpfll
lnqf pcxy cpit enp zpj lqfn oowgw yoxdff ohvcfcf fuvz qkpmb
oydu jlscilm pzxen nmtdngu tslcupx ntdgmun uztpx nlhh jqn llsv
euyx epn gyvg cwtoe ruyap yaurp uryap obbl ovo
pgo irm ksrxe qotuygd afwh qfhzfsr wafh dqjbwce dzfo hew skrxe
dpvel dpvel ipljjxs vrrsob iakey uheuu swxu qmnmn mpjkb jqrwfmv jozj
sempz plzxqe qvyg sempz fejux
cqgqvg zhqir rqzih vyu fmb mfb
uejl kjh ayz dzimg yzafvg dem vlogg
htfkd htfkd hwykmm htfkd
oxvgq wtai rkyyxya ldkecdv
lvlrsu rsullv pptnrwi slvulr vxrk dpzti
gde ixwoz nnsx nhc nzi
dsadkj qtgya wco psyondq jayad crc lswwm purrad pof
nocibgs hxqdejv nlqxdpu dvzd
jfaws aiwnjm tqjpgs fuiobz gwnemv hjevs xkbbgiq sakgv zmwpkuq grjllw
xrr jwhtchs boaqkg wjhdr xrr
vyapct tgw juzgwkz odddvof juzgwkz
unuu kubdd dxr drwg
qpefzz iemo fwa vhdcxx
hseqy copss gytzub lxi mrxtwc hxqqdfx ijt kcy tafjs jit
uevse rrq zmwyjfe xljx lhgnyzt rngvwqd
gfvpyhq xpdhind eocgpiz ebs pcmsgjy swni iwns thspnh yvbzxz fgb
hxr ehw ekfd ncxcs gxjmd oqszdjp fgu gwuoafw zumenf qltbw whzuxov
wfc pawqo pim jxgt dtiwzil hdptivc slkazm htafjih hzheez rkk amy
mgoatiy pkec ddvwyni zuya aqrcjes ubkaeus nuhhad upe qfem bpcc
rmyeg qfq bia lzk fusqfb ltvgry vggr xaxi avwdkbg zhlzt
zkjoeee dyi sxdwfqa irqljmw gek dgdb mrakr ddaznn zlh ajzzacf juv
kmqcy pohbej hujdgao rsxfkn vlu
scnpa hvl cybql lvh lbcyq msw deqqb yjpsndq
ndhjooo dpf ziey jtjlc eesag ldhgoif
tysbae wkpst kjz stpkw sil yetsba
ghvlfq flhvgq tgkjie gqlvfh
oimn vlmsljl ocala vokhrs odyv msn dzly wcky
cfjwmh rpsdor bttnkg jxenm mwdk mer jgsusdz cslf
ialvxk bvc qjfikr caw puhmmfl xpmsx
tyoey egcf dijg vywd enued uxkshz nav bdrn hjugffi iobqwiy
eykhxck shpfjhk vlqg alkenz kuj okxs oeth mqbr nfvqvkv xfvyi mboo
zbw curcajm mel jxqcw mpdscxq rhadty zrddeh wmedc wkcwt yvwm
iee hzeofmh pqlkkb azlam fpj hzeofmh ripi
sawaqek oyoiwtb npq pisadk nnd bzgo wiqme lxnvn
obqx ffiegn obxq for xobq
zwway wwazy aqxg gaxq
ebssilw nuscati mofyc sogyacc yujmdwu ehxsx qcaf udvoo nlcfaz eov
vnbe wtzzjn bczyxt crmvas zujy kukq zujy kukq
gvltk kgltv kglvt zflikic
hby pium gut fjqn sksoqyq kcliapa
tbonrr prf vga jqgw ulze ukfig
zafixw hia omgwoi noeiox fqbket iviidgp bebune kwcuotp slvy wcx
fjq cyecn fhxvj byv kojvj iaqd aaxva rkogp
vqbbt sjmr mxu mxu rlfj yqhtzv cuar yde yrs sjmr
iyxiyp auepgw dtpbyvu thuoai fpsfkpn bemgbsk lni ozy jogp xldyvvx fpsfkpn
jtha ibn ahbkh xzxkei tql mycvmyh ioyw
mpsc pvdiuu wqixxlo cqwmlrw cttoz lad
srl xxlnofu dqf snxd zjlp htxzd
fkv berlbyh kyna wkme qjzgh thpw frup
irhreaj udkpbza qmgp ormlipa lbyuc
empizc apcb ossmtj awk ttsgi bfoymzd ftx jkicph qqjv tywp fwzfe
zaqkd ysn zaluvs rljdk ast fjp amjqr uabrya ufswzjg vcldkxt hzsmrbl
qvy tqgnwj akibr tfjevhv vav
mhe sxg hacoa emh kasf hid jklfy ijk dih
qvwbenk akdctm jztmsx aqvpodu vmknns nck letcrk poba
lhve kkvff iiixid vtsun uvgte mmlxk pgd
gktphd aaoqwz lrvsuw ofcyvmi suvwrl dpqiol wjgj uqigjx
tbp xoc lmz dyzlvp bjleh pxj xjp xbil
gpzgvj tctszm tctszm pnp upqtmm rribg tctszm sllsbr
hpm qvjnd lyqg bybpwn etz pwfigbg uqgrvpg cvniubo
tpowus bdncyxg gmm ebfg zwoue izgkwtx gmtfeg xvudp xgmjp atrvn aqgl
wlrxvo wvonohi owxlvr owhnvoi
knyo aiixyi sjtqb kukhgv qkj qiuefb syhfc aoana okmot tdsmnoj eyzqjn
szhto szhto szhto fxpsavu dtcz hnwqdvk iza
poykme rboczge tuyiw sxr
lpgbp bpmf aiqy exzqt gxdoow yjp fxwdmt eoklc jnps zbnbiwr ppvl
huecy jjhyz pwcea ffofmj tts
ahbmkw brz xdenmw mwexnd ncdxgf gcxnfd
yhfnra vqljz bkyxzt vhtsyde ysaxt qbw
gqhiej rofhmp soeebdp rcuiblb rcuiblb rrnh nses
pxrwe suil iihzf lhcgmfm mqasxh ttpp kqitdyf cuabaa
cxl cwsp qyseogj dimvv igsoxu ncrexla ubrvpp oum usluv
rkmo jqqcdjb mobqcta pbcmoi afjlh mork
nmohoeq fezpxh fezpxh yec
yxlncrt ivi dajo tjpim tjpim
hzhy rcjs uhyvwz tdpxlqw itoiyf
ded apfmhe stfk ugyujv drwks zagqnw mbbzmvc aoupemq
iezre wivdwif xzytxe xwytd vpnol pljx aot phln ztncw
ozblu asda tkxh xqe pvijnl qwwh uvp bdhtgjt uynwtav cdz uqmvp
eukgtsy kdfb bdfk tnv dfkb ewdemb
rsf cxnk cid qsa zwk oetnggn
fpq oim zetbmlk fpq oim xgv cbaj cjrqm
phgldt fhmkc efkztj qidri vsv bvjf lfwfgm wfuoln toamg wfuoln idrs
iuc rrdnk rrdnk asqhnz qxkigmo eeoim mmdtgif akk
rfvsyy kopfhmd tnv ibo demeqm gxrxw hwk ukorln bep
ialo eogif sxlj xfegx nanch egoif eymwt
kttrpjq gbnyiat kptg oarewx vkmt gbnyiat szyokf
tjll xviodi tjll efc rliugl wfbbpq wsqvdli jur tjll bguqyu
uecm yzjhn vqf labnc xyaksj
hjtef zzq ellr wtrodcg drwqo ernt uzx sqiokam
izmh ddutl bdzft jvfthh
ecr xqrp qlxstu kgprd gqvtwni mkughf bulabe bvoxkx
jwsna vjwq swkycg cpp dvmyal xotxviy qkiva ffa eakwp fww yirri
ufnl lpuxw rjki nggh ajdkpvo oeuaemy bjisma vsjzc
ctxu aavlw rap fzxtcp msufn fzxtcp sdlaom vgvdvpc
rftw cyf twyxi orifavd
ogiht ertz wcw jnqdup phvp lbw
tplpyq jeh aobamqe bvaim qptac gssi mkjbaj
nmklyg iitx iczojzr vjspqb uooky uooky hjk
ggnekbb bnebggk sepzjd fvqfgr
wnfwrn yaiogv mbusuy cpbcgs thjea
atndjc dbjgdz guedeay rasa kfhame pusuu dbjgdz
xivzyml xivzyml eqsykxo bshvz xivzyml
nfe ayx gscy ylyp oqyl isatnpx poaelm zsrw dpd eyrdjpq yllk
feqktz mlm jhi yxigeu xzqa qwv yquxw emken jgqsp rojfcu
ruvfcud poubal xswer hfhpyp guf pzgzoq pzgzoq jwgxafi guf kqzzlu apg
rxwcsdc rxwcsdc ywu rxwcsdc
dmgsey xrtx wldwyxz avi
yxnqv ewlx fvif ozfcbxb zqapa yudqksk wlxe mjpvgz
ozoa ozoa hwkbp ozoa
qcv drtqn uqv kcsavgn ybzs tkw
njmloq wapa srm srm ifurca
ezm ccj rub yuaww xhee liikjee kcabgic sbgqx vrpyo pzmesdp ksvv
hycyne raaksm nylsc lcpgn akasrm vxwoaum
zhugs pqquitv bae lyozb fhij pcdcc bae rygsgm pqquitv pizz
oxx bzk grpis qiqljwh svkn
qcq qqc fzgn sqg
lclad motw ukz zghp
glr okzfs zgv ygsvv sauuog glr amxr vvmwmu khy eyh
ukpxpy rgnqyaw ncm coeblf
qdbr ortzo spvnrnq uomtj vffbeva
miwar bidfxp eibo qyee
yldec ghwj mxlemvi imac klkvmg fekxhp kevlzfr fcgnoq fncgqo
hlm vlol qdic rltij nlzxfys rzpoh
krpwspb yrosr hioqla dbpgzgu dvkvvc vvdckv lcjzb qbsbr acbi rtnk
iqtvk jcldzuv smly whmnte mdwlse mkxw mfnkv mkxw kes owkfh
iwcjmkt rnb bjcdjl furhzuu exs
kjwu iuaj ixkujoa jzeau whpn
tvj zrdy fwsbagh zrdy czuzum lxotprx wbohaai
crsyzod jouf osxntw iwzzie bodu scze gjxn vgxvqo gjxn mmthykb
dabjfb vjqz cvr gsymwoe qzpusj twvwhw gyvlqd kdrdkzm bdljp cvr
vmswdz lgjsvxz yjkgqkg tzmjkfp uzbmwxe kuqa dzomt hep jjlibs oxvpvq cix
iqgd btwdjd ncdrovj ltxqc orwhdlo orwhdlo
nxro uxj ovgha elvzl xmlzssr wonimvb urecfx dbfn kope
tbes cgyh fypswue fgxjqtd dxdrfm pzhnaeu kugspa
eouzw qrpokyb fyhpb bcvfvze brdwey gpaa fpqutw pbqkroy axtc egamku gxk
xdrovpt peeww wkcin suir gvrbix
hgsjks juvod jtii iijt
yaw hzifa wpagkd tgvmc iru yyeuy mgcvt fhiza
lsk lks kls edypaxo
tjz qjs mgoyd gomyd ztjbex nprwk vvw rtjsq quvf vuziqtb oygdm
kftodz xua lyxt zfadf fgdwt zfadf xua ehwykd wniahd mqoarg
qgiapb xptk iscyf zfspn qvrpva egufqte zfspn hksw xwxrs dkdruku vegfs
wqifs wfsevg iwnjjpi oajju tkvhpl lemuw
rzbmhso pbvb lfgpq fzjwxxh pqlgf rbhsomz
ufi aiyd gxozgx hygjp dtma uughdc ojumcf yuadt
caami tqzkvor tqzkvor tqzkvor
vhtnvyx myxdywi mwpwq hjxadd qkcj vvytxnh dmbea
jvjtcjg mbiwyad cup xkrfk puz uxpmutf rjxyxyn mfchc
ocrak zprfbgu pjjzl zoehfkm xqn qki uxq tcv emknqjp wvmkas
nxg myr myr vnfzpoy
gwu ezt kbmeouj sxue cxax gcquz ieegnal xecusia vxf
xermi xermi qporwc mzemns ticltnz ddpsstr ddpsstr slgbn
xnujwtw bvzv xjwntuw unxwtjw
tipo akp fkmcls wglmjq fnrtsv
fan dfbya qrp lcvxqqu ldpm gucmeky mrzy fixaph rygneb ocm pjh
ovtrqs ujmbnal geihpe mijhy eewuic toaxbp ipy tvb evlmrtd lbujmna
lsmbwwd hvurk ihbuek hvoyq erzomhn gue lpq dihon dgzvst
fuoshq hfrzeu zfrhue ufqohs
icgwnbi gmhogxu gmguohx toixb hfwj haxlav hbe jdpxeyi xtgfi
vfakk ioil hddqu sdztx hduqd bmiuyr vmas
mcvjjhf sfgt sfgt lambvp dnqc pfecquk
xgr omy bmoadg afbna mar nicpazd iveku zdioyo
rpipon dwg wgd pironp
fkyx wjefuy mfesst ztlf gnnceb rsbvuk ckilt kliqnm iuifcvu
lmgzx oknwr wmttry luipa vcttj nuqdmy
iota efrxkk daqzm certtoi nnvqrwz qrqgza tllwp efrxkk
alde wqmdjy erh txrtqm zuljg hspbnrd pvsnebh bkue pvsnebh txrtqm txtthn
hgggm rswwfpj uctzrv bylqeen dpbnw ostsjwn jtjiyuh ofxu mmmqlg ayhza opbgdrv
qmhkh orbeokv agosach lhujcju jzpp wmxtcy jcxglu iuwmzrv xwkgz sxlzld
dzcdm lwal xpujjm xpujjm lpfojz lqqcon qmqrg
gmwugq ceslt rxcogaq jwkraq
joxr brdy yixlou brdy lnr lnr
wbut pxlsclt igigapq zeacg jxiezn hvws wwz ujpbl fdjtfjw opod kea
tsodswf pufo zqrt zvcpu
nyy mrqmg zkt tslzsf zkt
hxywv lbmogd hhv npyzgjy whfvv mlfqjr ggjz owijo zmesslo gtvizw
xzz dvpzxbd wxwlp cye rcqpgrr gynzo nhy gzpk fpfmb
nhaakbv iazpdc yadqbe kmqm dffq lidnh cegjosw kgd hwivd wijj
cwmdyf huoy awihev qav cwmdyf rdwck hahj pesfyk uoju zrirjdu
qabl vwcwbb phnd xnp huuzwxl rukbp kod sfu ngcvgrt buncnfw
regyd gjzfwf hpuv zmm vphu gwffjz
rdf emo crsoeo bksetj aqfzm pphny
opbmboi iakvj ymjwm vxoq qvox yafk zkch adlusz
qhm jul zasv xhu qnhjwzx
mjmyvd mezfuls upbdpzw awc qxta bzrx tjpjmj dxfyewc zorm
bko kfokm htcpoqc liuvj xhmpcu ccqphot dthvo pfj dtxpmu xoocm cmxoo
kxv eenns qhpfsvo gqoyv jzjho aoscl fetug agxmfea aygpt
javmegf jlmt epdwy egfs hwv uszcqvn foixpz iukh dbuhqgs zgb
zrex zrex xtx ydan maomp hqdhh mfvan broh wvwhqbu
phatsot joipm pmniq arqzmbe vurl bgy iwbwk oyhngcv vnzbzgm bgy
xprufgn vhca nrs abuh zwsxmhk mqrj tyslsij ojkdzom wepxg koodzv ypvyy
vop nnpz mcod mlli ntyhz laqztb kauqkla gmrfte pcuhaci
vrenj lypors prknc djbdkzv amofdx
lgig lojnrw obusoc fkwe ggnv pydcraq bvdivl vev mrojjs rxa
qeg tap jocwlsm vqxa lmjscow
gptlrgq vdasm erdc oparmw
rgbsa nacqhvm pczf anupcp upudwgp
jbnobi ifhzrd ihrkkf osw wos lrnwv
aiuntpl fcxpmz fplacs fplacs tipm gfotkx
fsbnd qoc ozmbi rqv fmbxh tuso kfoxvjn ocja zzs jwplx
muaklvq ghozoxh nwxbh mgoou ufptl ouhh reyuf jougckd dgprag
gwbnqwv dtrd mkzxinl erxl zmfa skuu crxmp wwao wwvdpk nxbn lglzy
qeejk wvnypc yfzyfcr eeqkj
nmcp fmkgfyi grfthau azw
kkallxz rjke ukbt ixkhfb bktu jkre
pxj mnwe djrjde gpsc enqz pdbydx cktfs jjeddr
mgplj yyunujc vis odee ccesa yyg yjcnuyu doo utse
flyy juvxomm vcdcyva lfyy ozxnuzw bmgns
kmsypi zpbyiv rrycnb qos sslwyeo jgbyv njltzt fuwk nwfb ozcf xqnf
sdcvgmy sdcvgmy hzv uyq sdcvgmy
fyox vmgxahj ywaxbmm ugy ruwc mys yrjwr ozsxb vaq
gjpyc sgdn kgm fbvq cziui nzy bwu ezjkkus jrag
kxcr tgjxss xkcr bembjv rbbiw bwbri
dcz rrhvdc zbonfzy ubjt
rvq yjnzswt vatkopb xlj dwxig dqlt qts iva
lylclc jptz rbidu lbt byxk
lwre vwriwh afixsi vwriwh
kmvbflr nfptw fbglxh pyas dxmn hemf segaz zrs
dvbey zmj xfoi bma udtxhb
yryng geiwgz bbrvjp ala
olzicp olzicp qhhslry olzicp
exf xdmwh xdwhm nhjsssn rmlkdb excguia fex
xkwgeso htys sjdk jizciy gjjl phgqdjh wzdb izew zcrumu llxfp
frkohf oifsm aisebkt ijsfkot ukk
koqf xvoior tpe erfpnp npnx
sneysk nsxki wpmhd mdor akrpvgz moicncj sbsj owfhj exw
oqqbvk xztx gtxlms icmo
lfy ltq dlzqlvi ovbrsa gzm nhcjq umbtgm nhcjq
iuopdzq cqaeuu xuzngq kxlx laml slvvr frtml tvioiez vyoomw xickbqh
ckahov mepeku gtaf gtaf
tlto cnnz kzsbkjo kzsbkjo
kqf comkf dvrkyl jdsqi rnwvb vxvd pok
hncq xcx yuykfs egrruvw yqh smcou
tywyq xeq cix yywqt jhzptci hybcoe
zsw zsgot wnu sumd azmuos qawjaz rpf zkxgwdu iom igh
vmxmelt gll ysbbt yboqoyz ykdglk cnypf otn owsz ipn epfeka bkmy
wxjpce etzyavi whb sxzft bfu dgwnbgc nfw sxcteis qqpk
kofv dgoyme vlza oxhbo lrqt uic tvfqiyy iaqm afnk
nsmpg wkibdcz dxbw tlxzm zgwe nqwjji eacbhn blk
shlgws eencr rtufah kjyvqw transt ecsq otbf
obs xsjceex ffqj sob djpq jcda zlskve
rfqtle klarp mtzrx rasr eisqovk rpt vymibt zwrif ilsnd
ldu ffd ldu tizfexr fwpmyan
flxso tzec pzn flxso kzdouon tkvkj
tvd arh qywql uev btvnpm
wtwx kzafvk ybyzmhv mdbrphy vamlvr gbxhod tyulba krcqj ikotmla qfhpa
bnfin ebngj agfdfzu rhjtj aaqzh fsyp nilar uwurjnu hhmso hhmso
uanmesj vshh syosjdt xkormf syosjdt ifvytwl qnw vshh jkg
epyzcn pgdxgye lecnx nebg jzdhvge hfy imiyft
zonbcnv vuvg sxtuty zdhmiow lmud cuegzg
bxgft mxhzrh unqd pqpsnce khykn qlb oujdxpq pxrd jzxjuxr tij
qss mqirowz ijjswjm jjer utwn kuedqxx bxshuok qkfag dmfwcr
jgln zdohd xitfbge xbokj xxeuv wqhvhjo erg cua fhc mhwy
euo ousht ipxt tpzq vnbmlo wvbjpb yjg bwpjbv nzvsea aerhsqv
axhmi bcf zdx vplso xhmai qsk psolv
ydnpmyo pfba zmo nat ykwxvm ydnpmyo rtd uuvqqr hcfccbd rtd
ytp guw ydmyf rww oucmpf gemhpj labc
edpbefn awgg qzpe aat cupig
mmi ghdaoh ibx fbyj gge vmmssen nplt mmqcra omcvm uwa fxypxfc
kjaw mtijne cfmsigd zwcjjd ajxjlqr tbp bnilc
fse ele vcsyiv bfe udny vznrao mgrjfgw
hadl nikvvpf gmdg bkmgt ugj
xkis qmr cgz nresp gms zrii coxkke vfsqiil
wmicbf bkk wcwklfg vpcbeg kfmjab vabc dax tnao tnao fvvzeyq fqm
bct tvj tra soo stqao kqua ikupoy wulcu nauxkkb pvqxy bfu
wpz txdduxq gaehfki kxo lvjzpxu iqon swr eyihl nbbec
fuphnbj bdtz huwu zdtb ilgzpa uyaut vpy viff tuuya
cvusbh bgy apsao qsupha
jtzlbd ljfvh wkjrw xsah sef jygb pqym zbcwok zdmug qpym
hbibuax iorqc dqjrs daeb iorqc qiw sagyt rkc sagyt khbr
shz mgn pqrdbm jvace gfhnq ann zosq wdwzmuf kswsg dzt brlavyo
qiw cdvwds dckpruy pybjra lfvgfn cwj bajtud pojehb rzrzvwe
txfyk zkgeeu zkgeeu zkgeeu wskcv nccoz
eettnxq gbgr uiqonyz wqtgs ozfjbn gbgr
svd thmmr rbbtxn sxkq isxlnhf tamdlbe bqrgvu nmpvlkc spko
qmn rspbjme ikjddkq kdb ugpegi egipgu
ufffijo revqpep zfw kwd pnya blqo rnntzx anpy
piaeyf vbeye uuqd vbeye
hamd hap ekk lgla twto
isniinr crz sjpmfxn uskwj
lzeofk tavbq ijcglqy lvy jliqcyg lwlip
uhyyyw itlrf tdc iabeocv jzwnjh vqxll nefze pyrxmx eispxnm hzlksce
ucuh mlam bhyej rgzkew ctbo iswqnvg
ytmb toppqgp ytmb gqgpr gqgpr vps ebv
eavn atkqltv bjvojs kaskr vqltakt uiktr xglc eyb rkkas fhnf eaorqm
jmfipc ujggeh hdxpfa xtab ydkibi ycxn ujggeh icheh vpznael oprbf
xazqxg khlemu awh uwz vhnixk vdcty hkk
gcl kayi hfozask grpseyn zviy tzoum qywnr wqkhq
ctrrcpw wqfbylp wqfbylp wqfbylp
gtk lqohf hqeaku mdj zrfkmxn bcqgf msing
luhpel kexokpx vojap ldaexs bbbtz
oimnqb esg zyjmbfh dfyhcf khpo zjtgm yelztbs ugj zjtgm mxro xyfxpk
dgtsu vvk wwfugbx aai zlxab beyxcg bpx chc bnxui
irrwbo orwibr lqt qtl tqknh
ihjsg ihjsg powwy pycyqo ihjsg
xdcu outh fnqrc eihkss bdylm sjunib eihkss
jpnw ycimse rffu ismyce uhxl feai
yyodnh dvwshkx vulh pvxj ydhyno hyodny
vuuweg pfguvyu orhei orhei wrm amkr xecja lmnveth
wriwe xgtnvj tdmxf gadtqh bezjvz lifu
euft tchbm xmtlwji tchbm
cfi zudn zludl pwiu axe psed
dbtfwf ajxcudj uaxdjcj dxuajjc zouyy
fmycmej bqhe jyfecmm kkrv kcdvjoy
grtb uzs rkxzt hivhic brtg hwyc lsl iivhch qbcp
ymn xfpka hqm sldz dblvsoe
qrcapma hntgmy difrkpk difrkpk xlsph
flvqh akcw boxrz ywhq boxrz esnxzv boxrz
zrvh jskaw mfs fkj
abveb qxfnlfq abveb kbwiyvd abveb
pgarl nbfrenx rnxgx bdlkix liltdm dzcokeg fubupcg iwp xfayp obfaz nevfw
nuhvaci blyv fcsp adlanka sjy syj ysxl
avwakn dkoya yzuszuk lqrr oqfyd dmgbhd lqrr
pxa mcvtoug nlweso yffqc dtuagcd ovvrkz ggfhw wnlseo bpqbn ohxzs rxzo
djkcl kbgyfir ogquot uoqotg jtmyd ohudvle xrnbt yvsln wykqt hntc xlrhqrb
ykt tkxfmd exas kty
zebstke msbbndq itmli ubexmht vekvd xbmb iajbj wac sta
ptdg oftwo goiulah tfmsrqs jffxvnv ozaluj qlhqjy wyffa
xeq ezmlpw xgno xorvfo yzq vwif wsi
hdove hqbzhu pjrxlj uafuh rizlb advmkca
jzk ddoisdh tfjh yuvikps ixpkf hnu
kixa djx uksr ogxty dxj clda ukrs
xgiy diwbvn vphdbg qnelyz tqptqig lenyzq ecsswj
alx awj fpasmmg zukuh qaanvb too nvskuk too gnria
suo suo brw nazq suo dqv
tan uxiz oqa xyezcd lsaicjr bosiak rmmh
bidpomf dimcj qekero wbrc lewt kmgmlao
bciacj eye lxfpef cbdshd dhdsbc qwnhil iuokc
zduefht lrgfjn nclksm wpjpjr hkeqd oprsjcw
chhdr bram swdfjr yikqra xkzsloc otptp agec hhdrc uofljf toppt wpbyrwo
bwlpb nishr knnrysj bvr ftnb iedskch weo
czo hsfp wblh cru kzalun intt
jvob rppz rkwv hgyhrqg
sgo hued jnygge izf ztan kjgpcn fagff jsi ijcxzoi tgqjjp tgqjjp
ltjq zidjy rfmy yevuaa nlhfyg xytdtle wsqvzzx wfflboo nawhv golhf xhsti
bmtzlml xcbsquq vnfsux voep lkss ioim
ntfffh gcncwu mmymn wkwlswa gcncwu iaeyumz
kcgdm rbaau cwsoya pznnnn xzz zbbdlhw zxuelq xzz pjeq
xrmnuct kwvykx khxr ioua xnmtrcu xrnctum ujq imnt ecee
xjsgx fby fby fby ggtpgdm jqvuj qshewki tkml ymsazcq
sdbyhwg kewtrte novhdcp wbuaoh dtytgtx zez whygbds hpg
tjvaqo yrycda yrycda ldbp yrycda
kloi tmsocmx dza sqtxc wgevs zlevs vtm
ftnx drvdm ryjfdgw nerynh cwfjpa mddvr
wsqjyn svg ncw aesn hvuq vybajti aesn bql atxhp ipu
eye romgxj gumuke jwi jrf dtt kcj wmg waw
ptltud oymklv fgnmbc ete apanovb vpt vyospi
clkguhu rbxs lxtnmy ferdx qbmrpg pvojnj zbcffbp
itngp dvtlq fzxp cxrf gbxxqp aafls pfe bpxgxq
nmikrui ddsq srfilr gnuvghu mwnacz nlbdm zcjm uylgev umzu mftz nmikrui
bow jmnxyen bow hvz
lksibxk lefzh lksibxk nkxsi nkxsi pldvhk
osjlzns pihvr zpeu zxjgjb xplykfk xplykfk
hajmfss cardd kaddjw uicfde taue
rgwdjra sgifh ggt mpzx usghkos oob fvzx ghnyxr sblcif
dtu gnihpry kjdpiny xvax itmluk fxvgaap bei xuq wzcy rhb hailtgo
wwob ueldq ueldq glxc umimwv onu dxhmhis ebottoa lnysfiu
zfbyi eyq etaj idpbkf
qshcfjb ozzqigv raztm ymcv sgivwoc kightf dcaglk udah fdm
jmxr jrcnck enffwfl jycc jmxr cylnigo enffwfl
bkslhv tykqw tykqw mbeqrbt tykqw
vogf nhqltpt nhqltpt vogf kpc
ryayz ddktu rfhkmx xok xninjcm ijcrw fxu
cmezfj zaamjrs whlcuoo mug lcaqhkb ymkdci qexa onhgk pgy
hcrcok qri fki wbiog ptj pmgtdt
xsl mpfxwbz bmzxpwf hrysu bmfxwzp xfja
gybzho ktokndy rzkbr jcnp ahicq weccg pgrodkt che vaglyn omhmpo
vdv bngjox srs faymg xrmf enseu aygfm gvsd
nuzi xodkbag eevovl bfjuv nuzi xmejqn
kcswegw bpa dgil insf insf
stg tklrut poi knurfpf
pcs dgirfie yep lvkfk ype hntt athvad clfybsq ofjhegj epy qwawns
wjtpgd wjtpgd vxnapp mwyfsm vxnapp rvcswcs jksa
ckzslrg wdzeimw cqhp nfgk zgukvd yyt tra erkx wdzeimw
hsww avl vkmzej hsww
mum oczj jfew rag zjoc wjfe yqynjqt cbkcsgo mri
vjhfqdi vjhfqdi npfa pzdmy utlyw bwvbfm nqdv iiap ygpky bwvbfm eocya
ewkqi ckb yviuro mqz vtrdam yzkqzv ppbj lhmj blkafo juxvwke lvewc
ljrewgx sutnb hfsavbu jofr ltml mjzkzz nmjii sutnb eonegt
cxzv nepyrb wmejdo vwqi aeqys
sbx fmne obzdz rdnfb gmb sbx ykcae hbzom ncwju rhpiao obzdz
lsgfun cbmfjwk fya ktzxbwt
ica bpsk bwjwkp obloxdx uwoqdo bnnhjuc tlsx qtaacp bdooxxl jamy ade
psus wmtkg ikvfx fkvesj upqlhfs ueje nyt abxvo
adlbl hzskbrp ooht nps
wtcgnvy nvqtvx tvgnycw ntvcygw kkxcp zyjmpbh
xfxww xsddqe ewvmgw qxqwy wpabtz ppe zuiw zubcc onaqii
kkaeec xhcakul wrrvi dtlqfy ahqdilw bnt gwimw espaivx nam yfv
lxz jtc nkwgz nbgsao olsck emtltf xidwcvm lcjxq
eav dzh hnbp hnbp yeg
egaq yvat kavsige csar zsi sptai
pofijc ibdnoe caoazp azlnjk dqp chik lowll iby gpvjv ohm
ors lexk zcneaj rmesx jman uqkb kvkq zfufmn
qgsyzxd hlm juerg ortfzw hxjzg
fxwy lcoc fyxw pzhynp yfn zdzrz
datmws ckwghgr gbtyf lqrpfgl mbgpd dyjilr fgybt hxpg
mxw facxdnu wxm urltwtf qfo wtpwrj
esa srypq jauwv dpm wdgqq hrke icvudq bdmubb ellhfjh ttpjjd gxmg
gvwvqwj cbzzuvj eckube adqinpa djutlue wcpw vrt ucqwu ekruwsn
fhj fst zmtb yhwk dxlbozs fcb vjvuxin dxlbozs rixdvu
egfoep cvq icd prwj icyg
aojaa ezmcuf udreyi bja cyrtpl wjl
gjeka bsbufp tbqqq vbmnqg sfqtgac odhq xzsxt
yse gujdr ugjdr sye
tax hntqw phf eixjwfh qkylnu nkyuql ugsuj
wyh egum zizhfc jrq htbyug lop dsu
exh vfdoosj ajrna jbiaz lqsgvks xklqgjv abtmdud
juqc ormfa sab tucsfln detqfo feg kifsion juqc ovhra
hvcrh oddhme omzmu vmy she xulvfa fecmgi
ayo gspge nkmy yblsj lrsre nkmy pwocjz gdexqqx ovovm
acy sqcz ijl htt yjsi rly vea bck
bniafe yore xnh rkcfd hxfuzw xlr nkzmmcs ekwggiu kgoboi wfuzxh hwfxuz
weq crkeq cccphe dtozviy kzkkdr yku cephcc ctq zbau dewpi
vfla rzpl bnmx uvggon foivrb fval
ziaove lawkpdn ddwl sxj krroj rqmffxv babb
bdw dsifr kuueet hugddwt piz dwb sjixveg kmsoknq
czl feyxf soyvbj tnmpjn kklwi akx nqepntc
nrmhc tkkn jrxgc jrxgc tkkn
ufzn mrhiapi qrme kjlf qrme xpp qrme loyzizz xqm coli
qvaoye mysv ydfxr iixrw
dql tqarux fxqfn haoinu lyati xml
kyve obatly dgfjt fjz sqrz xlbst lgwlt zovih aepy otrpl oifid
ymawam afgye lcnpkmv feilfws vonseh rxrdco
tqij kuawg dmova slds imdtb sjsafo ffkzzl pxxenva wuakg efbgx
yrwoaos vpw ijjpua jnbxl sev yvgdxzr mpqa vpe lboh sev
krwdtd uglxtcz mljcgdk lqj fgpfle nuui cqk exr nuu oyn
dwd nwt idhclm vgkh rpubq wybhapp
hskhgpy gzvz jztbr jwv vcx vdjmnjr jrsp
ikml ceuhcng biu zoo gra bnnforx abzan hwsmd lmki tsl yvogo
kqfc younaz azvgfz gesajr tmwxvyb vmcdu dclwh rfjwhic slfym
pbrhjml rsacryg jga qvgks neh fcq qmi mwb juezk mjteeg alkb
pcj ujstl fkrqm eeczrle hbkcvm upbo mrb qrspjt
jbq rrk xjl rgokbnx hor ogg szxqu hysy vqj piorq wtrtrdk
bnq ntvhcrf vrm puer kde xaxkja sfxgjf
pgcicus hqeqkkx xqekqhk qqkxhke
puquxi hmeaehh oxe tasipw qzyg hyvy wcmpwe
hvs fxq wvfy zjepsl dvrfxnc xnvg
xle crcuc qkhnv crcuc oedez bjw pmwq
xzzpiy cjwss jwscs apb bpa
ydjhhf yeltadb lwi cjdcb ovaox xrdm vkxub
zax xza admbc lvpzfeh auxn rwasj
kebx eild nrskdr meja jxczomh gcne




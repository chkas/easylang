# AoC-20 - Day 4: Passport Processing
# 
repeat
  s$ = input
  until s$ = "" and sx$ = ""
  if s$ = ""
    inp$[] &= sx$
    sx$ = ""
  else
    if sx$ <> ""
      sx$ &= " "
    .
    sx$ &= s$
  .
.
#
for inp range len inp$[]
  h$[] = strsplit inp$[inp] " "
  msk = 0
  pass_valid = 1
  for i range len h$[]
    valid = 0
    e$[] = strsplit h$[i] ":"
    h = number e$[1]
    if e$[0] = "cid"
      valid = 1
    elif e$[0] = "byr"
      msk += 2
      if h >= 1920 and h <= 2002
        valid = 1
      .
    elif e$[0] = "iyr"
      msk += 4
      if h >= 2010 and h <= 2020
        valid = 1
      .
    elif e$[0] = "eyr"
      msk += 8
      if h >= 2020 and h <= 2030
        valid = 1
      .
    elif e$[0] = "hgt"
      msk += 16
      l = len e$[1]
      h$ = substr e$[1] l - 2 2
      h = number substr e$[1] 0 l - 2
      if h$ = "cm"
        if h >= 150 and h <= 193
          valid = 1
        .
      elif h$ = "in"
        if h >= 59 and h <= 76
          valid = 1
        .
      .
    elif e$[0] = "hcl"
      msk += 32
      x$[] = strchars e$[1]
      if len x$[] = 7 and x$[0] = "#"
        valid = 1
        for j = 1 to 6
          h = strcode x$[j]
          if h >= strcode "0" and h <= strcode "9"
          elif h >= strcode "a" and h <= strcode "f"
          else
            valid = 0
          .
        .
      .
    elif e$[0] = "ecl"
      msk += 64
      s$ = e$[1]
      if s$ = "amb" or s$ = "blu" or s$ = "brn" or s$ = "gry"
        valid = 1
      elif s$ = "grn" or s$ = "hzl" or s$ = "oth"
        valid = 1
      .
    elif e$[0] = "pid"
      msk += 128
      x$[] = strchars e$[1]
      if len x$[] = 9
        valid = 1
        for j range 9
          h = strcode x$[j]
          if h < strcode "0" or h > strcode "9"
            valid = 0
          .
        .
      .
    .
    pass_valid *= valid
  .
  if msk = 254
    n_valid1 += 1
    if pass_valid = 1
      n_valid2 += 1
    .
  .
.
print n_valid1
print n_valid2
# 
input_data
eyr:2029 iyr:2013
hcl:#ceb3a1 byr:1939 ecl:blu
hgt:163cm
pid:660456119

hcl:#0f8b2e ecl:grn
byr:1975 iyr:2011
eyr:2028 cid:207 hgt:158cm
pid:755567813

byr:2002 pid:867936514 eyr:2021 iyr:2012
hcl:#18171d ecl:brn cid:293 hgt:177cm

hgt:193cm
iyr:2010 pid:214278931 ecl:grn byr:1953
eyr:2021
hcl:#733820

iyr:2010 eyr:2020 hcl:#866857
byr:1934 pid:022785900
hgt:161cm ecl:oth

hgt:166cm
hcl:#602927
cid:262 ecl:brn pid:393738288
eyr:2021 byr:1928 iyr:2010

ecl:grn hcl:#6b5442
cid:317 byr:2001
eyr:2023 iyr:2016 pid:407685013
hgt:177cm

hcl:#86127d ecl:grn pid:113577635 iyr:2018
hgt:180cm eyr:2022 cid:59 byr:1921

byr:1984 eyr:2023
iyr:2015 hgt:152cm cid:177 ecl:amb
hcl:#fffffd pid:379600323

hgt:154cm byr:1930 ecl:amb
cid:101 hcl:#fffffd pid:919013176
eyr:2024

hgt:76in hcl:#a97842 byr:1920 pid:612193949
cid:337 eyr:2026
ecl:gry

cid:262 iyr:2016 ecl:hzl hcl:#efcc98
hgt:159cm eyr:2020 byr:1974
pid:520627197

cid:302 eyr:1956 hgt:158cm hcl:#3355a2 pid:282247859
iyr:2015
byr:1979 ecl:gry

pid:156126542
eyr:2025
ecl:amb hcl:#733820 hgt:187cm
byr:1938 iyr:2020

hcl:#341e13 byr:1952 ecl:blu iyr:2015 cid:230 eyr:2023 hgt:59in pid:955240866

pid:783635907 eyr:2020 hgt:186cm ecl:grn byr:1925 iyr:2013 hcl:#341e13

byr:1921 iyr:2019 eyr:2027 hgt:175cm
pid:355931973 hcl:#18171d
ecl:oth

hcl:z
byr:1947 pid:164cm hgt:146 ecl:hzl
eyr:1976 iyr:2014 cid:160

pid:686203227
iyr:2014 hgt:170cm
byr:1985 ecl:gry eyr:2023
hcl:#c0946f

hgt:192cm
iyr:2016 byr:1954
hcl:#c0946f eyr:2022
ecl:oth pid:371575068

iyr:2013 pid:877594317 hgt:72in
cid:236 byr:1922
eyr:2023 ecl:brn hcl:#ceb3a1

hcl:#602927 pid:277638047 byr:1944 hgt:178cm iyr:2019 eyr:2028 ecl:blu

ecl:hzl byr:1979 hcl:#a97842 iyr:2019 eyr:2022 cid:91 hgt:164cm pid:371132831

cid:346 iyr:2019 pid:335209743 hgt:178cm byr:1993
ecl:hzl hcl:#341e13 eyr:2030

hcl:#ceb3a1 pid:863130968 byr:1964 ecl:brn
cid:94 iyr:2012
hgt:153cm

byr:1980 hcl:z eyr:2039 hgt:65cm
ecl:lzr pid:96101128 iyr:2024

iyr:2017 eyr:2027
ecl:grn
byr:1956 hcl:#888785 hgt:174cm
pid:565437685

pid:769106108 cid:77
eyr:2024
hcl:#602927 hgt:164cm ecl:gry
iyr:2017 byr:1947

iyr:2019
ecl:gry
hcl:#fffffd hgt:187cm eyr:2022 cid:212 pid:475618502 byr:1993

hcl:#623a2f ecl:grn
hgt:191cm pid:166515049 iyr:2018 byr:1971 eyr:2022

iyr:2011 eyr:2029 byr:2029
hcl:2912ec
pid:15469000 hgt:150cm
ecl:#4ddfb1

ecl:grn byr:1941 pid:273390626 hgt:166cm eyr:2024 iyr:2010
hcl:#888785

iyr:2015 ecl:amb eyr:2030
hgt:156cm
cid:301 hcl:#18171d pid:677032916
byr:1957

ecl:amb iyr:2010
byr:1967
eyr:2021 cid:128 pid:104999760 hgt:162cm
hcl:#c83b73

eyr:2028 cid:173 hcl:#7d3b0c
hgt:161cm pid:810244270 ecl:gry byr:1930 iyr:2013

byr:1975 pid:7243957480 eyr:2028 hcl:#cfa07d iyr:2019 hgt:184cm ecl:blu

byr:1953 pid:807621409 eyr:2020 iyr:2017 hcl:#ceb3a1 ecl:blu hgt:157cm

pid:976089116 byr:1920 eyr:2020 iyr:2011 hcl:#733820 hgt:166cm cid:330

pid:896621814 hgt:179cm ecl:blu
eyr:2027
iyr:2014
byr:1965
hcl:#a97842

iyr:2015
pid:827722366 eyr:2024 hgt:188cm hcl:#ceb3a1 byr:1963
ecl:oth

iyr:2014
byr:1959 hgt:150cm hcl:#602927 pid:948589059 eyr:2027 ecl:oth cid:215

eyr:2029
hgt:171cm iyr:2019 hcl:#e9317f byr:1926
ecl:gry

eyr:2020
cid:260 hgt:155cm iyr:2011
byr:1948 hcl:#602927 pid:651156700

eyr:2027 hgt:188cm
hcl:#873cdf iyr:2019 pid:738493109 byr:1979
ecl:hzl

eyr:2025
ecl:oth iyr:2012 pid:563787480
byr:1978 hgt:164cm
hcl:#18171d

iyr:2012 eyr:2028 hgt:190cm ecl:blu byr:1971
hcl:#6b5442 pid:758307028

cid:186
ecl:amb eyr:2027
iyr:2019 hcl:#c0946f hgt:165cm pid:904275084 byr:1997

pid:382971064 byr:1932 cid:77 iyr:2010 hgt:158cm ecl:brn
eyr:2027 hcl:#602927

hgt:156cm eyr:2028 pid:249987568 iyr:2020
byr:1956
ecl:grn hcl:#fffffd

byr:1947
pid:190618020
ecl:blu
eyr:2023
hgt:192cm iyr:2012 hcl:#b62955

eyr:2022 hgt:191cm pid:699194379
hcl:#f0a94b iyr:2020 byr:1996
ecl:gry

ecl:brn hgt:69in
pid:368841807 byr:1971 eyr:2020 iyr:2020
hcl:498a57

hcl:#cfa07d
iyr:2012 ecl:gry
pid:034993671
eyr:2028 byr:1934
hgt:156cm

iyr:2013 hgt:65in byr:1937 hcl:#fffffd
ecl:blu eyr:2028 pid:777520867

hcl:#c0946f
byr:1965
eyr:2023 pid:289861622 ecl:gry
hgt:185cm
iyr:2012

eyr:2023 hcl:#cfa07d
iyr:2012 hgt:62in pid:447717379
cid:309 byr:1977 ecl:hzl

byr:1934
ecl:amb pid:385150170
eyr:2025 hgt:178cm
hcl:#efcc98 cid:294
iyr:2012

eyr:2029
ecl:gry iyr:2015 pid:396708902 cid:107 byr:1983 hgt:160cm hcl:#341e13

hgt:158cm ecl:oth hcl:#cfa07d
pid:032310453
iyr:2012
byr:1945
cid:60

pid:304883665 byr:1932 ecl:grn eyr:2022 hcl:#a97842 hgt:174cm iyr:2014

cid:321 hgt:186cm eyr:2022 hcl:#623a2f byr:1952
iyr:2019 pid:857917879

hcl:#ceb3a1 hgt:157cm byr:2002
iyr:2017 cid:245 ecl:amb
pid:142383109 eyr:2022

hgt:176cm
byr:1999 ecl:oth hcl:#5e0906 pid:101108193 eyr:2029

hgt:168in pid:8803058749 byr:2013 hcl:z iyr:2027

byr:1986
eyr:2023 pid:108222056
hcl:#c0946f iyr:2012 hgt:71in ecl:grn

byr:1955 hcl:#a97842 ecl:blu
eyr:2020 pid:164459538
iyr:2018 hgt:175cm

byr:1950
hcl:#341e13
ecl:grn hgt:177cm cid:273 pid:473932418 eyr:2025 iyr:2010

pid:366720897 hgt:187cm hcl:#866857
byr:1967 cid:178 iyr:2014 ecl:amb
eyr:2027

iyr:2018
hgt:174cm
eyr:2024
pid:478505944 byr:1938 hcl:#341e13 ecl:amb
cid:181

hgt:180cm pid:178969784 eyr:2025 ecl:brn
byr:1938 hcl:z
iyr:2013

iyr:2016 pid:447434977 hgt:71in hcl:#733820
eyr:2023 ecl:amb byr:1950

cid:173
byr:1945 ecl:oth iyr:2010
hgt:163cm hcl:#a97842 eyr:2025
pid:418871498

hcl:#623a2f
ecl:hzl byr:1937 iyr:2018 pid:017817627 eyr:2026 hgt:163cm

hgt:162cm
byr:1982 iyr:2012 cid:123 pid:099838535
ecl:hzl
hcl:#efcc98 eyr:2021

pid:041801541 ecl:brn
hgt:184cm iyr:2013 hcl:#6b5442
byr:1969
eyr:2020

ecl:oth pid:314689468
hcl:#fffffd byr:1934
eyr:2023
iyr:2019 hgt:151cm

eyr:2021
pid:206164494 ecl:amb hgt:158cm iyr:2014

eyr:2024 hgt:162cm hcl:#cfa07d
iyr:2015 pid:269887041 byr:2002

hgt:179cm
byr:1953 hcl:#a87847 pid:966876004 iyr:2016 cid:193 eyr:2022
ecl:oth

ecl:blu cid:111
iyr:2019
byr:1955 pid:659491942
eyr:2028
hcl:#602927
hgt:179cm

eyr:2030 iyr:2011 ecl:oth cid:83 pid:160688997 byr:1994 hcl:#602927
hgt:180cm

ecl:brn eyr:2025
hcl:#130738 iyr:2012 byr:1950 hgt:167cm pid:686738997

hcl:#c0946f
byr:1937 pid:208013639 eyr:2026 cid:309 hgt:155cm ecl:hzl
iyr:2015

ecl:amb
eyr:2022 pid:181247866
byr:1949 hgt:191cm hcl:#18171d iyr:2015

hcl:#3fd612 eyr:2025 byr:1981 ecl:gry hgt:184cm iyr:2010

byr:1969 ecl:amb pid:770110016 iyr:2012 hgt:193cm hcl:#7d3b0c eyr:2020 cid:171

byr:1937
hgt:162cm iyr:2020 ecl:blu hcl:#866857 eyr:2020
pid:057170032

pid:516772675 iyr:2018
eyr:2027 byr:1962 cid:233 hgt:176cm hcl:#623a2f
ecl:hzl

pid:909808739 hgt:165cm iyr:2018 hcl:#18171d eyr:2028 ecl:hzl
cid:254

eyr:2025
iyr:2011 hcl:#a97842 hgt:65in
byr:1981 ecl:blu pid:722094416

eyr:2027 hcl:#866857 byr:1953 pid:532811620 ecl:gry hgt:192cm iyr:2010

hgt:161cm hcl:#7d3b0c byr:1983 ecl:grn
pid:242124004 eyr:2021
iyr:2017

eyr:2027 cid:240 byr:1955 pid:969478946 ecl:brn
iyr:2011 hcl:#341e13

iyr:2013
eyr:2030
pid:032502598 byr:1945 hcl:#efcc98 hgt:162cm
ecl:gry

hgt:165cm ecl:hzl
pid:851962288 eyr:2023
iyr:2020 hcl:#888785 byr:1981

hgt:170cm
hcl:#7d3b0c pid:897882367
cid:207 ecl:hzl eyr:2030
iyr:2020

iyr:2014 hcl:#623a2f
hgt:176cm eyr:2030
byr:1932
ecl:brn pid:676358652

iyr:1963 eyr:2034
ecl:#698113 hgt:76cm
hcl:z pid:174cm byr:2029

hgt:181cm byr:1966 eyr:2022 hcl:#888785 ecl:amb pid:692426080

iyr:2019 hcl:#c0946f byr:1948
eyr:2028 hgt:156cm cid:204 ecl:oth
pid:229984095

pid:859107750 hgt:188cm hcl:#efcc98 byr:1992 eyr:2029 ecl:amb
iyr:2010

pid:754939860 hcl:#602927
hgt:164cm cid:261 ecl:gry byr:1966 eyr:2027 iyr:2011

eyr:2027 hcl:#602927 iyr:2019 hgt:71in pid:368543014 ecl:brn
byr:1991

byr:1934 hcl:#341e13 pid:410490656 cid:66 ecl:grt eyr:2028 hgt:188cm
iyr:2014

byr:1932
ecl:amb
hgt:188cm eyr:2020 pid:29447176 iyr:1947 hcl:#a6304b

byr:1980
hcl:#733820 pid:800459957 hgt:191cm eyr:2020 cid:337 iyr:2010

eyr:2029 hgt:155cm byr:1994 hcl:#6b5442 ecl:grn iyr:2010 pid:978117883

iyr:2019
byr:1958
pid:466450124 ecl:grn hcl:#7d3b0c
hgt:182cm
eyr:2029

byr:1970 pid:810234340 iyr:2014 cid:247 eyr:2021 hgt:172cm
hcl:#cfa07d
ecl:blu

eyr:2024 hcl:#7d3b0c byr:1930 cid:194 pid:216814907 hgt:63in ecl:gry

byr:1946 ecl:gry pid:579575823
hgt:170cm
iyr:2015
eyr:2029
hcl:#7d3b0c cid:88

byr:1936
hcl:#6b5442 eyr:2020 cid:272 pid:752699834 iyr:2015 hgt:190cm
ecl:grn

cid:85 iyr:2018 eyr:2025 ecl:hzl hgt:192cm byr:1996 pid:478812793 hcl:#602927

hgt:160cm byr:1968 ecl:hzl
hcl:#9b96f3 iyr:2016 eyr:2027 pid:054732103

hcl:#efcc98
hgt:152cm pid:140347821
cid:346
eyr:2022 ecl:oth iyr:2010 byr:1931

hgt:187cm ecl:blu hcl:#fffffd
pid:061318772 byr:1969 iyr:2012

eyr:2021
hgt:190cm
ecl:amb byr:1963 pid:158cm
iyr:2015
hcl:#b6652a

cid:144 hcl:#c0946f iyr:2013 pid:384713923
ecl:brn eyr:2028 hgt:157cm
byr:1981

byr:1981
ecl:gry
eyr:2027 hgt:150cm
pid:769266043 hcl:#006f93 iyr:2015

hgt:154cm
eyr:2022 pid:516617153
ecl:amb byr:1993
iyr:2020
hcl:#341e13

hcl:#b6652a
byr:1943
pid:323629477 cid:311 ecl:grn eyr:2030 hgt:182cm

hcl:#7d3b0c hgt:70in byr:1996
pid:205918254 eyr:2022 cid:178 iyr:2010
ecl:brn

byr:2001
hgt:186cm iyr:2019 ecl:brn
eyr:2024
hcl:#888785
pid:218031016

ecl:oth
byr:1971 hcl:#a97842 pid:673909751 hgt:152cm eyr:2026
iyr:2017

iyr:2017 byr:1966 cid:334 pid:#8a11cd
hgt:188cm eyr:2023 hcl:#ceb3a1 ecl:brn

ecl:amb iyr:2019 pid:835997489 hcl:#b6652a eyr:2026
hgt:154cm
byr:1989

eyr:2033 cid:288 byr:1951
ecl:zzz iyr:1962 hcl:#cfa07d
hgt:72cm

cid:238 hgt:162cm eyr:2020 byr:1995
ecl:amb iyr:2010 pid:700982289

iyr:2010
pid:741394760 ecl:blu eyr:2030
byr:1934 hgt:68in hcl:#fffffd

pid:434939593 iyr:2020 hcl:#cfa07d cid:282 hgt:168cm
ecl:blu byr:1939

hgt:154cm byr:1981
ecl:brn eyr:2029
iyr:2019 hcl:#602927 pid:329288264
cid:307

iyr:2016
hcl:#866857
byr:1968 eyr:2029 hgt:152cm pid:347204193 ecl:brn

ecl:hzl
pid:975616547
hgt:166cm
iyr:2015 hcl:#efcc98 eyr:2020
byr:1927

byr:1960 cid:309 eyr:2022
hcl:#a97842 pid:186837033
iyr:2019 hgt:156cm

hgt:165cm ecl:hzl pid:776872855 byr:1923
cid:313 eyr:2029

eyr:2021 hcl:#18171d
byr:1938 hgt:160cm iyr:2020
pid:938987284 ecl:gry

iyr:2011
eyr:2026
ecl:amb hgt:166cm
pid:727980371 cid:154 byr:1967 hcl:#888785

byr:1928
ecl:grn hcl:#888785 pid:852102448 hgt:150cm eyr:2024
iyr:2018

byr:1997 cid:201 ecl:gry
eyr:2020
hgt:163cm hcl:#7d3b0c
iyr:2011 pid:052314445

ecl:hzl eyr:2024 pid:460808964 iyr:2015 byr:1965
hcl:#c0946f hgt:189cm

iyr:2010 cid:163 byr:1944 ecl:grn pid:731085710
hcl:#efcc98 hgt:159cm eyr:2027

byr:1937 hcl:#ceb3a1 eyr:2026 ecl:hzl iyr:2019
hgt:185cm

iyr:2016 ecl:gry byr:1964 hcl:526fbd eyr:2023 pid:981371510
hgt:71cm

eyr:2028 hcl:#18171d
pid:264437557
iyr:2014 byr:1987 hgt:168cm
ecl:gry

pid:574867413
hcl:#2b965f eyr:2025 hgt:154cm
byr:2001 ecl:hzl
iyr:2011

iyr:2020
cid:212
ecl:gry hgt:174cm
byr:1939
eyr:2029 hcl:#cfa07d

hcl:#b6652a cid:249 pid:447524365 ecl:brn hgt:177cm byr:1959
eyr:2040
iyr:2011

byr:1935
ecl:amb hcl:#fffffd pid:270076583 cid:128 hgt:60in iyr:2016
eyr:2027

hcl:#c0946f pid:149533201 cid:332
ecl:blu byr:1935 hgt:185cm
iyr:2016 eyr:2025

hcl:#f27d9b cid:275 hgt:59in
byr:1928 iyr:2017
pid:311342224
eyr:2022 ecl:grn

ecl:gry
byr:1985 cid:131
hgt:191cm hcl:#6b5442 pid:957166785 iyr:2018 eyr:2029

pid:741921163 hgt:192cm byr:1982
iyr:2012 ecl:blu hcl:#623a2f eyr:2020

byr:1995 hgt:164cm eyr:2027 ecl:gry pid:086846266 hcl:#ceb3a1
iyr:2017

ecl:brn
hcl:#c0946f hgt:158cm
eyr:2020
pid:548013549 cid:107
iyr:2014 byr:1966

eyr:2021 hgt:192cm
iyr:2015 hcl:#888785 byr:1942 cid:104 pid:582902279 ecl:grn

byr:1923 hcl:#fffffd
hgt:185cm pid:216803187
ecl:amb
eyr:2030
iyr:2020 cid:153

pid:129687562 hgt:156cm eyr:2020 cid:336 byr:1964 hcl:#733820
iyr:2011
ecl:gry

iyr:2012 hcl:#866857 pid:814749853 hgt:156cm cid:155 byr:1924 eyr:2024 ecl:oth

hgt:151cm pid:832407555
cid:188 byr:1949
iyr:2010 ecl:oth eyr:2022
hcl:#adeffb

cid:102 ecl:grn byr:1999
hcl:#a97842 iyr:2013 hgt:173cm
pid:199221595 eyr:2029

byr:1963
hcl:#fffffd pid:980136208 cid:230 ecl:amb iyr:2010 hgt:171cm eyr:2029

byr:1969 pid:524832668 hcl:#efcc98
ecl:oth iyr:2019 eyr:2029

hgt:184cm hcl:#13682c eyr:2022
iyr:2016
byr:1944 ecl:amb
pid:764280754

hgt:162cm
byr:1922 eyr:2023 ecl:hzl pid:870409472 iyr:2012

hcl:#888785 byr:2008
ecl:utc iyr:1921 pid:993871206 hgt:152cm eyr:2026

hcl:#18171d
byr:1924
hgt:191cm
pid:130883621 iyr:2010 eyr:2028

byr:2001 hgt:185cm ecl:blu eyr:2020 iyr:2013 hcl:#888785

pid:043166927 cid:287 hgt:179cm iyr:2016 eyr:2021 byr:1960 ecl:amb hcl:#888785

ecl:oth iyr:2020 hgt:183cm
hcl:#fffffd byr:2013 eyr:2026 pid:042844334

pid:36857936 byr:1995 ecl:hzl hcl:#c0946f eyr:2025 hgt:162cm iyr:2011

iyr:2013 ecl:blu cid:92 byr:1946 pid:150720364 hcl:#7d3b0c hgt:180cm eyr:2027

cid:276 eyr:2020 iyr:2011 hgt:59in hcl:#6b5442 ecl:amb byr:1992
pid:137604720

byr:1998 pid:239200796 hcl:#957b4b hgt:171cm iyr:2011

cid:176
pid:872650041 byr:1987 hcl:#623a2f
hgt:69in
ecl:oth
eyr:2024 iyr:2015

pid:388875093 eyr:2024
ecl:amb hgt:175cm
iyr:2019 byr:1970 hcl:#ceb3a1

pid:040506316 byr:1999
cid:186
hcl:#7d3b0c ecl:blu eyr:2022
hgt:160cm iyr:2019

cid:54
pid:314873473 iyr:2013 eyr:2020 hcl:#c0946f hgt:158cm ecl:amb

iyr:2016 ecl:oth hcl:#fffffd
hgt:189cm eyr:2020

byr:1981
hgt:163cm
ecl:brn
hcl:#7d3b0c iyr:2016
pid:500276094
cid:98
eyr:2029

ecl:oth hgt:158cm
eyr:2023 hcl:#c0946f iyr:1966 pid:544377825
byr:1938

cid:170 hcl:#733820
iyr:2020 byr:1970 hgt:150cm pid:469096877
eyr:2020

pid:144977701 hgt:180cm byr:1975 hcl:#cfa07d
ecl:oth cid:57 eyr:2022 iyr:2016

pid:591688826 hgt:156cm hcl:#a97842
ecl:amb iyr:2011 byr:1955
eyr:2020

hcl:#a97842 hgt:174cm
iyr:2012 eyr:2024 pid:928395919 ecl:blu byr:1927

ecl:amb hgt:156 hcl:#888785 iyr:2019 eyr:2021
byr:1997 pid:980577052

iyr:2014 eyr:2028
hgt:177cm ecl:oth byr:1930 pid:846909255 hcl:#602927

hcl:#efcc98 iyr:2015
byr:1941
pid:387565513
ecl:gry cid:54 eyr:2026 hgt:166cm

hcl:#fffffd iyr:2014
ecl:brn pid:241522887 byr:1963
hgt:178cm
eyr:2024

ecl:grn hgt:70in pid:202158837 eyr:2026 byr:1964
iyr:2018 hcl:#c0946f cid:77

hgt:176cm iyr:2016
pid:927969731 byr:1939
eyr:2025 ecl:grn
hcl:#fffffd

byr:1943 hgt:191cm ecl:hzl pid:422579553 iyr:2017 eyr:2020 hcl:#c2a152

eyr:2028 byr:1952
pid:506339509 hcl:#602927 hgt:179cm
ecl:grn

hcl:#341e13 iyr:2014 ecl:brn pid:823049712 eyr:2030 hgt:157cm
byr:1924

ecl:hzl
byr:1954 pid:146052548 cid:194 eyr:2030 hcl:#ceb3a1 hgt:183cm
iyr:2013

hcl:#6b5442
eyr:2026 iyr:2014 hgt:65in ecl:hzl pid:694135829 byr:1920

iyr:2012 byr:1984 hcl:#623a2f pid:270343526 ecl:gry cid:246 hgt:185cm

eyr:2026 ecl:grn
pid:853148268 iyr:2014 hgt:183cm hcl:#a97842 byr:1939

eyr:2021 hgt:182cm byr:1922 pid:199346431 cid:165 iyr:2016 ecl:hzl
hcl:#b6652a

ecl:#47904b pid:66740994
iyr:2025
byr:2029 eyr:2023 hcl:a6b541

ecl:hzl
byr:1947
hcl:#341e13 pid:466649892 eyr:2030 hgt:164cm iyr:2015

hcl:#a97842 iyr:2016 eyr:2029
byr:1921 hgt:191cm ecl:brn pid:776471818

iyr:2014 pid:605101404 ecl:amb hcl:#7d3b0c byr:1991 eyr:2026 hgt:158cm

byr:1995 cid:271 ecl:hzl iyr:2012 hcl:#18171d pid:723865532
hgt:165cm eyr:2029

ecl:hzl
hcl:#7d3b0c byr:2023
pid:83552498 eyr:2025 hgt:65cm iyr:2010

eyr:2022 byr:1975 hcl:#888785 hgt:165cm
cid:166 ecl:brn iyr:2013
pid:261135534

byr:1999 cid:222 iyr:2020 ecl:hzl hgt:182cm pid:411279683 hcl:#1ca912

byr:1954 cid:273 ecl:#915d48
pid:004261180 hcl:#cfa07d iyr:2018 hgt:167cm eyr:2021

hcl:#733820 byr:1931 iyr:2015
cid:130 eyr:2029 hgt:183cm pid:962443962 ecl:gry

hgt:192cm eyr:2029
pid:643859724
iyr:2016 ecl:blu byr:1951

hgt:155cm
pid:293590926
hcl:#602927 eyr:2027 byr:1959
iyr:2020
ecl:amb

ecl:oth hcl:#fffffd
pid:469517546 eyr:2026 iyr:2020 hgt:181cm
byr:1929

eyr:2026 iyr:2015 ecl:grn pid:644263519
cid:254 hgt:64cm
byr:1944 hcl:#341e13

hgt:150cm hcl:#341e13 ecl:oth
eyr:2028
byr:1922
pid:618759433 iyr:2017

ecl:hzl hgt:169cm
hcl:z eyr:2035 pid:620999812 byr:1998

pid:897252903 hgt:158cm iyr:2011 byr:1987 cid:221 eyr:2030
hcl:#efcc98 ecl:gry

ecl:gry eyr:2027
byr:1951
iyr:2012
pid:542287454 hcl:#6b5442

pid:#185456
byr:2028 cid:148 iyr:1957 hcl:df9a7d ecl:grt hgt:101
eyr:2036

hcl:#b6652a eyr:2023
hgt:150cm cid:316 ecl:gry byr:1922
pid:858150885 iyr:2013

hgt:181in
byr:1986 ecl:#b9ca4d
iyr:2014 cid:77 eyr:2026
pid:277491106

byr:1996 ecl:oth pid:539623368 hcl:#602927 eyr:2024 iyr:2019
hgt:179cm

pid:499804970 hcl:#18171d ecl:grn
hgt:189cm eyr:2029
iyr:2012 byr:1986

pid:093626459 eyr:2024 iyr:2018
ecl:grn byr:1922 hgt:153cm

hgt:179cm byr:1990 eyr:2026 hcl:#623a2f ecl:blu
pid:306676089
iyr:2011

eyr:2022 ecl:oth
pid:894642127
hcl:#5a9d3e iyr:2013 hgt:68in byr:1987

pid:059006259 byr:1953
hcl:#7d3b0c ecl:oth iyr:2011 hgt:157cm eyr:2023

ecl:oth
pid:255405447
eyr:2021 cid:130 hcl:#b6652a hgt:75in iyr:2020 byr:1959

cid:124
pid:353288807 hcl:#7d3b0c
byr:1963 eyr:2020 ecl:oth
iyr:2020
hgt:66in

hgt:150cm
hcl:#3a4c6e pid:027677435 ecl:hzl cid:256 byr:1960
iyr:2015
eyr:2026

ecl:brn hcl:#c0946f
eyr:2028 pid:801870217
iyr:2010

cid:170 hgt:175cm
eyr:2028
pid:620159472
iyr:2020 hcl:#7d3b0c ecl:brn
byr:1939

iyr:2019 hgt:161cm cid:152 ecl:brn hcl:#fffffd
byr:1938
eyr:2030 pid:311625365

hgt:174cm hcl:#efcc98
byr:1934 pid:389966928 ecl:amb eyr:2023
cid:235 iyr:2018

iyr:2010 byr:1960 pid:556639427 ecl:grn
hgt:152cm
eyr:2022
hcl:#623a2f

iyr:2014 hcl:#623a2f
hgt:169cm
pid:243755754 ecl:oth eyr:2025

iyr:2016 hcl:#623a2f cid:152
ecl:oth hgt:62in byr:1946
eyr:2028 pid:007367220

iyr:2013
ecl:oth hgt:163cm
byr:1987
hcl:#2cc1fd pid:346162920 eyr:2028

pid:636103282 byr:1952 eyr:2029 ecl:oth
hcl:#fffffd cid:290 iyr:2013 hgt:63in

eyr:2021 hcl:#866857 iyr:2013 byr:1951
hgt:157cm
pid:258369047 ecl:amb

byr:1983 iyr:2026 hgt:182cm eyr:2029
hcl:#623a2f ecl:hzl pid:373940630

pid:283714222
hgt:173cm ecl:gry byr:1939
iyr:2015 cid:81

hgt:164cm cid:215
ecl:amb eyr:2025 pid:459309210
hcl:#ceb3a1 byr:1954
iyr:2015

byr:1931
ecl:oth eyr:2028 hgt:177cm
hcl:#6b5442
pid:494763488 iyr:2015 cid:293

ecl:oth hcl:#fffffd hgt:188cm cid:252 pid:987529683 iyr:2020 byr:1945

eyr:2029
pid:745721513
iyr:2017 ecl:brn
hgt:184cm hcl:#a97842

eyr:2024 ecl:oth
hgt:153cm
iyr:2014 byr:1953 hcl:#888785
cid:330 pid:532786321

hgt:180cm
pid:441199844 eyr:2023 ecl:grn hcl:#b6652a byr:1958 iyr:2012

ecl:brn
pid:835022632 hgt:174cm
byr:1928 hcl:#341e13 eyr:2028
cid:176 iyr:2011

hgt:72in byr:1964 hcl:#ceb3a1 ecl:gry
iyr:2020 eyr:2028
cid:180

iyr:2025 byr:1999
eyr:2024 hcl:#c0946f
hgt:86

eyr:2023 byr:1974 pid:067761346 cid:178 ecl:hzl iyr:2020 hgt:168cm hcl:#6b5442

hgt:157cm ecl:gry eyr:2025
pid:803912278 byr:1963 iyr:2011 hcl:#ceb3a1

hgt:190cm eyr:2026 ecl:grn
iyr:2012
hcl:#c0946f byr:1929

eyr:2023 ecl:hzl pid:#fb639f
iyr:2030
cid:132
byr:2016 hcl:#ce01c8

eyr:2021
pid:228596339
byr:1974
ecl:blu
hgt:174in iyr:2020
hcl:#733820

ecl:amb hgt:165cm
byr:1953 hcl:#118493 pid:458049702 cid:99
iyr:2019 eyr:2023

ecl:hzl pid:277988952
eyr:2025 hgt:179cm byr:1992 cid:322

hcl:#a97842 eyr:2021 cid:261
hgt:61in pid:162402242
ecl:amb byr:1938 iyr:2016

hcl:#d125e3 iyr:2016 byr:1982 eyr:2027
hgt:154cm
pid:365548961

iyr:2016 hgt:187cm byr:1980 pid:977322718
eyr:2027 ecl:brn hcl:#ceb3a1

iyr:2010 ecl:oth
pid:455361219 hgt:153cm eyr:2027 hcl:#6b5442
byr:1965

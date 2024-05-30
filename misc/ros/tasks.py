#!/usr/bin/python3
import xml.dom.minidom
import sys, urllib.parse, urllib.request
 
def findrc(cat):
    name = "http://www.rosettacode.org/w/api.php?action=query&list=categorymembers&cmtitle=Category:%s&cmlimit=100&format=xml" % urllib.parse.quote(cat)
    cmcontinue = ''
    while True:
        u = urllib.request.urlopen(name + cmcontinue)
        xmldata = u.read()
        u.close()
        x = xml.dom.minidom.parseString(xmldata)
        for i in x.getElementsByTagName("cm"): print(i.getAttribute("title"))
        sys.stdout.flush()
        cmcontinue = [i.getAttribute("cmcontinue") for i in x.getElementsByTagName("continue")]
        if not cmcontinue: break
        cmcontinue = '&cmcontinue=' + cmcontinue[0]

findrc("EasyLang")
 

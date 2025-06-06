#!/opt/homebrew/bin/python3.13
#!/usr/bin/python3
import xml.dom.minidom
import sys, urllib.parse
from urllib.request import Request, urlopen

def findrc(cat):
	url = "https://rosettacode.org/w/api.php?action=query&list=categorymembers&cmtitle=Category:%s&cmlimit=100&format=xml" % cat
	cmcontinue = ''
	while True:
		request = Request(url + cmcontinue, headers = {'User-Agent' :\
		"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"})
		u = urlopen(request)
		xmldata = u.read()
		u.close()
		x = xml.dom.minidom.parseString(xmldata)
		for i in x.getElementsByTagName("cm"): print(i.getAttribute("title"))
		sys.stdout.flush()
		cmcontinue = [i.getAttribute("cmcontinue") for i in x.getElementsByTagName("continue")]
		if not cmcontinue: break
		cmcontinue = '&cmcontinue=' + cmcontinue[0]

findrc("EasyLang")
 

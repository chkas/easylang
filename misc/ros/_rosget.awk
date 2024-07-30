#!/usr/bin/awk -f

function unesc(s) {

	while (1) {
		h = index(s, "&amp;")
		if (!h) break
		s = substr(s, 1, h - 1) "&" substr(s, h + 5);
	}
	gsub("&lt;", "<", s)
	gsub("&gt;", ">", s)
	gsub("&#160;", " ", s)
	gsub("&quot;", "\"", s)
	return s
}

{
	if (ine == 0 && match($0, "id=\"EasyLang\"")) ine = 1;
	else if (ine == 3 && match($0, "</pre></div>")) {
		h = length($0)
		if (h > 12) print(unesc(substr($0, 1, h - 12)))
		ine = 0
	}
	else if (ine == 1 && match($0, "mw-highlight")) ine = 2
	if (ine == 2) {

		h = index($0, "<pre><span></span>")
		if (h) h += 18
		else {
			h = index($0, "<pre>")
			h += 5
		}
		print(unesc(substr($0, h)))
		ine = 3
	}
	else if (ine == 3) {
		print(unesc($0))
	}
}

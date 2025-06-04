#!/bin/sh

vers=$1
cat <<EOF
<!doctype html>
<meta charset=utf-8><title>Easylang - Rosetta Code</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<link rel="icon" href="../icon.png" type="image/x-png">

<div id=tut><b>Loading ...</b></div>
<script>
txt_split = "\n*\n"
EOF

printf "txt_tutor = String.raw\`* Rosetta Code with Easylang\n"

for f in *.el; do
	test $f = w.el && continue
	x=$(basename "$f" .el)
	test $x = "A+B" || x=$(echo "$x" | tr + /)
	n=$(echo "$x"|tr _ " ")
	echo "*"
	echo "* $n"
	echo "*"
	echo "@ "https://rosettacode.org/wiki/$x"@Task"
	echo "*"
	cat $f
done

cat <<'EOF'
`
function hook() {
	var dom = window.location.host
	tut.insertAdjacentHTML("beforeend", `
<p><hr><p>
The examples were created with <a href=..>${dom}<a>
<p><small>christof.kaser@gmail.com</small>
`)
}
</script>
<script src=easy_code2.js?$vers></script>
<script src=easy_tut2.js?$vers></script>
EOF


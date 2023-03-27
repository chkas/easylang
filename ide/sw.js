const CACHE = 'd230226-1604x16'
const VERS = '310'

var urls = [
	"/ide/",
	"/ide/easyw" + VERS + ".wasm",
	"/ide/easyw" + VERS + ".js",
	"/ide/tut_id" + VERS + ".js",
	"/ide/tut_learn" + VERS + ".js",
	"/ide/tut_docu" + VERS + ".js",
	"/ide/tut_func" + VERS + ".js",
	"/ide/tut_game" + VERS + ".js",
	"/ide/icon.png",
	"/ide/mfst.json"
]

console.log("sw " + CACHE)

self.addEventListener("install", evt => {
	console.log("install " + CACHE)
	evt.waitUntil(
		caches.open(CACHE).then(cache => Promise.all(
			urls.map(url => {
				var f = url
				if (f == "/ide/") f += "?" + CACHE
				return fetch(f).then(resp => {
					if (!resp.ok) {
						console.log(f + " missing")
						return
					}
					if (resp.headers.get("Cross-Origin-Embedder-Policy") != "require-corp" || 
						resp.headers.get("Cross-Origin-Opener-Policy") != "same-origin") {

						var head2 = new Headers(resp.headers);
						head2.set("Cross-Origin-Embedder-Policy", "require-corp")
						head2.set("Cross-Origin-Opener-Policy", "same-origin")
						resp = new Response(resp.body, {
							status: resp.status,
							statusText: resp.statusText,
							headers: head2,
						});
					}
					return cache.put(f, resp)

				})
			})
		))
	)
})

self.addEventListener("fetch", evt => {
	evt.respondWith(async function() {
		var cache = await caches.open(CACHE)
		var res = await cache.match(evt.request, {ignoreSearch: true})
		if (res) return res
		console.log("fetch " + evt.request.url)
		return fetch(evt.request)
	}())
})
self.addEventListener("activate", function(evt) {
	evt.waitUntil(
		caches.keys().then(function(keys) {
			return Promise.all(
				keys.map(function(k) {
					if (k != CACHE && k[0] == CACHE[0]) return caches.delete(k)
				})
			)
		})
	)
})
self.addEventListener("message", function (evt) {
	console.log("message " + evt.data.action)
	if (evt.data.action == "skipWaiting") self.skipWaiting()
})


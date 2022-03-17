if ("serviceWorker" in navigator) {
	notiUpd.inRefresh = false
	window.addEventListener("load", function() {
		navigator.serviceWorker.register("sw.js").then(function(reg) {
			console.log("sw scope: ", reg.scope)
			reg.addEventListener("updatefound", () => {
				notiUpd.nsw = reg.installing
				notiUpd.nsw.addEventListener("statechange", () => {
					switch (notiUpd.nsw.state) {
					case "installed":
						if (navigator.serviceWorker.controller) {
							doc.style.height = "calc(100% - 4em)"
							notiUpd.style.display = "inline"
						}
						break
					}
				})
			})
		})
	})
	navigator.serviceWorker.addEventListener("controllerchange", function () {
		if (notiUpd.inRefresh) return
		window.location.reload()
		notiUpd.inRefresh = true
	})
	notiUpd.onclick = function(){
		notiUpd.nsw.postMessage({ action: "skipWaiting" })
	}
}


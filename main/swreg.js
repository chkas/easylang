if ("serviceWorker" in navigator) {
	notiUpd.inRefresh = false
	navigator.serviceWorker.register("sw.js").then(function(reg) {
		console.log("sw scope: ", reg.scope)
		reg.addEventListener("updatefound", () => {
			notiUpd.nsw = reg.installing
			notiUpd.nsw.addEventListener("statechange", () => {
				switch (notiUpd.nsw.state) {
				case "installed":
					if (navigator.serviceWorker.controller) {
						col1.style.height = "calc(100% - 4em)"
						notiUpd.style.display = "inline"
					}
					break
				}
			})
		})
		window.setInterval(() => {
			reg.update()
		}, 4 * 3600 * 1000);
	})
	navigator.serviceWorker.ready.then(function(reg) {
		console.log("sw ready")
		if (!crossOriginIsolated && !navigator.serviceWorker.controller) {
			console.log("reload")
			window.location.reload()
		}
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


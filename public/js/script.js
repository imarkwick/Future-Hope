window.onload = function(){
	(function(){
		var show = function(el){
			return function(img){ el.innerHTML = img + el.innerHTML}
		}(document.getElementById('imgs'));

		var ws = new WebSocket('ws://' + window.location.host + window.location.pathname);
		ws.onopen = function() { show('websocket opened'); };
		ws.onclose = function() { show('websocket closed'); };
		ws.onmessage = function(m) { show('websocket message' + m.data); };

		var sender = function(f){
			var submit = document.getElementById('submit');
			input.onclick = function(){ submit.value="" };
			f.onsubmit = function(){
				ws.send(input.value);
				input.value = "send a message";
				return false;
			}

		}(document.getElementById("auction-list"))
	})();
}
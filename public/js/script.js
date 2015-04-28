// $(document).ready(function() {
// 	var append_li = function(string) {
// 		$('#messages').append($('<li>').text(string));
// 	}

// 	var ws_uri = location.href.replace(/^http/, 'ws');
// 	var ws = new WebSocket(ws_uri);

// 	ws.open = function() {
// 		append_li('ws.open');
// 	}

// 	ws.onmessage = function(msg) {
// 		append_li('ws.onmessage: "' + msg.data + '" from server');
// 	}

// 	ws.onclose = function() {
// 		append_li('ws.onclose');
// 	}

// 	var input = $('#input')
// 	input.change(function() {
// 		var msg = input.val();
// 		ws.send(msg);
// 		append_li('"' + msg + '" to server');
// 		input.val("");
// 	});

// 	console.log(input);
// });
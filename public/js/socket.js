window.onload = function() {

	var form = document.getElementById('auction-list');
	var itemDropdown = document.getElementById('item');
	var nameDropdown = document.getElementById('guest-list');
	var messageList = document.getElementById('messages');
	var socketStatus = document.getElementById('status');
	var closeBtn = document.getElementById('close');

	// Create WebSocket connection
	var socket = new WebSocket('ws://echo.websocket.org');

	// Show a connection msg when WebSocket is opened
	socket.onopen = function() {
		socketStatus.innerHTML = 'Connected to: ' + event.currentTarget.URL;
	};

	// Logs any errors in the console (not handled fully)
	socket.onerror = function(error) {
		console.log('WebSocket Error:' + error);
	};

	// Send a message when the form is submitted
	form.onsubmit = function(e) {
		e.preventDefault();

		// retrieve msg from the item dropdown
		var item = itemDropdown.value;

		// retrieve msg from the list of names
		var names = nameDropdown.value;
		console.log(names.length);

		// create the message
		var message = item + ':      ' + names;

		// send a msg through the WebSocket
		socket.send(message);

		// add msg to the list
		messageList.innerHTML += '<li><span>Sent: </span>' + message + '</li>';
	
		// clear the msg field ?

		return false;
	};

	// Show connect msg when Websocket is open
	socket.onopen = function(event) {
		socketStatus.innerHTML = 'Connected to WebSocket';
	};

	// Handle messages sent by the server & fire message event when received
	socket.onmessage = function(event) {
		var message = event.data;
		messageList.innerHTML += '<li class="received"><span>Received: </span>' + message + '</li>';
	};

	// Show a disconnected msg when WebSocket is closed
	socket.onclose = function(event) {
		socketStatus.innerHTML = 'Disconnected from WebSocket'
	};

	// Close WebSocket connection when close button is clicked
	closeBtn.onclick = function(e) {
		e.preventDefault();
		socket.close();
		return false;
	};
};









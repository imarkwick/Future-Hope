$(document).ready(function() {

  var append_li = function(string) {
    $('#messages').append($('<li>').text(string));
  }

  var ws_uri = location.href.replace(/^http/, 'ws');
  var ws = new WebSocket(ws_uri);
  // var ws = Faye::WebSocket::Client.new(ws_uri, ping: 60)
  ws.open = function() {
    console.log('hi from the client');
  }

  ws.onmessage = function(msg) {
    alert('client msg: ' + msg.data);
  }

  ws.onclose = function() {
    console.log('bye from the client');
  }

  var input = $('#submit')
  input.click(function() {
    var dropdown = $('#item');
    var msg = dropdown.val();
    ws.send(msg);
    append_li(msg);
    input.val("");
    alert('on click: ' + msg);
  });
  
});
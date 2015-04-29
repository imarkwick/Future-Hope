$(document).ready(function() {

  // MULTI SELECT FORM

  var selected = {};
  $('#guest-list').click(function(e) {
    var $this = $(this),
    options = this.options,
    option,
    value,
    n;  
    value = $this.val();    
    for (n = 0; n < options.length; ++n) {
      option = options[n];
      if (option.value == value) {
        selected[value] = !selected[value];
      }
      option.selected = !!selected[option.value];
    }
    return false;
  });

  // FAYE CLIENT WEBSOCKET

  var append_li = function(string) {
    $('#messages').append($('<li>').text(string));
  }

  var ws_uri = location.href.replace(/^http/, 'ws');
  var ws = new WebSocket(ws_uri);
  ws.open = function() {
    console.log('hi from the client');
  }
  ws.onmessage = function(msg) {
    alert('client msg: ' + msg.data);
  }

  ws.ping = function (){
    console.log("PING")
  }
  ws.onclose = function() {
    ws.send('Ping');
    ws.open();
  }




  var input = $('#submit')
  input.click(function() {
    var dropdown = $('#item');
    var msg = dropdown.val();
    ws.send(msg);
    append_li(msg);
  });

  // VOLUNTEER FORM SUBMISSION

  $(function() {

    $('form#auction-list').on("submit", function(ev) {
      ev.preventDefault();
      $.ajax({

        type: "post",
        url: '/display',
        data: $("form#auction-list").serialize(),
        success: function() {
          console.log("string");
            }
      });  
    });
  });
});

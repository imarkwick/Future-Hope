$(document).ready(function() {

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

  ws.onclose = function() {
    console.log('bye from the client');
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
        // dataType: {"hello from ajax form"},
        data: $("form#auction-list").serialize(),
        success: function() {
          console.log("string");
            }
      });  
    });
  });
});


// STOP PAGE REFRESH ON VOLUNTEER P

// form prevent default 

// submission using ajax

// serialise method for the form
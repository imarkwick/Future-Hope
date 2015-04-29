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

  // VOLUNTEER FORM SUBMISSION

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

$(function() {
  var params = window.location.search;
  if (params.length === 0) {
    $('a.default-filter').addClass("active");
  } else {
    var target = params.split("=")[1];
    $('a.' + target).addClass("active");
  }
  // $('.library-help').hide();
  $('.show-hlep').on('click', function(e) {
    e.preventDefault();
    $('.library-help').fadeIn();
  });
  $('.close-lib-help').on('click', function(e) {
    e.preventDefault();
    $('.library-help').fadeOut();
  });

});
$(function(){
  var target = $('a.dropdown-toggle');
  target.hover(function(){
    $(this).trigger('click');
  }, function(){

  });
});
$(function(){
  var target = $('.complete-notification');
  count =  +target.text();
  if (count > 0) {
    target.addClass("have-notifications");
    target.removeClass("complete-notification");
  }
});
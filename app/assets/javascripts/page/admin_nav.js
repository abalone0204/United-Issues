$(function(){
  var target = $('.complete-notification');
  count =  +target.text();
  console.log(count);
  if (count > 0) {
    target.addClass("have-notifications");
    target.removeClass("complete-notification");
  }
});
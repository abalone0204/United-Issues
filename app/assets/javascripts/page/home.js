//= require jquery-ui
//= require jquery.lazyload


$(function() {

  // hover shadow
  var topicItem = $('.topic-item'),
      postItem = $('.post-item'),
      orbit = $('.intro-content');

  function hoverClass(item, target, className) {
    item.hover(function() {
      $(this).find(target).addClass(className);
    }, function() {
      $(this).find(target).removeClass(className);
    });
  }
  hoverClass(topicItem, ".image", "shadow");
  hoverClass(postItem, "img", "shadow");
  hoverClass(orbit, "h2", "orbit");
  
  // lazy load
  $("img.lazy").lazyload({
    effect: "fadeIn"
  });

});
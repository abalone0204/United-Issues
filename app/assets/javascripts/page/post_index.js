//= require jquery.lazyload
$(function(){
  var postItem = $('.post-list-item');
  postItem.hover(
    function(){
      $(this).find(".image").addClass("shadow");
    },
    function(){
      $(this).find(".image").removeClass("shadow");
    });

  // lazy load
  $("img.lazy").lazyload({
    effect: "fadeIn"
  });
});
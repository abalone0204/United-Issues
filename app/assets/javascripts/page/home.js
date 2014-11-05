//= require jquery-ui

$(function() {
  var topicItem = $('.topic-item'),
      postItem = $('.post-item');

  function shadowlize(item, selectedTag) {
    item.hover(function() {
      $(this).find(selectedTag).addClass("shadow");
    }, function() {
      $(this).find(selectedTag).removeClass("shadow");
    });
  }
  shadowlize(topicItem, ".image");
  shadowlize(postItem, "img");
});
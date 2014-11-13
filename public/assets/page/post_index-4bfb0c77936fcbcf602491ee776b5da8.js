$(function(){
  console.log("okok");
  var postItem = $('.post-list-item');
  postItem.hover(
    function(){
      $(this).find(".image").addClass("shadow");
    },
    function(){
      $(this).find(".image").removeClass("shadow");
    });
});

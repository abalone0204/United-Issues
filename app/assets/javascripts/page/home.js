//= require jquery-ui

$(function() {
  $("dd").hide();
  $("dd").first().show();
  $("dt").click(function() {
    dd_element = $(this).next();
    dd_element.slideDown();
    dd_element.siblings("dd").not($(this)).slideUp();

  });
  // $("#page-wrap").delegate("a.image", "click", function(e) {
  //   if (!$(this).parent().hasClass("curCol")) {
  //     e.preventDefault();
  //     $(this).next().find('dt:first').click();
  //   }

  // });
});
$(function() {
  var params = window.location.search;
  console.log(params);
  if (params.length === 0) {
    $('a.default-filter').addClass("active");
  } else{
    var target = params.split("=")[1];
    $('a.'+target).addClass("active");
  }
});
//= require jquery-ui
//= require jquery-ui-timepicker-addon
//= require jquery-ui-sliderAccess

$(function() {
  var date_option = {
    dateFormat: 'yy-mm-dd',
    timeFormat: '',
    showSecond: false,
    showHour: false,
    showMinute: false,
    showTime: false
  };

  var date_input = $('.datepicker');

  date_input.datetimepicker(date_option);


});
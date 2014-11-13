//= require jquery-ui
//= require jquery-ui-timepicker-addon
//= require jquery-ui-sliderAccess

$(function() {
  var datetime_input = $('#datetimepicker'),
    datetime_option = {
      dateFormat: 'yy-mm-dd',
      showSecond: false,
      timeFormat: 'HH:mm'
    };

  datetime_input.datetimepicker(datetime_option);
});
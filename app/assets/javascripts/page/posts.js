//= require jquery-ui
//= require jquery-ui-timepicker-addon
//= require jquery-ui-sliderAccess

$(function() {
  var datetime_option = {
      dateFormat: 'yy-mm-dd',
      showSecond: false,
      timeFormat: 'HH:mm'
    },
    date_option = {
      dateFormat: 'yy-mm-dd',
      timeFormat: '',
      showSecond: false,
      showHour: false,
      showMinute: false,
      showTime: false
    };

  var datetime_input = $('#datetimepicker'),
      date_input =$('.datepicker');
  if (datetime_input.length) {
    datetime_input.datetimepicker(datetime_option);
  }
  if (date_input.length) {
    date_input.datetimepicker(date_option);
  };

});
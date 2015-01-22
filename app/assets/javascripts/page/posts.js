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

      var isChrome = (window.chrome != undefined);
      if (!isChrome) {
        $("<div class='alert alert-dismissable alert-success'> <button type = 'button' class='close' data-dismiss = 'alert' > <span aria-hidden= 'true'> &times; </span><span class='sr-only'>Close</span> </button> 建議使用Chrome瀏覽器來獲得最佳體驗 </div>").insertBefore(".post");

        }


      });
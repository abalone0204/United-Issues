$(function() {
  var checkboxes = document.getElementsByTagName('input');

  for (var i = 0; i < checkboxes.length; i++) {
    if (checkboxes[i].type == 'checkbox') {
      checkboxes[i].checked = false;
    }
  }
  var $admin = $('#admin');
  $admin.hide();
  var $editor = $('#editor');
  var $userFilter = $("#users_filter").find('span');

  $userFilter.on('click', function () {
    var $this = $(this);
    var filter = $this.data('filter');
    $this.addClass('active');
    $this.siblings().removeClass('active');
    if (filter === 'admin') {
        $editor.fadeOut(250);
        setTimeout(function () {
            console.log('out');
            $admin.fadeIn(250);    
        }, 250);
    } else {
        $admin.fadeOut(250);
        setTimeout(function () {
            console.log('editorout');
            $editor.fadeIn(250);    
        },250);
    }
    console.log(filter); 
  });
});
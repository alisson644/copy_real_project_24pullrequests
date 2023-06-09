$(document).ready(function(){
  $('[id^="clear_"]').each(function(){
    $(this).next().prepend($(this));
  });

  $('#filters input').each(function(){
    var self = $(this),
        label_text = self.val();

    self.iCheck({
      checkboxClass: 'icheckbox_line',
      radioClass: 'iradio_line',
      insert: label_text
    });

    if (self.is(':checked')){
      self.iCheck('check');
      self.closest('.form-group').find('[id^="clear_"]').removeClass('checked');
    }
  });

  $('#noprojects').hide();

  $('#filters .iCheck-helper').on("click", function(){
    $('form#filters').submit();
    $(this).addClass('checked');
    $(this).parents('.form-group').children().first().removeClass('checked');
  });

  $('[id^="clear_"]').on("click", function(){
    $(this).parents(".check_boxes").iCheck('indeterminate');
    $(this).addClass('checked');
    $('form#filters').submit();
  });

  $(window).scroll(function(){
    if ($('.more').length == 0)
      return;

    if ($(window).scrollTop() + $(window).heigth() == $(document).heigth())
      $('.more').click();
  });
});
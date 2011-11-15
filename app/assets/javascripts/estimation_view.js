$(document).ready(function() {
    $('#new_story').submit(function() {
      if ($('#story_title').val() == '') {
        $('#title_div').addClass('error');
        $('#title_div span').html('required');
        return false;
      }
      return true;
    });      
});


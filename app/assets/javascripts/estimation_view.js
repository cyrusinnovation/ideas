var current_bucket = 3;

$(document).ready(function() {
    $("#estimation_view").scrollable();

    var api = $("#estimation_view").data('scrollable');

    api.seekTo(2, 0);

     $('button:contains("Bigger")').click(function() {
         api.next();
         return false;
     });

     $('button:contains("Smaller")').click(function() {
         api.prev();
         return false;
     });
    $('a.scrollto').click(function() {
        api.seekTo( $(this).attr('estimate_index'), 1000);
    });
    disableEndPointButtons();
    
    $('.right-button').click(function() {
      $('#story_estimate').val($(this).data('bucket'));
      $('#new_story').submit();
    })
    
    $('#new_story').submit(function() {
      if ($('#story_title').val() == '') {
        $('#title_div').addClass('error');
        $('#title_div span').html('required');
        return false;
      }
      
      var selected_bucket = $('#estimation_view .items .estimation-bucket:nth-child(' + (api.getIndex() + 1) + ')').data('bucket');
      $('#story_estimate').val(selected_bucket);
      return true;
    });      

    $(".help_text_pop_right").popover({offset:5});
    $(".help_text_pop_left").popover({placement:'left', offset:5});
    $(".help_text_pop_top").popover({placement:'above'});
    
    $('a[data-bucket_link]').click(function() {
      var bucket = $(this).attr('data-bucket_link');
      var position = $(".estimation-bucket[data-bucket = '" + bucket + "']").index();
      api.seekTo(position, 1000);
      return false;
    });
    
    
});

function disableEndPointButtons() {
    
    $('.items .estimation-bucket:first [value="Smaller"]').addClass('disabled');
    $('.items .estimation-bucket:last [value="Bigger"]').addClass('disabled');
}

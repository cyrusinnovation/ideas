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
    $(".help_text_pop_right").popover();
    $(".help_text_pop_left").popover({placement:'left'});
    $(".help_text_pop_top").popover({placement:'above'});
});

function disableEndPointButtons() {
    
    $('.items .estimation-bucket:first [value="Smaller"]').addClass('disabled');
    $('.items .estimation-bucket:last [value="Bigger"]').addClass('disabled');
}

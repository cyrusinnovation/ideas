var current_bucket = 3;

$(document).ready(function() {
    $("#estimation_view").scrollable();

    var api = $("#estimation_view").data('scrollable');

     $('.info[value="Bigger"]').click(function() {
         api.next();
         return false;
     });

     $('.info[value="Smaller"]').click(function() {
         api.prev();
         return false;
     });
    disableEndPointButtons();
});

function disableEndPointButtons() {
    $('.estimation-bucket.0\\.25 [value="Smaller"]').addClass('disabled');
    $('.estimation-bucket.13 [value="Bigger"]').addClass('disabled');
}

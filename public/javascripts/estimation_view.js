var current_bucket = 3;

$(document).ready(function() {
    $('.estimation-bucket').hide();
    $('hr').hide();
    $('.estimation-bucket.3').show();
    $('.info').click(function() {
        $('.estimation-bucket.' + current_bucket).hide();
        if (this.value === "Bigger")
            up_bucket();
        else 
            down_bucket();
        $('.estimation-bucket.' + current_bucket).show();

        return false;
    })
});

function up_bucket() {
    if (current_bucket == '3')
        current_bucket = '8'
    else if (current_bucket == '8')
        current_bucket = '13'
    else if (current_bucket == '1')
        current_bucket = '2'
    else if (current_bucket == '0\\.25')
        current_bucket = '0\\.5'

}
function down_bucket() {
    if (current_bucket == '3')
        current_bucket = '1'
    else if (current_bucket == '1')
        current_bucket = '0\\.25'
    else if (current_bucket == '8')
        current_bucket = '5'

}
var current_bucket = 3;

$(document).ready(function() {
    $('.estimation-bucket').hide();
    $('.estimation-bucket').css('width', '960px');
    $('.estimation-bucket.3').show();
    $('.estimation-bucket.3').css('z-index', 5);
    $('.estimation-bucket.3').css('position', 'absolute');

    $('.estimation-bucket').css('top', '120px');

    disableEndPointButtons();


    $('.info').click(function() {
        getBucket(current_bucket).css('z-index', 0);
        if (this.value === "Bigger")
            up_bucket();
        else 
            down_bucket();
        $('.estimation-bucket.' + current_bucket).show();

        return false;
    });

});

function disableEndPointButtons() {
    $('.estimation-bucket.0\\.25 [value="Smaller"]').addClass('disabled');
    $('.estimation-bucket.13 [value="Bigger"]').addClass('disabled');
}

function up_bucket() {
    var old_bucket = getBucket(current_bucket);
    getBucket(current_bucket).animate({left: '-=940'}, 600, function() {old_bucket.hide();});

    if (current_bucket == '3')
        current_bucket = '8'
    else if (current_bucket == '8')
        current_bucket = '13'
    else if (current_bucket == '1')
        current_bucket = '2'
    else if (current_bucket == '0\\.25')
        current_bucket = '0\\.5'

    repositionRightDiv();
    getBucket(current_bucket).animate({left: '-=955'}, 600);
}
function down_bucket() {
    var old_bucket = getBucket(current_bucket);
    getBucket(current_bucket).animate({left: '+=940'}, 600, function() {old_bucket.hide();});

    if (current_bucket == '3')
        current_bucket = '1'
    else if (current_bucket == '8')
        current_bucket = '5'
    else if (current_bucket == '1') {
        current_bucket = '0\\.25'
        
    }
    repositionLeftDiv();
    getBucket(current_bucket).animate({left: '+=840'}, 600);
}

function repositionLeftDiv(bucket) {
    getBucket(current_bucket).css('position', 'absolute');
    getBucket(current_bucket).css('left', '-600px');
}

function repositionRightDiv(bucket) {
    getBucket(current_bucket).css('position', 'absolute');
    getBucket(current_bucket).css('left', '1200px');
}

function getBucket(bucket) {
    return $('.estimation-bucket.' + bucket);
}
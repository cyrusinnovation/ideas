
$(document).ready(function() {

    // What to do when the editing popup returns successfully
    $('body').bind('idea_saved', function(e, idea_data) {
        location.reload();
    });

    // Favoriting ideas
    $('.favorite img').on('click', function() {
        if (this.src.indexOf('unchecked') > -1) {
            $.post('/new_favorite', {idea: this.getAttribute('data-idea-id')});
            this.src = '/assets/star-checked.png';
        }
        else {
            $.post('/delete_favorite', {idea: this.getAttribute('data-idea-id') } );
            this.src = '/assets/star-unchecked.png';
        }
    });

    // Star ratings
    $('.rating img').on('click', function() {
        $.post('/rating', {rating: this.getAttribute('data-star-num'), idea: this.getAttribute('data-idea-id') } );

        $(this).parent().find('[data-star-num]:lt(' + this.getAttribute('data-star-num') + ')').attr('src', '/assets/star-rating-filled.png');
        $(this).parent().find('[data-star-num]:gt(' + (this.getAttribute('data-star-num') - 1) + ')').attr('src', '/assets/star-rating-unfilled.png');
    });

    // Search bar
    $('input#search').quicksearch('table tbody tr');
});
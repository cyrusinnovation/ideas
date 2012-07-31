$(document).ready(function() {

    // Make ideas draggable between projects and update database when done
    $( ".project-table tr.idea" ).draggable({
        helper: "clone"
        ,
        over: function(event, ui) {
            c = ui.helper;
            c.css('background-color', '#ff0000');
        },
        out: function(event, ui) {
            c = ui.helper;
            c.css('background-color', 'transparent');
        },
        stop: function(event, ui){
            var project_id = $(this).parent().parent().data('pid');
            var idea_id = $($(this)).data('iid');
            $.ajax({
                url: "/project/update/idea",
                type: "POST",
                data: {
                    project: {
                        id: project_id,
                        idea: { id: idea_id}
                    }
                }
            });
        }
    });

    // Make projects able to receive dropped ideas
    $(".project-table").droppable({
        accept: 'tr',
        drop: function(event, ui) {
            $(this).append(ui.draggable);
        }
    });

    // Double click headers to edit them
    $(".click-to-edit").dblclick(function () {
        var proj_name_obj = $(this);
        var text = proj_name_obj.text();
        proj_name_obj.text('');
        var proj_name_form = proj_name_obj.parent().find('form');
        proj_name_form.addClass('show');
        proj_name_form.removeClass('hidden');
        proj_name_form.submit(function(){
            var newText = $(this).find('input#project_name').val();
            proj_name_obj.text(newText);
            proj_name_form.addClass('hidden');
            proj_name_form.removeClass('show');
        });
    });

    // Cause a submit of open name edit forms when click elsewhere on page
    var insideForm = 1;
    $(".project-form").mouseenter(function() {
        insideForm = 0;
    }).mouseleave(function() {
        insideForm = 1;
    });
    $("body:not(.click-to-edit)").click(function(){
        if (insideForm == 1) {
            $('.project-form:visible').submit();
        }
    });


    // Hide project details when collapse the project
    $('.hide-button').click(function(){
        var project_id = $(this).data('proj_id');
        var table = $('#project-div-'+project_id).find('table');
        var icon = $(this).find('b');
        if (table.hasClass('hidden-table')){
            table.parent().slideDown('slow');
            table.removeClass('hidden-table');
            icon.removeClass('icon-chevron-down');
            icon.addClass('icon-chevron-up');
        }else{
            table.parent().slideUp('slow');
            table.addClass('hidden-table');
            icon.addClass('icon-chevron-down');
            icon.removeClass('icon-chevron-up');
        }

    });
});


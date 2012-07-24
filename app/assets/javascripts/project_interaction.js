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
//
//    $(".project-table").sortable({
//        connectWith: ".project-table",
//        items: 'tr.idea',
//        update: function(event, ui){
//            alert("ui");
//        }
//    })

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

});


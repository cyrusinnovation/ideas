// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require jquery_quicksearch/jquery.quicksearch.js
//= require jquery_tablesorter/jquery.tablesorter.min.js


$(document).ready(function() {

    $( ".project-table tr.idea" ).draggable({
        helper: "original",
        stop: function(event, ui){
            var project_id = ui.helper.parent().parent().data('pid');
            var idea_id = $(ui.helper).data('iid');
            $.ajax({
                url: "/project/update/idea",
                type: "POST",
                data: {
                    project: {
                        id: project_id,
                        idea: { id: idea_id}
                    }
                }
            })

        }
    });

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

    $(".click-to-edit").dblclick(function () {
        var proj_name_obj = $(this);
        var text = $(proj_name_obj).text();
        $(proj_name_obj).text('');
        $('form').addClass('show');
        $('form').removeClass('hidden');
        $('form').submit(function(){
                    var newText = $(this).find('input#project_name').val();
                    proj_name_obj.text(newText);
                    $('form').addClass('hidden');
                    $('form').removeClass('show');
                });
    });


});


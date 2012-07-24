// How to use this script:
//   render the ideas/form partial in your view
//   bind an event handler to get idea_saved events on body
//   Make links call the openIdea method
function openIdea(url) {
  $.ajax({
    type: 'GET',
    url: url,
    dataType: 'json',
    success: function(data) {
      form = $('#idea_form');
      form.find('h3.title').text(data.idea.title);
      form.find('form').attr('action', url);
      form.find('.delete_button').attr('href', url);

      form.find('#idea_title').val(data.idea.title);
      form.find('#idea_description').val(data.idea.description);
      form.find('#idea_created_by').val(data.idea.created_by);
      form.find('#idea_category').val(data.idea.category_id);

    form.find('.clearfix.error input').find('input').val('');
    form.find('.clearfix.error .help-inline').html('');
    form.find('.clearfix.error').removeClass('error');
    form.modal({
        backdrop: true,
        show: true
      });
    },
    error: function(jq, textStatus, errorThrown) {
      alert("Unexpected error: " + errorThrown);
    }
  });
}

function saveButtonClicked() {
    var form = $("#idea_form form");
    $.ajax({
      type: 'POST',
      url: form.prop('action'),
      data: form.serialize(), 
      dataType: 'json',
      success: function(data) {
        $('body').trigger('idea_saved', data);
        $("#idea_form").modal('hide');
      },
      error: function(jq, textStatus, errorThrown) {
          var response = $.parseJSON(jq.responseText);
          var errors = response.errors;
          for (field in errors) {
            var input_div = form.find("." + field);
            input_div.addClass("error");
            input_div.find(".help-inline").html(errors[field].join(","));
          }
      }
    });
    return false;  
}


function newButtonClicked() {
    var form = $(this).parent().parent();
    $.ajax({
        type: 'POST',
        url: '/projects/'+form.data('proj-id')+'/ideas',
        //data: form.serialize(),
        //dataType: 'json',
        success: function(data) {
            $("#ideaModal").modal('hide');
        },
        error: function(jq, textStatus, errorThrown) {

        }
    });
    return false;
}

$(document).ready(function() {
  $('button.ajaxd').click(saveButtonClicked);
  $('button.newajax').click(newButtonClicked);
    $('.new-idea-button').click(function(){
        $(this).parent().find('.modal').modal('show')
                .find('form').data('proj-id', $(this).data('proj-id'));
    });
});






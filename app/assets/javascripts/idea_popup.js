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
      $('#idea_form h3.title').text(data.idea.title);
      $('#idea_form form').attr('action', url);
      $('#idea_form .delete_button').attr('href', url);

      $('#idea_title').val(data.idea.title);
      $('#idea_description').val(data.idea.description);

      $('#idea_form .clearfix.error input').find('input').val('');
      $('#idea_form .clearfix.error .help-inline').html('');
      $('#idea_form .clearfix.error').removeClass('error');
      $('#idea_form').modal({
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

$(document).ready(function() {
  $('button.ajaxd').click(saveButtonClicked);
});


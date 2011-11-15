// How to use this script:
//   render the stories/form partial in your view
//   bind an event handler to get story_saved events on body
//   Make links call the openStory method
function openStory(url) {
  $.ajax({
    type: 'GET',
    url: url,
    dataType: 'json',
    success: function(data) {
      $('#story_form h3.title').text(data.story.title);
      $('#story_form form').attr('action', url);
      $('#story_form .delete_button').attr('href', url);

      $('#story_title').val(data.story.title);

      $('#story_form .clearfix.error input').find('input').val('');
      $('#story_form .clearfix.error .help-inline').html('');
      $('#story_form .clearfix.error').removeClass('error');
      $('#story_form').modal({
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
    var form = $("#story_form form");
    $.ajax({
      type: 'POST',
      url: form.prop('action'),
      data: form.serialize(), 
      dataType: 'json',
      success: function(data) {
        $('body').trigger('story_saved', data);
        $("#story_form").modal('hide');
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


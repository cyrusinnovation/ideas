
$(document).ready(function() {
  $('#ideas_table').tablesorter({ sortList: [[3,1]],
                            textExtraction:function(s){
                               if($(s).find('img').length == 0) return $(s).text();
                               return $(s).find('img').attr('alt');
                          }
  });

});
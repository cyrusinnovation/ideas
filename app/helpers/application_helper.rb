module ApplicationHelper
  def project_dropdown_title
    word =  in_project? ? current_project.name : 'Projects'
    indicate_dropdown word
  end
  
  def project_dropdown_projects
    in_project? ? (current_user.projects - [current_project]) : current_user.projects
  end

  def indicate_dropdown word
    (word + "<b class='caret'></b>").html_safe
  end
  
end

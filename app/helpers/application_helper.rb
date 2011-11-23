module ApplicationHelper
  def project_dropdown_title
    return in_project? ? current_project.name : 'Projects'
  end
  
  def project_dropdown_projects
    return in_project? ? (current_user.projects - [current_project]) : current_user.projects
  end
  
end

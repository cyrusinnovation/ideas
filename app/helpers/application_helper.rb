module ApplicationHelper

  def format_title title, length=60
    content_tag 'span', truncate(title, :length => length), :title => title
  end

  def project_dropdown_title
    return in_project? ? current_project.name : 'Projects'
  end
  
  def project_dropdown_projects
    return in_project? ? (current_user.projects - [current_project]) : current_user.projects
  end
  
end

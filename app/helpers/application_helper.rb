module ApplicationHelper
  include GoogleVisualization

  def format_title title, length=60
    content_tag 'span', truncate(title, :length => length), :title => title
  end

  def page_header page_title
    return "<div class='page-header'><h1>#{page_title}</h1></div>"    
  end
  
  def project_dropdown_title
    return in_project? ? current_project.name : 'Projects'
  end
  
  def project_dropdown_projects
    return in_project? ? (current_user.projects - [current_project]) : current_user.projects
  end
  
end

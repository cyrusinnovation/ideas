module CurrentProject
  def current_project
    if user_has_projects?
      project_id = params[:project_id] || current_user.projects.first
      current_user.projects.find project_id
    end
  end

  def user_has_projects?
    user_signed_in? && current_user.projects.size > 0
  end

end

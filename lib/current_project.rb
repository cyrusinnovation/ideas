module CurrentProject
  def current_project
    if user_signed_in?
      project_id = params[:project_id] || current_user.projects.first
      current_user.projects.find project_id
    end
  end
end

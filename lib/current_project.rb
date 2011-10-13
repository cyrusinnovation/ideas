module CurrentProject
  def current_project
    if in_project?
      project_id = params[:project_id]
      current_user.projects.find project_id
    end
  end

  def in_project?
    params[:project_id]
  end

end

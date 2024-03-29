class SettingsController < SecureController
  def edit
    @project = current_project
  end

  def update
    @project = update_project

    if @project.invalid?
      render :action => :edit
    else 
      redirect_to project_edit_settings_path
    end
  end

  private

  def update_project
    project = current_project
    project.name = params[:name]
    project.save
    project
  end
end

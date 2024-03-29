class ProjectsController < SecureController
  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def create
    @project = current_user.projects.create(params[:project])

    if @project.persisted?
      flash[:notice] = 'Project #{@project.name} added!'
    end
    redirect_to :action => :index
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project #{@project.name} updated!'
    end
    redirect_to :action => :index
  end

  def destroy
    current_user.projects.find(params[:id]).destroy
    redirect_to projects_url
  end
end

class ProjectsController < SecureController
  def index
    @projects = current_user.projects.order("name ASC")
    @memberships = current_user.memberships
  end

  def new
    @project = Project.new
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def create
    membership = params[:project].delete(:memberships)

    @project = current_user.projects.create(params[:project])

    if @project.persisted?
      flash[:notice] = "Project #{@project.name} added!"
    end

    if membership == "2"
      @project.add_all_users
    end
    redirect_to :action => :index
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.update_attributes(params[:project])
      flash[:notice] = "Project #{@project.name} updated!"
    end
    redirect_to :back
  end

  def update_project_idea
    @project = Project.find(params[:project][:id])
    @idea = Idea.find(params[:project][:idea][:id])
    @idea.update_attributes(:project => @project)
    render :nothing => true
  end

  def destroy
    project_name = current_user.projects.find(params[:id]).name
    current_user.projects.find(params[:id]).destroy
    flash[:notice] = "Project #{project_name} deleted!"
    redirect_to projects_url
  end
end

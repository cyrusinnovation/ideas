class IdeasController < SecureController
  def index
    @idea = current_project.ideas.build()
  end
  
  def show
    @idea = current_project.ideas.find(params[:id])
    respond_to do |format|
      format.json { render :json => {:idea => @idea} }
    end
  end

  def create
    params[:idea][:category] = Category.find params[:idea][:category]
    @idea = current_project.ideas.create(params[:idea])
    if @idea.persisted?
      flash[:notice] = 'Idea added!'
    end
    redirect_to :action => :index
  end

  def destroy
    current_project.ideas.find(params[:id]).delete
    redirect_to request.referrer, :notice => 'Idea deleted.'
  end

  def edit
    @idea = current_project.ideas.find(params[:id])
  end

  def update
    params[:idea][:category] = Category.find params[:idea][:category]
    idea = current_project.ideas.update params[:id], params[:idea]

    if idea.invalid?
      respond_to do |format|
        format.json { render :status => 400, :json => {:id => params[:id], :errors => idea.errors.messages } }
      end
    else
      respond_to do |format|
        format.json { render :json => {:id => params[:id]} }
        format.html { redirect_to :controller => :history, :action => :index }
      end
    end

  end
end

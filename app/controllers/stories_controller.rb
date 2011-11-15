class StoriesController < SecureController
  def index
    @story = current_project.stories.build()
    @groups = current_project.buckets_with_examples
  end
  
  def show
    @story = current_project.stories.find(params[:id])
    respond_to do |format|
      format.json { render :json => {:story => @story} }
    end
  end

  def create
    @story = current_project.stories.create(params[:story])
    if @story.persisted?
      flash[:notice] = 'Estimate added!'
    end
    redirect_to :action => :index
  end

  def destroy
    current_project.stories.find(params[:id]).delete
    redirect_to request.referrer, :notice => 'Estimate deleted.'
  end

  def edit
    @story = current_project.stories.find(params[:id])
  end

  def update
    story = current_project.stories.update params[:id], params[:story]

    if story.invalid?
      respond_to do |format|
        format.json { render :status => 400, :json => {:id => params[:id], :errors => story.errors.messages } }
      end
    else
      respond_to do |format|
        format.json { render :json => {:id => params[:id]} }
        format.html { redirect_to :controller => :history, :action => :index }
      end
    end

  end
end

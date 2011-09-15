class StoriesController < SecureController
  def index
    @stories = Story.list_newest_first
  end
  
  def new
    @story = Story.new
  end

  def create
    Story.create params[:story]
    redirect_to :action => :index
  end

  def destroy
    Story.find(params[:id]).delete
    redirect_to :action => :index
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    Story.update params[:id], params[:story]
    redirect_to :action => :index
  end

end

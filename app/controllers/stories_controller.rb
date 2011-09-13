class StoriesController < SecureController
  def index
    @stories = current_user.stories.sort
    @editable_story = current_user.stories.build
  end

  def create
    current_user.stories.create params[:story]
    redirect_to :action => :index
  end

  def destroy
    current_user.stories.find(params[:id]).delete
    redirect_to :action => :index
  end

  def edit
    @stories = current_user.stories.sort
    @editable_story = current_user.stories.find(params[:id])
    render 'index'
  end

  def update
    current_user.stories.update params[:id], params[:story]
    redirect_to :action => :index
  end
end

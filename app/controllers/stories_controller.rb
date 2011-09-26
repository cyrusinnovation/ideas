class StoriesController < SecureController
  def index
    @stories = current_user.stories.order("title ASC")
    @stories_no_actual = current_user.stories.where('finished IS NULL AND hours_worked IS NULL').order("title ASC")
  end
  
  def new
    @story = current_user.stories.build
  end

  def new_interactive
    @story = current_user.stories.build(params[:story])
    @groups = current_user.buckets_with_examples
    render "estimation_view/index"
  end

  def create
    @story = current_user.stories.create(params[:story])
    if @story.persisted?
      flash[:success] = 'Estimate added!'
    end
    redirect_to :action => :index
  end

  def destroy
    current_user.stories.find(params[:id]).delete
    redirect_to :action => :index
  end

  def edit
    @story = current_user.stories.find(params[:id])
  end

  def update
    current_user.stories.update params[:id], params[:story]
    redirect_to :action => :index
  end
  
end

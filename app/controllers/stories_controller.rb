class StoriesController < SecureController
  def index
    @stories = current_user.stories.order("started DESC")
  end
  
  def new
    @story = current_user.stories.build
  end

  def new_interactive
    @story = current_user.stories.build(params[:story])
    @groups = [
        examples(13),
        examples(8),
        examples(5),
        examples(3),
        examples(2),
        examples(1),
        examples(0.5),
        examples(0.25),
    ]
  end

  def create
    @story = current_user.stories.create(params[:story])
    
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
  
  
  
  private

  def examples( estimate)
    target = current_user.target_point_size * estimate
    current_user.find_example_stories(:estimate => estimate,
                                  :target => target,
                                  :min => target * 0.8,
                                  :max => target * 1.2,
                                  :count => 9)
  end
  
end

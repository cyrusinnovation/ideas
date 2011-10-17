class StoriesController < SecureController
  def index
    @stories = current_project.stories.order("title ASC")
    @stories_no_actual = current_project.stories.where('finished IS NULL AND hours_worked IS NULL').order("title ASC")
  end
  
  def new
    @story = current_project.stories.build
  end

  def new_interactive
    @story = current_project.stories.build(params[:story])
    @groups = current_project.buckets_with_examples
    render "estimation_view/index"
  end

  def create
    fix_date
    @story = current_project.stories.create(params[:story])
    if @story.persisted?
      flash[:success] = 'Estimate added!'
    end
    redirect_to :action => :index
  end

  def destroy
    current_project.stories.find(params[:id]).delete
    redirect_to :action => :index
  end

  def edit
    @story = current_project.stories.find(params[:id])
  end

  def update
    fix_date
    story = current_project.stories.update params[:id], params[:story]

    if story.invalid?
      respond_to do |format|
        format.json { render :status => 400, :json => {:id => params[:id], :errors => story.errors.messages } }
        # format.html { redirect_to :controller => :history, :action => :index }
      end
    else
      respond_to do |format|
        format.json { render :json => {:id => params[:id]} }
        format.html { redirect_to :controller => :history, :action => :index }
      end
    end

  end

  def fix_date
    finished = params[:story][:finished]
    if finished && !finished.empty?
      day = finished.slice(0, 2)
      month = finished.slice(3, 2)
      year = finished.slice(6, 4)
      params[:story][:finished] = "#{month}/#{day}/#{year}"
    end
  end
end

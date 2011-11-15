class HistoryController < SecureController
  def index
    @stories = current_project.stories.order("title ASC")
  end  
end

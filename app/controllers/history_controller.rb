class HistoryController < SecureController
  def index
    @stories = current_user.stories.order("title ASC")
  end  
end
class HistoryController < SecureController
  def index
    @stories = current_user.stories.order("title ASC")
    @all_actuals_by_estimate = current_user.all_actuals_by_estimate
  end  
end

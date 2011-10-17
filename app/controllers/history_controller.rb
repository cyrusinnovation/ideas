class HistoryController < SecureController
  def index
    @stories = current_project.stories.order("title ASC")
    @all_actuals_by_estimate = current_project.stories.all_actuals_by_estimate
  end  
end

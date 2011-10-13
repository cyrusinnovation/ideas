class HistoryController < SecureController
  def index
    @stories = current_project.stories.order("title ASC")
    @all_actuals_by_estimate = current_project.all_actuals_by_estimate
  end  
end

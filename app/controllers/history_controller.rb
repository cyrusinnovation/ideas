class HistoryController < SecureController
  def index
    @ideas = current_project.ideas.order("title ASC")
  end
end

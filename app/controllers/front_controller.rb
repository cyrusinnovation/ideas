class FrontController < ApplicationController
  def index
    redirect_to project_stories_path(current_project) if user_signed_in?
  end

  def privacy
  end

end

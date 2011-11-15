class FrontController < ApplicationController
  def index
    if user_signed_in? && !current_user.projects.empty?
      redirect_to project_ideas_path(current_user.projects.first)
    elsif user_signed_in?
      redirect_to new_project_path
    end
  end
end

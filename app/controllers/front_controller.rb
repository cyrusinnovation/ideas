class FrontController < ApplicationController
  def index
    if user_signed_in? && !current_user.projects.empty?
      redirect_to projects_path
    elsif user_signed_in?
      redirect_to new_project_path
    end
  end
end

class SettingsController < ApplicationController
  def edit
    session[:return_to] = request.referer
  end

  def update
    current_user.target_point_size = params[:user][:target_point_size]
    current_user.save
    redirect_to session[:return_to]
  end
end

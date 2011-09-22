class SettingsController < ApplicationController
  def update
    current_user.target_point_size = params[:user][:target_point_size]
    current_user.save
    redirect_to settings_edit_path
  end
end

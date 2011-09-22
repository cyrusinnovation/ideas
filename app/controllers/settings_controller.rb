class SettingsController < ApplicationController
  def edit
  end

  def update
    current_user.target_point_size = params[:user][:target_point_size]
    current_user.save
    redirect_to :action => :edit
  end
end

class SettingsController < ApplicationController
  def update
    current_user.target_point_size = params[:user][:target_point_size]
    current_user.save
    redirect_to edit_settings_path
  end

  def new_bucket
    current_user.buckets << Bucket.create(:value => params[:new_bucket])
    redirect_to edit_settings_path
  end
end

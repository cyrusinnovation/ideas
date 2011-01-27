class StoriesController < ApplicationController
  def index
    @stories = Story.all
    @new_story = Story.new
  end

  def create
    Story.create params[:story]
    redirect_to :action => :index
  end
end

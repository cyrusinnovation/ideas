class StoriesController < ApplicationController
  def index
    @stories = Story.list_newest_first
    @editable_story = Story.new
  end

  def create
    Story.create params[:story]
    redirect_to :action => :index
  end

  def destroy
    Story.find(params[:id]).delete
    redirect_to :action => :index
  end

  def edit
    @stories = Story.list_newest_first
    @editable_story = Story.find(params[:id])
    render 'index'
  end

  def update
    Story.update params[:id], params[:story]
    redirect_to :action => :index
  end

  def prepare_import
  end

  def import
    Story.delete_all
    Import.new(params[:file]).each {|story| story.save }
    redirect_to :action => :index
  end
end

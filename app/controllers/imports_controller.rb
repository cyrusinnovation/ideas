class ImportsController < SecureController
  def new
  end

  def create
    Story.delete_all
    Import.new(params[:file]).each {|story| story.save }
    redirect_to stories_path
  end
end

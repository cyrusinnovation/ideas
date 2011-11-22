class FavoriteIdeasController < SecureController
  def create
    FavoriteIdea.create :user => current_user, :idea => Idea.find(params[:idea])
    respond_to do |format|
      format.json { render :json => {} }
      format.html { redirect_to :controller => :history, :action => :index }
    end
  end
  
  def delete
    FavoriteIdea.find_by_idea_id(params[:idea]).delete
    respond_to do |format|
      format.json { render :json => {} }
      format.html { redirect_to :controller => :history, :action => :index }
    end
 end
end

class RatingsController < SecureController
  def rate
    idea = Idea.find params[:idea]
    new_rating = params[:rating]
    rating = Rating.find_by_user_id_and_idea_id(current_user, idea)
    if rating.nil?
      Rating.create :user => current_user, :idea => idea, :rating => new_rating
    else
      rating.rating = new_rating
      rating.save
    end

    respond_to do |format|
      format.json { render :json => {} }
      format.html { redirect_to :controller => :history, :action => :index }
    end

  end
end

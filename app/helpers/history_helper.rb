module HistoryHelper
  def favorite_img idea
    if current_user.favorite_idea? idea
      image_tag "star-checked.png", :alt => 'favorite', "data-idea-id" => idea.id
    else
      image_tag "star-unchecked.png", :alt => 'not favorite', "data-idea-id" => idea.id
    end
  end

  def get_unfilled_stars idea
    Rating.max_rating - idea.get_rating_for_user(current_user)
  end

  def get_average_unfilled_stars idea
    Rating.max_rating - idea.average_rating
  end

  def format_created_by created_by
    return '' if created_by.nil?
    created_by.sub /@.*/, ''
  end

  def format_date time
    return "" if time.nil?
    time.strftime("%m/%d/%y %I:%M %p")
  end

end

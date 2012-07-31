module IdeasHelper
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

  def format_title title, length=50
    content_tag 'span', truncate(title, :length => length), :title => title
  end

  def format_description description
    content_tag 'span', description, :title => description
  end

end

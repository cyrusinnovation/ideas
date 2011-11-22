module HistoryHelper
  def favorite_img idea
    if current_user.favorite_idea? idea
      image_tag "star-checked.png", :alt => 'favorite', "data-idea-id" => idea.id
    else
      image_tag "star-unchecked.png", :alt => 'not favorite', "data-idea-id" => idea.id
    end
  end
end

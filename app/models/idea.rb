class Idea < ActiveRecord::Base
  belongs_to :project
  belongs_to :category
  has_many :favorite_ideas
  has_many :ratings
  
  validates :title, :presence => true, :length => { :maximum => 255 }

  def get_rating_for_user user
    user_ratings = ratings.where(:user_id => user)
    return user_ratings[0].rating unless user_ratings[0].nil?
    0
  end
end

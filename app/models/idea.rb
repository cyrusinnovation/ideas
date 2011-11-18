class Idea < ActiveRecord::Base
  belongs_to :project
  has_many :rating
  validates :title, :presence => true, :length => { :maximum => 255 }

  def get_user_rating user
    return 0 if rating.where(:user_id => user.id)[0].nil?
    rating.where(:user_id => user.id)[0].rating
  end
end

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  def self.max_rating
    5
  end
end

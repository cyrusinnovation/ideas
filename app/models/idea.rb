class Idea < ActiveRecord::Base
  belongs_to :project
  has_many :favorite_ideas
  
  validates :title, :presence => true, :length => { :maximum => 255 }
end

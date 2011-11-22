class Idea < ActiveRecord::Base
  belongs_to :project
  belongs_to :category
  has_many :favorite_ideas
  
  validates :title, :presence => true, :length => { :maximum => 255 }
end

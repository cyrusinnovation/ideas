class Story < ActiveRecord::Base
  belongs_to :project
  validates :title, :presence => true, :length => { :maximum => 255 }
end

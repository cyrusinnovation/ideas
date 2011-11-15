class Story < ActiveRecord::Base
  belongs_to :project
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates_numericality_of :hours_worked, :greater_than_or_equal_to => 0, :less_than => 99999, :allow_nil => true
  validates_numericality_of :estimate, :greater_than_or_equal_to => 0, :less_than => 99999, :allow_nil => true
  
end

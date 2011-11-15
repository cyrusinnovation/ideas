class Project < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 255 }
  has_many :stories, :dependent => :destroy

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  validates_numericality_of :target_point_size, :greater_than => 0, :less_than => 100, :allow_nil => false

end

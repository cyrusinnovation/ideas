class Project < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 255 }
  has_many :stories, :dependent => :destroy
  has_many :buckets, :dependent => :destroy, :order => 'value ASC'

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  validates_numericality_of :target_point_size, :greater_than => 0, :less_than => 100, :allow_nil => false
  validates :buckets, :presence => true 

  before_validation :create_default_buckets, :on => :create

  def create_default_buckets
    buckets << [1, 2, 3, 5, 8, 13].map { |bucket| Bucket.create :value => bucket }
  end

end

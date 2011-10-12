class Project < ActiveRecord::Base
  has_many :stories, :dependent => :destroy
  has_many :buckets, :dependent => :destroy, :order => 'value ASC'

  has_many :memberships
  has_many :users, :through => :memberships
end

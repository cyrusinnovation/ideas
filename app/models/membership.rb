class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, :presence => true
  validates :project, :presence => true

  validates_uniqueness_of :project_id, :scope => :user_id
end

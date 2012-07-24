class Project < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 255 }
  has_many :ideas, :dependent => :destroy

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  def add_all_users
    self.users = User.all
  end
end

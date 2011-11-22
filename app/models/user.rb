class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships

  has_many :favorite_ideas, :dependent => :destroy
  has_many :favorites, :through => :favorite_ideas, :source => :idea
  

  def self.find_for_google_oauth(access_token, signed_in_resource=nil)
    data = access_token['info']
    if user = User.find_by_email(data['email'])
      user
    else #create a user with stub pwd
      User.create!(:email => data['email'], :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.googleapps_data'] && session['devise.googleapps_data']['user_info']
        user.email = data['email']
      end
    end
  end


  def favorite_idea? idea
    favorites.select {|i| i.id == idea.id}.size > 0
  end
  
end

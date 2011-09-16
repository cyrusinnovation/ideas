class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :stories, :dependent => :destroy

  def hours_worked_by_estimate
    DataSeries.by_group(all_with_burn_rates, :group => :estimate) {|s| s.hours_worked }
  end

  def all_with_burn_rates
    stories.where("estimate IS NOT NULL AND hours_worked IS NOT NULL").order("finished DESC")
  end

  def find_example_stories(options)
    examples(options).map do |story|
      EstimationStory.new story.title, options[:estimate], story.estimate
    end
  end

  private

  def examples options
    examples = well_estimated_stories(options).where(["finished >= ?", 60.days.ago])
    examples += well_estimated_stories(options).where(["finished < ?", 60.days.ago]) if examples.size < options[:count]
    examples.first(options[:count])
  end

  def well_estimated_stories options
    stories.well_estimated_stories options[:min], options[:max], options[:count], options[:target]
  end
end

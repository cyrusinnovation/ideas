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
    estimate = options[:estimate]
    target = options[:target]
    low = options[:min]
    high = options[:max]
    count = options[:count]
    examples = closest target, ["hours_worked >= ? AND hours_worked <= ? AND finished >= ?", low, high, Date.today - 60]
    if examples.size < count
      examples += closest target, ["hours_worked >= ? AND hours_worked <= ?", low, high]
    end
    examples.first(count).map do |story|
      EstimationStory.new story.title, estimate, story.estimate
    end
  end

  def closest(target, conditions)
    examples = stories.find :all, :conditions => conditions
    examples = examples.sort_by { |story| (story.hours_worked - target).abs }
    examples
  end
end

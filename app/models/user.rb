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

    examples(low, high, target, count).map do |story|
      EstimationStory.new story.title, estimate, story.estimate
    end
  end

  private

  def examples low, high, target, count
    examples = stories.select("*, abs(hours_worked - #{target}) as quality")
    examples = examples.order('quality asc').limit(count)
    examples = examples.where(["hours_worked >= ?", low])
    examples = examples.where(["hours_worked <= ?", high])
    examples = examples.where(["finished >= ?", 60.days.ago])

    if examples.size < count
      more_examples = stories.select("*, abs(hours_worked - #{target}) as quality")
      more_examples = more_examples.order('quality asc').limit(count - examples.size)
      more_examples = more_examples.where(["hours_worked >= ?", low])
      more_examples = more_examples.where(["hours_worked <= ?", high])
      more_examples = more_examples.where(["finished < ?", 60.days.ago])
      examples += more_examples
    end
    examples
  end
end

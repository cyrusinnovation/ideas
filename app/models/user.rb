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

  def stories_for_estimation(bucket)
    examples(bucket)
  end

  def buckets_with_examples
    buckets.reverse.collect {|b| [b, stories_for_estimation(b)] }
  end

  def estimate_hours(estimate)
    target_point_size * estimate
  end

  def buckets
    [0.25, 0.5, 1, 2, 3, 5, 8, 13, 21]
  end

  private

  def examples bucket
    target = target_point_size * bucket
    options = {    
                :estimate => bucket,
                :target => target,
                :min => target * 0.8,
                :max => target * 1.2,
                :count => 9
              }
    examples = well_estimated_stories(options).where(["finished >= ?", 60.days.ago])
    examples += well_estimated_stories(options).where(["finished < ?", 60.days.ago]) if examples.size < options[:count]
    examples.first(options[:count])
  end

  def well_estimated_stories options
    stories.well_estimated_stories options[:min], options[:max], options[:count], options[:target]
  end
end

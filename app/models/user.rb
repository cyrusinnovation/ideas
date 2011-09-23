class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  EXAMPLES_PER_BUCKET = 9
  EXAMPLE_DELTA = 0.2
  EXAMPLE_RECENCY_CUTOFF = 60
  
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

  def examples(bucket)
    target = target_point_size * bucket
    min = target * (1 - EXAMPLE_DELTA)
    max = target * (1 + EXAMPLE_DELTA)
    count = EXAMPLES_PER_BUCKET
    examples = stories.select("*, abs(hours_worked - #{target}) as quality, sign(#{EXAMPLE_RECENCY_CUTOFF} - (current_date - finished)) as recent")
    examples = examples.where(["hours_worked >= ?", min])
    examples = examples.where(["hours_worked <= ?", max])
    examples = examples.order('recent desc, quality asc').limit(count)
    examples
  end

end

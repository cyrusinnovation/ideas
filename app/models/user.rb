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

  def stories_for_estimation(bucket)
    examples(bucket)
  end

  def buckets_with_examples
    buckets.collect {|b| [b, stories_for_estimation(b)] }
  end

  def estimate_hours(estimate)
    target_point_size * estimate
  end

  def buckets
    [0.25, 0.5, 1, 2, 3, 5, 8, 13]
  end

  def min bucket
    estimate_hours(bucket) * (1 - EXAMPLE_DELTA)
  end

  def max bucket
    estimate_hours(bucket) * (1 + EXAMPLE_DELTA)
  end
  
  def actuals bucket
    finished = stories.where("estimate = #{bucket} and hours_worked is not null").order("finished DESC")
    DataSeries.new(finished.collect {|story| story.hours_worked} )
  end
  
  def all_actuals
    finished = stories.where("hours_worked is not null").order("finished DESC")
    DataSeries.new(finished.collect {|story| story.hours_worked} )
  end
  
  def all_actuals_by_estimate
    finished = stories.where("estimate is not null and hours_worked is not null").order("finished DESC").group_by {|s| s.estimate}
    result = {}
    finished.each do |estimate, stories|
      result[estimate] = DataSeries.new(stories.collect {|story| story.hours_worked} )
    end
    result
  end

  def all_actuals_normalized
    finished = stories.where("estimate is not null and hours_worked is not null").order("finished DESC")
    DataSeries.new(finished.collect {|story| story.hours_worked / story.estimate} )
  end


  private

  def examples(bucket)
    count = EXAMPLES_PER_BUCKET
    examples = stories.select("*, abs(hours_worked - #{estimate_hours(bucket)}) as quality, sign(#{EXAMPLE_RECENCY_CUTOFF} - (current_date - finished)) as recent")
    examples = examples.where(["hours_worked >= ?", min(bucket)])
    examples = examples.where(["hours_worked <= ?", max(bucket)])
    examples = examples.order('recent desc, quality asc').limit(count)
    examples
  end

end

class Project < ActiveRecord::Base
  EXAMPLES_PER_BUCKET = 9
  EXAMPLE_DELTA = 0.2
  EXAMPLE_RECENCY_CUTOFF = 60

  validates :name, :presence => true, :length => { :maximum => 255 }
  has_many :stories, :dependent => :destroy
  has_many :buckets, :dependent => :destroy, :order => 'value ASC'

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  validates_numericality_of :target_point_size, :greater_than => 0, :less_than => 100, :allow_nil => false

  after_create :create_default_buckets

  def create_default_buckets
    buckets << [1, 2, 3, 5, 8, 13].map { |bucket| Bucket.create :value => bucket }
  end

  def stories_for_estimation(bucket)
    examples(bucket)
  end

  def buckets_with_examples
    buckets.collect {|b| [b, stories_for_estimation(b)] }
  end

  def estimate_hours(bucket)
    target_point_size * bucket.value
  end

  def min bucket
    estimate_hours(bucket) * (1 - EXAMPLE_DELTA)
  end

  def max bucket
    estimate_hours(bucket) * (1 + EXAMPLE_DELTA)
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

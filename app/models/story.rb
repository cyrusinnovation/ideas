class Story < ActiveRecord::Base
  belongs_to :project
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates_numericality_of :hours_worked, :greater_than_or_equal_to => 0, :less_than => 99999, :allow_nil => true
  validates_numericality_of :estimate, :greater_than_or_equal_to => 0, :less_than => 99999, :allow_nil => true

  def burn_rate
    return nil if hours_worked.nil?
    return nil if estimate.nil?
    hours_worked / estimate
  end

  def <=> other
    return -1 if title.nil?
    return 1 if other.title.nil?
    other.title <=> title
  end

  def bucket
    project.buckets.find_by_value(estimate)
  end

  def variance_vs_mean actuals
    return nil if hours_worked.nil? || actuals.nil?
    difference = hours_worked - actuals.mean
    difference.abs > actuals.standard_deviation ? difference.round : nil
  end

  def self.no_actuals?
    return where( "hours_worked is not NULL" ).empty?
  end

  def self.actuals bucket
    finished = where("estimate = #{bucket.value} and hours_worked is not null").order("finished DESC")
    DataSeries.new(finished.collect {|story| story.hours_worked} )
  end
  
  def self.all_actuals
    finished = where("hours_worked is not null").order("finished DESC")
    DataSeries.new(finished.collect {|story| story.hours_worked} )
  end
  
  def self.all_actuals_by_estimate
    finished = where("estimate is not null and hours_worked is not null").order("finished DESC").group_by {|s| s.estimate}
    result = {}
    finished.each do |estimate, stories|
      result[estimate] = DataSeries.new(stories.collect {|story| story.hours_worked} )
    end
    result
  end

  def self.all_actuals_normalized
    finished = where("estimate is not null and hours_worked is not null").order("finished DESC")
    DataSeries.new(finished.collect {|story| story.hours_worked / story.estimate} )
  end


  EXAMPLES_PER_BUCKET = 9
  EXAMPLE_RECENCY_CUTOFF = 60

  def self.for_estimation(bucket)
    examples(bucket)
  end

  private

  def self.examples(bucket)
    count = EXAMPLES_PER_BUCKET
    examples = select("*, abs(hours_worked - #{bucket.hours}) as quality, sign(#{EXAMPLE_RECENCY_CUTOFF} - (current_date - finished)) as recent")
    examples = examples.where(["hours_worked >= ?", bucket.min])
    examples = examples.where(["hours_worked < ?", bucket.max])
    examples = examples.order('recent desc, quality asc').limit(count)
    examples
  end
end

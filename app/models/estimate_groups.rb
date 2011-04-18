class EstimateGroups
  attr_reader :all_per_story, :all_per_point

  def initialize stories
    @averages_by_estimate = Average.by_group(stories, :group => :estimate, :value => :hours_worked)
    @groups = EstimateGroup.collect(@averages_by_estimate)
    @all_per_story = EstimateGroup.new("All - Story", Average.new(stories, :value => :hours_worked))
    @all_per_point = EstimateGroup.new("All - Point", Average.new(stories, :value => :burn_rate))
    @groups << @all_per_story
    @groups << @all_per_point
  end

  def story_vs_estimate story
    StoryVsEstimate.new(story, self)
  end

  def each &whatToDoWithIt
    @groups.each &whatToDoWithIt
  end

  def average estimate
    @averages_by_estimate[estimate]
  end
end

class StoryVsEstimate < DelegateClass(Story)
  def initialize story, estimate_groups
    super(story)
    @story = story
    @estimate_groups = estimate_groups
  end

  def status
    difference = hours_vs_average
    return nil if difference.nil?
    difference < 0 ? :overestimated : :underestimated
  end

  def hours_vs_average
    difference = hours_worked - average.mean
    difference.abs < average.standard_deviation ? nil : difference.round
  end

  def average
    @estimate_groups.average(estimate)
  end
end

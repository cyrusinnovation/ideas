class EstimateGroups
  attr_reader :all_per_story, :all_per_point

  def initialize stories
    @averages_by_estimate = Average.by_group(stories, :group => :estimate) { |s| s.hours_worked }
    @groups = EstimateGroup.collect(@averages_by_estimate)
    @all_per_story = EstimateGroup.new("All - Story", Average.new(stories) { |s| s.hours_worked })
    @all_per_point = EstimateGroup.new("All - Point", Average.new(stories) { |s| s.hours_worked / s.estimate })
    @groups << @all_per_story
    @groups << @all_per_point
  end

  def story_vs_estimate story
    StoryVsEstimate.new(story, self)
  end

  def each &what_to_do_with_it
    @groups.each &what_to_do_with_it
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
    difference = variance_vs_average
    return nil if difference.nil?
    difference < 0 ? :overestimated : :underestimated
  end

  def variance_vs_average
    difference = hours_worked - average.mean
    difference.abs < average.standard_deviation ? nil : difference.round
  end

  def average
    @estimate_groups.average(estimate)
  end
end

class EstimateGroups
  attr_reader :all_per_story, :all_per_point

  def initialize stories, &value_block
    @value_block = value_block
    @averages_by_estimate = Average.by_group(stories, :group => :estimate, &value_block)
    @groups = EstimateGroup.collect(@averages_by_estimate)
    @all_per_story = EstimateGroup.new("All - Story", Average.new(stories, &value_block))
    stories_with_estimates = stories.reject { |s| s.estimate.nil? }
    @all_per_point = EstimateGroup.new("All - Point", Average.new(stories_with_estimates) { |s| value_block.call(s) / s.estimate })
    @groups << @all_per_story
    @groups << @all_per_point
  end

  def story_vs_estimate story
    StoryVsEstimate.new(story, self, &@value_block)
  end

  def each &what_to_do_with_it
    @groups.each &what_to_do_with_it
  end

  def average estimate
    return Average.empty unless @averages_by_estimate.has_key?(estimate)
    @averages_by_estimate[estimate]
  end
end

class StoryVsEstimate < DelegateClass(Story)
  def initialize story, estimate_groups, &value_block
    super(story)
    @story = story
    @estimate_groups = estimate_groups
    @value_block = value_block
  end

  def status
    return nil if empty_average?
    difference = variance_vs_average
    return nil if difference.nil?
    difference < 0 ? :overestimated : :underestimated
  end

  def variance_vs_average
    return nil if empty_average?
    difference = @value_block.call(@story) - average.mean
    difference.abs < average.standard_deviation ? nil : difference.round
  end

  def average
    @estimate_groups.average(estimate)
  end

  private

  def empty_average?
    average.empty?
  end
end

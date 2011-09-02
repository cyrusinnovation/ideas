class EstimateGroups
  attr_reader :all_data_in_single_group, :data_normalized_by_estimate

  def initialize stories, &value_block
    @value_block = value_block
    @data_grouped_by_estimate = DataSeries.by_group(stories, :group => :estimate, &value_block)
    @groups = EstimateGroup.collect(@data_grouped_by_estimate)
    @all_data_in_single_group = EstimateGroup.new("All - Story", DataSeries.new(stories, &value_block))
    stories_with_estimates = stories.reject { |s| s.estimate.nil? }
    @data_normalized_by_estimate = EstimateGroup.new("All - Point", DataSeries.new(stories_with_estimates) { |s| value_block.call(s) / s.estimate })
    @groups << @all_data_in_single_group
    @groups << @data_normalized_by_estimate
  end

  def story_vs_estimate story
    StoryVsEstimate.new(story, self, &@value_block)
  end

  def each &what_to_do_with_it
    @groups.each &what_to_do_with_it
  end

  def data_series estimate
    return @all_data_in_single_group.data_series unless @data_grouped_by_estimate.has_key?(estimate)
    @data_grouped_by_estimate[estimate]
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
    return nil if empty_data_series?
    difference = variance_vs_mean
    return nil if difference.nil?
    difference < 0 ? :overestimated : :underestimated
  end

  def variance_vs_mean
    return nil if empty_data_series?
    difference = @value_block.call(@story) - data_series.mean
    difference.abs < data_series.standard_deviation ? nil : difference.round
  end

  def data_series
    @estimate_groups.data_series(estimate)
  end

  private

  def empty_data_series?
    data_series.empty?
  end
end

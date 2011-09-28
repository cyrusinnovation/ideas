class AggregateGroups
  attr_reader :all_data_in_single_group, :data_normalized_by_estimate, :groups

  def initialize stories
    @groups = []
    @all_data_in_single_group = EstimateGroup.new("All - Story", DataSeries.new(stories) { |s| s.hours_worked }, nil)
    stories_with_estimates = stories.reject { |s| s.estimate.nil? }
    @data_normalized_by_estimate = EstimateGroup.new("All - Point", DataSeries.new(stories_with_estimates) { |s| s.hours_worked / s.estimate }, nil)
    @groups << @all_data_in_single_group
    @groups << @data_normalized_by_estimate
  end

end

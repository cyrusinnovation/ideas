class EstimateGroups
  attr_reader :all_data_in_single_group, :data_normalized_by_estimate, :groups

  def initialize stories
    @data_grouped_by_estimate = DataSeries.by_group(stories, :group => :estimate) { |s| s.hours_worked }
    @groups = EstimateGroup.collect(@data_grouped_by_estimate)
    @all_data_in_single_group = EstimateGroup.new("All - Story", DataSeries.new(stories) { |s| s.hours_worked }, nil)
    stories_with_estimates = stories.reject { |s| s.estimate.nil? }
    @data_normalized_by_estimate = EstimateGroup.new("All - Point", DataSeries.new(stories_with_estimates) { |s| s.hours_worked / s.estimate }, nil)
    @groups << @all_data_in_single_group
    @groups << @data_normalized_by_estimate
  end

  def data_series estimate
    return @all_data_in_single_group.data_series unless @data_grouped_by_estimate.has_key?(estimate)
    @data_grouped_by_estimate[estimate]
  end
end

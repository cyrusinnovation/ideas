class EstimateGroups
  attr_reader :all_data_in_single_group, :data_normalized_by_estimate

  def initialize stories, &value_block
    @value_block = value_block
    @data_grouped_by_estimate = DataSeries.by_group(stories, :group => :estimate, &value_block)
    @groups = EstimateGroup.collect(@data_grouped_by_estimate)
    @all_data_in_single_group = EstimateGroup.new("All - Story", DataSeries.new(stories, &value_block), nil)
    stories_with_estimates = stories.reject { |s| s.estimate.nil? }
    @data_normalized_by_estimate = EstimateGroup.new("All - Point", DataSeries.new(stories_with_estimates) { |s| value_block.call(s) / s.estimate }, nil)
    @groups << @all_data_in_single_group
    @groups << @data_normalized_by_estimate
  end

  def each &what_to_do_with_it
    @groups.each &what_to_do_with_it
  end

  def data_series estimate
    return @all_data_in_single_group.data_series unless @data_grouped_by_estimate.has_key?(estimate)
    @data_grouped_by_estimate[estimate]
  end
end

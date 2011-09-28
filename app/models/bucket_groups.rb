class BucketGroups
  attr_reader :all_data_in_single_group, :data_normalized_by_estimate, :groups

  def initialize stories
    @data_grouped_by_estimate = data_grouped_by_estimate stories
    @groups = EstimateGroup.collect(@data_grouped_by_estimate)
  end

  def data_grouped_by_estimate stories
    estimate_to_stories = stories.group_by {|story| story.estimate }

    estimate_to_data_series = { }
    estimate_to_stories.each do |estimate, stories|
      hours_worked_for_all_stories = stories.collect { |story| story.hours_worked }
      estimate_to_data_series[estimate] = DataSeries.new(hours_worked_for_all_stories)
    end

    estimate_to_data_series
  end

end

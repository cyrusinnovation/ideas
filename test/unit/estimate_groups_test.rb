require 'test_helper'

class EstimateGroupsTest < ActiveSupport::TestCase
  def setup
    @stories = [
        Story.new(:estimate => 2, :hours_worked => 12),
        Story.new(:estimate => 1, :hours_worked => 5),
        Story.new(:estimate => 5, :hours_worked => 20),
        Story.new(:estimate => 1, :hours_worked => 10),
        Story.new(:estimate => 0.5, :hours_worked => 3),
    ]
    @groups = EstimateGroups.new(@stories) { |s| s.hours_worked }
  end

  test "group stories by estimate" do
    group_titles = []
    @groups.each {|g| group_titles << g.title }
    assert_equal ['1/2', '1', '2', '5', 'All - Story', 'All - Point'], group_titles
  end

  test "compare a story to the average for its estimate" do
    underestimated_story = Story.new(:estimate => 1, :hours_worked => 12.5)
    comparison = @groups.story_vs_estimate(underestimated_story)
    assert_equal 1, comparison.estimate
    assert_equal :underestimated, comparison.status
    assert_equal 5, comparison.variance_vs_mean
    assert_equal 7.5, comparison.data_series.mean
  end

  test "rounds off hours vs average" do
    underestimated_story = Story.new(:estimate => 1, :hours_worked => 12)
    vs_average = @groups.story_vs_estimate(underestimated_story)
    assert_equal 5, vs_average.variance_vs_mean
  end

  test "show the overall average per story" do
    # (12 + 5 + 20 + 10 + 3) / 5
    assert_equal 10, @groups.all_data_in_single_group.data_series.mean
  end

  test "show the overall average per point" do
    # (12/2 + 5/1 + 20/5 + 10/1 + 3/.5) / 5
    assert_equal 31.0/5, @groups.data_normalized_by_estimate.data_series.mean
    # NOT (12 + 5 + 20 + 10 + 3) / (2 + 1 + 5 + 1 + .5)... but maybe that would be better?
    assert_not_equal 50/9.5, @groups.data_normalized_by_estimate.data_series.mean
  end

  test "average cycle time instead of hours worked" do
    # note cycle times of these stories match the hours from the original ones
    @stories = [
        Story.new(:estimate => 2, :hours_worked => 5, :started => '2011-1-3', :finished => '2011-1-19'),
        Story.new(:estimate => 1, :hours_worked => 5, :started => '2011-1-3', :finished => '2011-1-7'),
        Story.new(:estimate => 5, :hours_worked => 5, :started => '2011-1-3', :finished => '2011-1-31'),
        Story.new(:estimate => 1, :hours_worked => 5, :started => '2011-1-3', :finished => '2011-1-14'),
        Story.new(:estimate => 0.5, :hours_worked => 5, :started => '2011-1-3', :finished => '2011-1-5'),
    ]
    assert_equal [12, 5, 20, 10, 3], @stories.map{|s| s.cycle_time },
                 "for convenience, we're using stories whose cycle times match the hours from the original setup"
    @groups = EstimateGroups.new(@stories) { |s| s.cycle_time }
    assert_equal 10, @groups.all_data_in_single_group.data_series.mean
    assert_equal 31.0/5, @groups.data_normalized_by_estimate.data_series.mean
    underestimated_story = Story.new(:estimate => 1, :hours_worked => 5,
                                     :started => '2011-1-3', :finished => '2011-1-19')
    vs_average = @groups.story_vs_estimate(underestimated_story)
    assert_equal 5, vs_average.variance_vs_mean
  end

  test "uses the average for all stories as the point of comparison for stories with unique estimates" do
    unique_story = Story.new(:estimate => 15, :hours_worked => 78)
    vs_average = @groups.story_vs_estimate(unique_story)
    assert_equal 10, vs_average.data_series.mean, "average of all stories"
  end
end
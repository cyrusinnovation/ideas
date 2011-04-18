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
    @groups = EstimateGroups.new(@stories)
  end

  test "group stories by estimate" do
    group_titles = []
    @groups.each {|g| group_titles << g.title }
    assert_equal ['1/2', '1', '2', '5', 'All - Story', 'All - Point'], group_titles
  end

  test "compare a story to the average for its estimate" do
    underestimated_story = Story.new(:estimate => 1, :hours_worked => 12.5)
    vs_average = @groups.story_vs_estimate(underestimated_story)
    assert_equal 1, vs_average.estimate
    assert_equal :underestimated, vs_average.status
    assert_equal 5, vs_average.hours_vs_average
    assert_equal 7.5, vs_average.average.mean
  end

  test "rounds off hours vs average" do
    underestimated_story = Story.new(:estimate => 1, :hours_worked => 12)
    vs_average = @groups.story_vs_estimate(underestimated_story)
    assert_equal 5, vs_average.hours_vs_average
  end

  test "show the overall average per story" do
    # (12 + 5 + 20 + 10 + 3) / 5
    assert_equal 10, @groups.all_per_story.average.mean
  end

  test "show the overall average per point" do
    # (12/2 + 5/1 + 20/5 + 10/1 + 3/.5) / 5
    assert_equal 31.0/5, @groups.all_per_point.average.mean
    # NOT (12 + 5 + 20 + 10 + 3) / (2 + 1 + 5 + 1 + .5)... but maybe that would be better?
    assert_not_equal 50/9.5, @groups.all_per_point.average.mean
  end
end
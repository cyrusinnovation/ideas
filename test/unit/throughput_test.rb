require 'test_helper'

class ThroughputTest < ActiveSupport::TestCase
  fixtures :stories

  test "shows total points or stories for past three weeks" do
    assert_equal 3, Throughput.new(stories(:breathe_fire).finished).stories
    assert_equal 6.5, Throughput.new(stories(:breathe_fire).finished).points
  end

  test "does not count work that is more than three weeks old" do
    story = Story.create :started => '2011-2-1', :finished => '2011-2-1'
    assert_equal 1, Throughput.new(story.finished + 20).stories
    assert_equal 0, Throughput.new(story.finished + 21).stories
  end

  test "skips over holidays when counting back three weeks" do
    story = Story.create :started => '2011-2-1', :finished => '2011-2-1'
    Holiday.create :date => '2011-2-2'

    assert_equal 1, Throughput.new(story.finished + 21).stories
  end

  test "stories without estimates are not included in point count" do
    story = stories(:fly)
    story.estimate = nil
    story.save

    assert_equal 5.5, Throughput.new(stories(:breathe_fire).finished).points
  end

  test "history is empty if there are no stories" do
    Story.delete_all
    assert_equal [], Throughput.history
  end
end
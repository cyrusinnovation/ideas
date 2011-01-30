require 'test_helper'

class ThroughputTest < ActiveSupport::TestCase
  fixtures :stories

  test "adds up stories for three weeks back from date" do
    assert_equal 3, Throughput.new(stories(:breathe_fire).finished).stories
    assert_equal 2, Throughput.new(stories(:fly).finished).stories
    assert_equal 1, Throughput.new(stories(:swim).finished).stories
    assert_equal 2, Throughput.new(stories(:fly).finished + 20).stories
  end

  test "adds up points for three weeks back from date" do
    assert_equal 6.5, Throughput.new(stories(:breathe_fire).finished).points
    assert_equal 1.5, Throughput.new(stories(:fly).finished).points
    assert_equal 0.5, Throughput.new(stories(:swim).finished).points
    assert_equal 6, Throughput.new(stories(:fly).finished + 20).points
  end

  test "stories without estimates are not included in point count" do
    story = stories(:fly)
    story.estimate = nil
    story.save

    assert_equal 5.5, Throughput.new(stories(:breathe_fire).finished).points
  end
end
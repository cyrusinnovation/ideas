require 'test_helper'

class ThroughputTest < ActiveSupport::TestCase
  test "shows title of latest story" do
    stories = [Story.new(:title => 'one'), Story.new(:title => 'two')]
    assert_equal 'one', CycleTimeCalculator.new(stories).story
  end
end
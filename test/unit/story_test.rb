require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  fixtures :holidays

  test "cycle time is days from start through finish" do
    story = Story.new :started => "2011-1-26", :finished => "2011-1-27"
    assert_equal 2, story.cycle_time
  end

  test "story started and finished on the same day has a cycle time of 1" do
    story = Story.new :started => "2011-1-26", :finished => "2011-1-26"
    assert_equal 1, story.cycle_time
  end

  test "cycle time does not count weekends" do
    story = Story.new :started => "2011-1-21", :finished => "2011-1-24"
    assert_equal 2, story.cycle_time
  end

  test "cycle time does not count holidays" do
    story = Story.new :started => "2011-1-14", :finished => "2011-1-19"
    assert_equal 3, story.cycle_time
  end

  test "cycle time is nil if started or finished time is nil" do
    assert_nil Story.new(:started => "2011-1-14", :finished => nil).cycle_time
    assert_nil Story.new(:started => nil, :finished => "2011-1-14").cycle_time
    assert_nil Story.new(:started => nil, :finished => nil).cycle_time
  end
end

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

  test "a started or finished date on a holiday counts as a day of work" do
    assert_equal 2, Story.new(:started => "2011-1-21", :finished => "2011-1-22").cycle_time, "weekend finish"
    assert_equal 2, Story.new(:started => "2011-1-23", :finished => "2011-1-24").cycle_time, "weekend start"
    assert_equal 2, Story.new(:started => "2011-1-17", :finished => "2011-1-18").cycle_time, "holiday finish"
    assert_equal 2, Story.new(:started => "2011-1-14", :finished => "2011-1-17").cycle_time, "holiday start"
  end

  test "cycle time is nil if started or finished time is nil" do
    assert_nil Story.new(:started => "2011-1-14", :finished => nil).cycle_time
    assert_nil Story.new(:started => nil, :finished => "2011-1-14").cycle_time
    assert_nil Story.new(:started => nil, :finished => nil).cycle_time
  end

  test "team_name shows and assigns team" do
    s = Story.new
    s.team_name = "foo"
    assert_equal "foo", s.team.name
    assert_equal "foo", s.team_name
  end

  test "team_name is nil when team is nil" do
    assert_nil Story.new.team_name
  end

  test "setting team name to nil clears team" do
    s = stories(:swim)
    assert_equal "Schildkroete", s.team_name, "sanity check"
    s.team_name = nil
    assert_nil s.team
  end

  test "burn rate is hours per point" do
    assert_equal 3, Story.new(:estimate => 2, :hours_worked => 6).burn_rate
    assert_equal 7, Story.new(:estimate => 0.5, :hours_worked => 3.5).burn_rate, "works with fractions"
    assert_nil Story.new(:estimate => 5).burn_rate, "nil if hours worked is nil"
    assert_nil Story.new(:hours_worked => 5).burn_rate, "nil if estimate is nil"
  end

  test "average times for groups of stories by estimate" do
    Story.new(:estimate => 1.7, :hours_worked => 20, :finished => '2011-1-1').save
    Story.new(:estimate => 1.7, :hours_worked => 12, :finished => '2011-1-4').save
    Story.new(:estimate => 1.7, :hours_worked => 18, :finished => '2011-1-3').save
    Story.new(:estimate => 1.7, :hours_worked => 10, :finished => '2011-1-2').save

    averages = Story.average_hours_by_estimate
    average = averages[BigDecimal.new('1.7')]
    assert_equal 15, average.mean, "averages all stories in group"
    assert_equal bigdecimals(12, 18, 10, 20), average.values, "lists values in revere chronological order"
  end

  def bigdecimals(*values)
    values.map{|v| BigDecimal.new(v.to_s) }
  end
end

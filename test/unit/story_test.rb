require 'test_helper'

class StoryTest < ActiveSupport::TestCase

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

    averages = Story.hours_worked_by_estimate
    average = averages[BigDecimal.new('1.7')]
    assert_equal 15, average.mean, "averages all stories in group"
    assert_equal bigdecimals(12, 18, 10, 20), average.values, "lists values in revere chronological order"
  end

  def bigdecimals(*values)
    values.map{|v| BigDecimal.new(v.to_s) }
  end
end

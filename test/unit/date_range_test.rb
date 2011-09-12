require 'test_helper'

class DateRangeTest < ActiveSupport::TestCase
  def setup
    @three_weeks = DateRange.new Date.parse('2011-2-1'), Date.parse('2011-2-21')
  end

  test "has start and end" do
    assert_equal Date.parse('2011-2-1'), @three_weeks.started
    assert_equal Date.parse('2011-2-21'), @three_weeks.finished
  end

  test "counts workdays in range" do
    assert_equal 15, @three_weeks.workdays
  end

  test "can create a date range based on an end date and length" do
    range = DateRange.days_up_to(Date.parse('2011-2-21'), 15)
    assert_equal Date.parse('2011-2-21'), range.finished
    assert_equal Date.parse('2011-2-1'), range.started
  end

end
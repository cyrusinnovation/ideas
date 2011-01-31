require 'test_helper'

class CycleTimeTest < ActiveSupport::TestCase
  test "shows title of latest story" do
    stories = [Story.new(:title => 'one'), Story.new(:title => 'two')]
    assert_equal 'one', CycleTimeCalculator.new(stories).story
  end

  test "calculate cycle time for last n points" do
    stories = [
      story(1, '1/12/2011', '1/14/2011'),
      story(2, '1/11/2011', '1/13/2011'), # 3 points
      story(1, '1/10/2011', '1/12/2011'), # 4 points
      story(2, '1/7/2011', '1/11/2011'),  # 6 points
      story(2, '1/7/2011', '1/10/2011'),  # 8 points
      story(1, '1/6/2011', '1/7/2011'),   # 9 points
      story(3, '1/4/2011', '1/7/2011'),  # 12 points
      story(2, '1/4/2011', '1/6/2011'),  # 14 points
      story(2, '1/3/2011', '1/4/2011'),  # 15 points
    ]
    calculator = CycleTimeCalculator.new(stories)
    assert_equal 6, calculator.for_points(5)
    assert_equal 9, calculator.for_points(10)
    assert_equal 10, calculator.for_points(15)
  end

  def story estimate, started, finished
    Story.new(:estimate => estimate, :started => started, :finished => finished)
  end
end
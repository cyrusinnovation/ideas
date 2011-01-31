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

  test "calculate cycle time for the last n stories" do
    stories = [
      story(1, '1/12/2011', '1/14/2011'),
      story(2, '1/11/2011', '1/13/2011'),
      story(1, '1/10/2011', '1/12/2011'),
      story(2, '1/7/2011', '1/11/2011'),
      story(2, '1/7/2011', '1/10/2011'),
      story(1, '1/6/2011', '1/7/2011'),
      story(3, '1/4/2011', '1/7/2011'),
      story(2, '1/4/2011', '1/6/2011'),
      story(2, '1/3/2011', '1/4/2011'),
    ]
    calculator = CycleTimeCalculator.new(stories)
    assert_equal 4, calculator.for_stories(2)
    assert_equal 6, calculator.for_stories(5)
    assert_equal 10, calculator.for_stories(9)
  end

  test "cycle time is nil if there is not enough data" do
    stories = [
      story(1, '1/12/2011', '1/14/2011'),
      story(2, '1/11/2011', '1/13/2011'), # 3 points
      story(1, '1/10/2011', '1/12/2011'), # 4 points
    ]
    calculator = CycleTimeCalculator.new(stories)
    assert_equal nil, calculator.for_points(5), "there aren't 5 points available"
    assert_equal 5, calculator.for_points(4), "there are 4, though"
  end

  test "cycle time goes by earliest start date if stories were started out of order" do
  stories = [
    story(1, '1/12/2011', '1/14/2011'),
    story(2, '1/3/2011', '1/13/2011'), # 3 points
    story(1, '1/10/2011', '1/12/2011'), # 4 points
    story(2, '1/7/2011', '1/11/2011'),  # 6 points
  ]
  calculator = CycleTimeCalculator.new(stories)
  assert_equal 10, calculator.for_points(5)
  end

  test "can list cumulative cycle time calculators back to the first story" do
    stories = [
      Story.new(:title => "a"),
      Story.new(:title => "b"),
      Story.new(:title => "c")
    ]
    calculator = CycleTimeCalculator.new(stories)
    list = calculator.list_back
    assert_equal ["a", "b", "c"], list.collect {|c| c.story }
  end

  test "quietly skips nil estimates" do
    stories = [
      story(1, '1/12/2011', '1/14/2011'),
      story(2, '1/11/2011', '1/13/2011'),   # 3 points
      story(nil, '1/10/2011', '1/12/2011'), # 3 points
      story(1, '1/7/2011', '1/11/2011'),    # 4 points
      story(1, '1/6/2011', '1/10/2011'),    # 5 points
    ]
    calculator = CycleTimeCalculator.new(stories)
    assert_equal 7, calculator.for_points(5)
  end

  def story estimate, started, finished
    Story.new(:estimate => estimate, :started => started, :finished => finished)
  end
end
require 'test_helper'

module EstimationStoryFindExamplesTestHelper
  def assert_contains examples, story
    example_titles = examples.map { |e| e.title }
    assert example_titles.include?(story.title), "Examples (#{examples.join ', '}) should include '#{story.title}'"
  end

  def assert_does_not_contain examples, story
    example_titles = examples.map { |e| e.title }
    assert !example_titles.include?(story.title), "Examples (#{examples.join ', '}) should not include '#{story.title}'"
  end
end

class EstimationStoryTest < ActiveSupport::TestCase
  test "shows both original estimate and reference estimate based on actual time" do
    example = EstimationStory.new("Story", 17, 2)

    assert_equal 17, example.estimate, "reference estimate"
    assert_equal 2, example.original, "original estimate"
  end

  test "fragment of HTML to indicate if a story was over or underestimated" do
    example = EstimationStory.new("Story", 17, 2)

    assert_equal "<span class='under'>(underestimated at 2)</span>", example.under_or_over_html
  end

  test "shows only the reference estimate if there is no original estimate" do
    example = EstimationStory.new('Story', 5, nil)

    assert_equal 5, example.estimate
    assert_equal nil, example.original
    assert_nil example.under_or_over_html
  end

  test "equal to another story with the same details" do
    example = EstimationStory.new('Story', 5, 17)

    assert example == EstimationStory.new('Story', 5, 17), 'same everything'
    assert example != EstimationStory.new('Different', 5, 17), 'different title'
    assert example != EstimationStory.new('Story', 6, 17), 'different estimate'
    assert example != EstimationStory.new('Story', 5, 23), 'different original'
    assert example == EstimationStory.new('Story', 5, BigDecimal.new('17')), "BigDecimal vs. Fixnum doesn't matter"
  end
end

class EstimationStoryFindExamplesTest < ActiveSupport::TestCase
  include EstimationStoryFindExamplesTestHelper

  def setup
    @average = Average.new [40, 50]
    @too_low = Story.create :title => 'too low', :estimate => 1, :hours_worked => 39, :finished => Date.today
    @too_high = Story.create :title => 'too high', :estimate => 3, :hours_worked => 51, :finished => Date.today
    @floor = Story.create :title => 'floor', :estimate => 2, :hours_worked => 40, :finished => Date.today
    @ceiling = Story.create :title => 'ceiling', :estimate => 2, :hours_worked => 50, :finished => Date.today
    @middle = Story.create :title => 'middle', :estimate => 2, :hours_worked => 45, :finished => Date.today
  end

  test "finds stories with hours in range of average" do
    examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 3
    assert_contains examples, @middle
    assert_contains examples, @floor
    assert_contains examples, @ceiling
    assert_length 3, examples
  end

  test "finds closest examples up to the specified count" do
    close = Story.create :title => 'close', :estimate => 2, :hours_worked => 47, :finished => Date.today
    closer = Story.create :title => 'closer', :estimate => 2, :hours_worked => 46, :finished => Date.today
    sorta_close = Story.create :title => 'sorta close', :estimate => 2, :hours_worked => 48, :finished => Date.today

    examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 3

    assert_contains examples, close
    assert_contains examples, closer
    assert_contains examples, @middle
    assert_length 3, examples

    more_examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 4
    assert_length 4, more_examples
    assert_contains more_examples, sorta_close
  end

  test "found examples show story details" do
    examples = EstimationStory.find_examples :estimate => 17, :target => 45, :min => 40, :max => 50, :count => 3
    assert_equal EstimationStory.new('middle', 17, BigDecimal.new('2')), examples[0]
  end

  def assert_length expected_length, list
    assert_equal expected_length, list.size, "List [#{list.join ', '}]"
  end
end

class EstimationStoryPrefersRecentStoriesTest < ActiveSupport::TestCase
  TARGET = 45
  MAX = 50
  MIN = 40
  OLD_DATE = Date.today - 61
  NEW_DATE = Date.today - 60

  include EstimationStoryFindExamplesTestHelper

  test "stories from the last 60 days are chosen over older stories" do
    @accurate_but_old = Story.create :title => 'accurate but old', :hours_worked => TARGET, :finished => OLD_DATE
    @newer_but_less_accurate_stories = [
        Story.create(:title => 'newer 1', :hours_worked => MAX, :finished => NEW_DATE),
        Story.create(:title => 'newer 2', :hours_worked => MIN, :finished => NEW_DATE),
        Story.create(:title => 'newer 3', :hours_worked => MIN + 1, :finished => NEW_DATE)
    ]

    examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 3

    assert_does_not_contain examples, @accurate_but_old
    @newer_but_less_accurate_stories.each { |story| assert_contains examples, story }
  end

  test "if there are not enough recent stories then pull from older ones as well" do
    @accurate_but_old = Story.create :title => 'accurate but old', :hours_worked => TARGET, :finished => OLD_DATE
    @newer_but_less_accurate_stories = [
        Story.create(:title => 'newer 1', :hours_worked => MAX, :finished => NEW_DATE),
        Story.create(:title => 'newer 2', :hours_worked => MIN, :finished => NEW_DATE),
    ]
    @newer_story_out_of_range = Story.create(:title => 'newer out', :hours_worked => MIN - 1, :finished => NEW_DATE)

    examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 3

    @newer_but_less_accurate_stories.each { |story| assert_contains examples, story }
    assert_contains examples, @accurate_but_old
    assert_does_not_contain examples, @newer_story_out_of_range
  end

  test "but newness trumps accuracy even when pulling in some older stories" do
    @most_accurate_old_story = Story.create :title => 'accurate but old', :hours_worked => TARGET, :finished => OLD_DATE
    @newer_but_less_accurate_stories = [
        Story.create(:title => 'newer 1', :hours_worked => MAX, :finished => NEW_DATE),
        Story.create(:title => 'newer 2', :hours_worked => MIN, :finished => NEW_DATE),
    ]
    @older_but_more_accurate_stories = [
        Story.create(:title => 'older 1', :hours_worked => MAX-1, :finished => OLD_DATE),
        Story.create(:title => 'older 2', :hours_worked => MIN+1, :finished => OLD_DATE),
    ]

    examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 3

    @newer_but_less_accurate_stories.each { |story| assert_contains examples, story }
    assert_contains examples, @most_accurate_old_story
    @older_but_more_accurate_stories.each { |story| assert_does_not_contain examples, story }
  end
end
require 'test_helper'

class EstimationStoryTest < ActiveSupport::TestCase
  def setup
    @average = Average.new [40, 50]
    @too_low = Story.new :title => 'too low', :estimate => 1, :hours_worked => 39
    @too_high = Story.new :title => 'too high', :estimate => 3, :hours_worked => 51
    @floor = Story.new :title => 'floor', :estimate => 2, :hours_worked => 40
    @ceiling = Story.new :title => 'ceiling', :estimate => 2, :hours_worked => 50
    @middle = Story.new :title => 'middle', :estimate => 2, :hours_worked => 45
    save_all @too_low, @too_high, @floor, @ceiling, @middle
  end

  test "finds stories with hours in range of average" do
    examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50
    assert_contains examples, @middle
    assert_contains examples, @floor
    assert_contains examples, @ceiling
    assert_length 3, examples
  end

  test "finds only the three closest examples" do
    close = Story.new :title => 'close', :estimate => 2, :hours_worked => 47
    closer = Story.new :title => 'closer', :estimate => 2, :hours_worked => 46
    save_all close, closer

    examples = EstimationStory.find_examples :estimate => 2, :target => 45, :min => 40, :max => 50

    assert_contains examples, close
    assert_contains examples, closer
    assert_contains examples, @middle
    assert_length 3, examples
  end

  test "shows both original estimate and reference estimate based on actual time" do
    examples = EstimationStory.find_examples :estimate => 17, :target => 45, :min => 40, :max => 50
    example = examples[0]

    assert_equal 17, example.estimate, "reference estimate"
    assert_equal 2, example.original, "original estimate"
  end

  test "fragment of HTML to indicate if a story was over or underestimated" do
    examples = EstimationStory.find_examples :estimate => 17, :target => 45, :min => 40, :max => 50
    example = examples[0]

    assert_equal "<span class='under'>(underestimated at 2)</span>", example.under_or_over_html
  end

  test "shows only the reference estimate if there is no original estimate" do
    example = EstimationStory.new('Example Story', 5, nil)

    assert_equal 5, example.estimate
    assert_equal nil, example.original
    assert_nil example.under_or_over_html
  end

  def assert_contains examples, story
    example_titles = examples.map{|e| e.title}
    assert example_titles.include?(story.title), "Examples (#{examples.join ', '}) should include '#{story.title}'"
  end

  def assert_length expected_length, list
    assert_equal expected_length, list.size, "List [#{list.join ', '}]"
  end

  def save_all *stories
    stories.each {|s| s.save }
  end
end

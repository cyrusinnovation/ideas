require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
end


class UsersFindExamplesTest < ActiveSupport::TestCase

  def setup
    @user = User.create({email:"kurt@vonnegut.com", password:"451154"})
    @data_series = DataSeries.new [40, 50]
    @too_low = @user.stories.create :title => 'too low', :estimate => 1, :hours_worked => 39, :finished => Date.today
    @too_high = @user.stories.create :title => 'too high', :estimate => 3, :hours_worked => 51, :finished => Date.today
    @floor = @user.stories.create :title => 'floor', :estimate => 2, :hours_worked => 40, :finished => Date.today
    @ceiling = @user.stories.create :title => 'ceiling', :estimate => 2, :hours_worked => 50, :finished => Date.today
    @middle = @user.stories.create :title => 'middle', :estimate => 2, :hours_worked => 45, :finished => Date.today
  end

  test "finds stories with hours in range of average" do
    examples = @user.find_example_stories :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 3
    assert_contains examples, @middle
    assert_contains examples, @floor
    assert_contains examples, @ceiling
    assert_length 3, examples
  end

  test "finds closest examples up to the specified count" do
    close = @user.stories.create :title => 'close', :estimate => 2, :hours_worked => 47, :finished => Date.today
    closer = @user.stories.create :title => 'closer', :estimate => 2, :hours_worked => 46, :finished => Date.today
    sorta_close = @user.stories.create :title => 'sorta close', :estimate => 2, :hours_worked => 48, :finished => Date.today

    examples = @user.find_example_stories :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 3

    assert_contains examples, close
    assert_contains examples, closer
    assert_contains examples, @middle
    assert_length 3, examples

    more_examples = @user.find_example_stories :estimate => 2, :target => 45, :min => 40, :max => 50, :count => 4
    assert_length 4, more_examples
    assert_contains more_examples, sorta_close
  end

  test "that we do not get duplicates" do
    fail("test buckets_with_examples instead")
    examples = @user.find_example_stories :estimate => 17, :target => 45, :min => 40, :max => 50, :count => 5
    assert_equal 3, examples.size
  end

  def assert_length expected_length, list
    assert_equal expected_length, list.size, "List [#{list.join ', '}]"
  end

  def assert_contains examples, story
    example_titles = examples.map { |e| e.title }
    assert example_titles.include?(story.title), "Examples (#{examples.join ', '}) should include '#{story.title}'"
  end

  def assert_does_not_contain examples, story
    example_titles = examples.map { |e| e.title }
    assert !example_titles.include?(story.title), "Examples (#{examples.join ', '}) should not include '#{story.title}'"
  end

end

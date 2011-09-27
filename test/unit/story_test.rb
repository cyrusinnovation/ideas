require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  def setup
    @user = User.create({email:"ben@franklin.com", password:"electric"})
  end

  test "burn rate is hours per point" do
    assert_equal 3, Story.new(:estimate => 2, :hours_worked => 6).burn_rate
    assert_equal 7, Story.new(:estimate => 0.5, :hours_worked => 3.5).burn_rate, "works with fractions"
    assert_nil Story.new(:estimate => 5).burn_rate, "nil if hours worked is nil"
    assert_nil Story.new(:hours_worked => 5).burn_rate, "nil if estimate is nil"
  end
end

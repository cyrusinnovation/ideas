require 'test_helper'

class EstimationViewHelperTest < ActionView::TestCase
  test "heading for a group is the size of the first story in the group" do
    group = [EstimationStory.new("Foo", 3, 3)]
    assert_equal '3', heading(group)
  end

  test "heading is blank for an empty group" do
    assert_equal '', heading([])
  end

  test "heading shows fractions as fractions" do
    group = [EstimationStory.new("Foo", 0.5, 0.5)]
    assert_equal '1/2', heading(group)
  end
end

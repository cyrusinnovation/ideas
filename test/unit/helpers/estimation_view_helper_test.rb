require 'test_helper'

class EstimationViewHelperTest < ActionView::TestCase
  test "heading for a group is the size of the first story in the group" do
    group = [EstimationStory.new("Foo", 3, 6)]
    assert_equal '3.0', heading(group)
  end

  test "heading is blank for an empty group" do
    assert_equal '', heading([])
  end
end

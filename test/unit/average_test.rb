require 'test_helper'

class AverageTest < ActiveSupport::TestCase
  test "averages numbers" do
    a = Average.new [2, 3, 4, 7]

    assert_equal 4, a.mean
  end
end

require 'test_helper'

class AverageTest < ActiveSupport::TestCase
  test "averages numbers" do
    a = Average.new [2, 3, 6, 7]

    assert_equal 4.5, a.mean
  end

  test "calculates standard deviation" do
    a = Average.new [2, 3, 4, 7]

    # variances are -2, -1, 0, 3
    # squared variances are 4, 1, 0, 9
    # mean of those is 3.5
    assert_equal Math.sqrt(3.5), a.standard_deviation
    assert_equal 1, Average.new([3, 3, 5, 5]).standard_deviation, "a simpler case"
  end

  test "renderable as html" do
    a = Average.new [3, 3, 5, 5]
    assert_equal "4.0 &plusmn; 1.0", a.to_html
  end

  test "shows 1 decimal place in html" do
    a = Average.new [1, 2, 7, 2, 6, 7]
    assert_equal "4.2 &plusmn; 2.5", a.to_html
  end

  test "maps and filters nils if given a block" do
    s2 = Story.new :estimate => 2
    s3 = Story.new :estimate => 3
    s6 = Story.new :estimate => 6
    s7 = Story.new :estimate => 7
    no_estimate = Story.new

    a = Average.new([s2, s3, s6, s7, no_estimate]) {|s| s.estimate }

    assert_equal 4.5, a.mean
  end
end

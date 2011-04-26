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

  test "normal range is mean plus or minus standard deviation" do
    a = Average.new([3, 3, 5, 5])
    assert_equal 3, a.normal_range_min
    assert_equal 5, a.normal_range_max
  end

  test "renderable as html" do
    a = Average.new [1, 2, 7, 2, 6, 7]
    assert_equal '<span title="4.17 &plusmn; 2.54">4 &plusmn; 3</span>', a.to_html
    assert_equal '4 &plusmn; 3', a.to_html_attribute
  end

  test "map values using a block when averaging" do
    s2 = Story.new :estimate => 2
    s3 = Story.new :estimate => 3
    s6 = Story.new :estimate => 6
    s7 = Story.new :estimate => 7

    a = Average.new([s2, s3, s6, s7]) {|s| s.estimate }

    assert_equal 4.5, a.mean
  end

  test "collect groups of averages" do
    s1 = Story.new :estimate => 1, :started => Date.new(2011, 1, 15)
    s3 = Story.new :estimate => 3, :started => Date.new(2011, 1, 15)
    s5 = Story.new :estimate => 5, :started => Date.new(2011, 2, 23)
    s7 = Story.new :estimate => 7, :started => Date.new(2011, 2, 23)

    a = Average.by_group([s1, s3, s5, s7], :group => :started) {|s| s.estimate }

    assert_equal 2, a[Date.new(2011, 1, 15)].mean
    assert_equal 6, a[Date.new(2011, 2, 23)].mean
  end

  test "filters out nils" do
    a = Average.new [1, nil, 1, 3, 3, nil]

    assert_equal 2, a.mean
  end

  test "can return a partial average" do
    a = Average.new [2, 3, 6, 7]

    assert_equal (11.0/3), a.first(3).mean
    assert_equal 2.5, a.first(2).mean
    assert_equal 2, a.first(1).mean
    assert_equal 4.5, a.first(700).mean, "if you ask for more it just stops at the full list"
    assert_equal (16.0/3), a.last(3).mean, "last works, as well as first"
  end
end

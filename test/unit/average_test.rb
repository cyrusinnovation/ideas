require 'test_helper'

class AverageTest < ActiveSupport::TestCase
  test "averages numbers" do
    ds = DataSeries.new [2, 3, 6, 7]

    assert_equal 4.5, ds.mean
  end

  test "calculates standard deviation" do
    ds = DataSeries.new [2, 3, 4, 7]

    # variances are -2, -1, 0, 3
    # squared variances are 4, 1, 0, 9
    # mean of those is 3.5
    assert_equal Math.sqrt(3.5), ds.standard_deviation
    assert_equal 1, DataSeries.new([3, 3, 5, 5]).standard_deviation, "a simpler case"
  end

  test "normal range is mean plus or minus standard deviation" do
    ds = DataSeries.new([3, 3, 5, 5])
    assert_equal 3, ds.normal_range_min
    assert_equal 5, ds.normal_range_max
  end

  test "renderable as html" do
    ds = DataSeries.new [1, 2, 7, 2, 6, 7]
    assert_equal '<span title="4.17 &plusmn; 2.54">4 &plusmn; 3</span>', ds.to_html
    assert_equal '4 &plusmn; 3', ds.to_html_attribute
  end

  test "map values using a block when averaging" do
    s2 = Story.new :estimate => 2
    s3 = Story.new :estimate => 3
    s6 = Story.new :estimate => 6
    s7 = Story.new :estimate => 7

    ds = DataSeries.new([s2, s3, s6, s7]) {|s| s.estimate }

    assert_equal 4.5, ds.mean
  end

  test "collect groups of averages" do
    s1 = Story.new :estimate => 1, :started => Date.new(2011, 1, 15)
    s3 = Story.new :estimate => 3, :started => Date.new(2011, 1, 15)
    s5 = Story.new :estimate => 5, :started => Date.new(2011, 2, 23)
    s7 = Story.new :estimate => 7, :started => Date.new(2011, 2, 23)

    ds = DataSeries.by_group([s1, s3, s5, s7], :group => :started) {|s| s.estimate }

    assert_equal 2, ds[Date.new(2011, 1, 15)].mean
    assert_equal 6, ds[Date.new(2011, 2, 23)].mean
  end

  test "filters out nils" do
    ds = DataSeries.new [1, nil, 1, 3, 3, nil]

    assert_equal 2, ds.mean
  end

  test "can return a partial average" do
    ds = DataSeries.new [2, 3, 6, 7]

    assert_equal (11.0/3), ds.first(3).mean
    assert_equal 2.5, ds.first(2).mean
    assert_equal 2, ds.first(1).mean
    assert_equal 4.5, ds.first(700).mean, "if you ask for more it just stops at the full list"
    assert_equal (16.0/3), ds.last(3).mean, "last works, as well as first"
  end

  test "for an average of an empty list, all properties are nil" do
    ds = DataSeries.new([])
    assert_equal nil, ds.mean
    assert_equal nil, ds.standard_deviation
    assert_equal nil, ds.normal_range_min
    assert_equal nil, ds.normal_range_max
    assert_equal nil, ds.to_html
    assert_equal nil, ds.to_html_attribute
  end

  test "recognizes empty averages" do
    assert DataSeries.new([]).empty?, "empty"
    assert !DataSeries.new([1]).empty?, "not empty"
  end
end

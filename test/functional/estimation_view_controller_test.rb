require 'test_helper'

class EstimationViewControllerTest < ActionController::TestCase
  def setup
    stub(EstimationStory).find_examples {|options| [estimation_story] * options[:count] }
  end

  test "shows three estimation examples by default" do
    get :index

    assert_equal 3, assigns(:count)
    assigns(:groups).each {|group| assert_equal 3, group.size }
  end

  test "shows a different number of estimation examples if requested" do
    get :index, :count => 5

    assert_equal 5, assigns(:count)
    assigns(:groups).each {|group| assert_equal 5, group.size }
  end

  test "refuses to show less than one story" do
    get :index, :count => -7

    assert_equal 1, assigns(:count)
    assigns(:groups).each {|group| assert_equal 1, group.size }
  end

  def estimation_story
    EstimationStory.new 'some story', 3, 2
  end
end

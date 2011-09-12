require 'test_helper'

class EstimationViewControllerTest < ActionController::TestCase
  def setup
    super
    stub(EstimationStory).find_examples {|options| [estimation_story] * options[:count] }
  end

  test "shows nine example stories per group" do
    get :index

    assigns(:groups).each {|group| assert_equal 9, group.size }
  end

  def estimation_story
    EstimationStory.new 'some story', 3, 2
  end
end

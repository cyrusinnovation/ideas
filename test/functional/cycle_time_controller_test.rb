require 'test_helper'

class CycleTimeControllerTest < ActionController::TestCase
  fixtures :stories, :teams

  test "team view shows stories for just one team" do
    get :team, :team => teams(:turtle).id

    assert_equal 2, assigns(:cycle_times).size, "should only be two results"
    assert_equal [stories(:fly).title, stories(:swim).title], assigns(:cycle_times).map{|c| c.story }
  end
end

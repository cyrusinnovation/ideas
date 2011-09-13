require 'test_helper'

class BurnRateControllerTest < ActionController::TestCase
  test "shows all stories where burn rate is known in reverse order finished" do
    @current_user.stories.build(:title => "should appear", :estimate => 1, :hours_worked => 4, :finished => '2011-1-11').save
    @current_user.stories.build(:title => "no estimate", :hours_worked => 4, :finished => '2011-1-12').save
    @current_user.stories.build(:title => "no hours", :estimate => 1, :finished => '2011-1-13').save
    @current_user.stories.build(:title => "should appear first", :estimate => 3, :hours_worked => 17, :finished => '2011-1-14').save

    get :index

    assert_equal ["should appear first", "should appear"], assigns(:stories).map {|s| s.title }
  end
end

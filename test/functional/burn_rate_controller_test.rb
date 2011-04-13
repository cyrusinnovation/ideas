require 'test_helper'

class BurnRateControllerTest < ActionController::TestCase
  test "shows all stories where burn rate is known in reverse order finished" do
    Story.new(:title => "should appear", :estimate => 1, :hours_worked => 4, :finished => '2011-1-11').save
    Story.new(:title => "no estimate", :hours_worked => 4, :finished => '2011-1-12').save
    Story.new(:title => "no hours", :estimate => 1, :finished => '2011-1-13').save
    Story.new(:title => "should appear first", :estimate => 3, :hours_worked => 17, :finished => '2011-1-14').save

    get :index

    assert_equal ["should appear first", "should appear"], assigns(:stories).map {|s| s.title }
  end
end

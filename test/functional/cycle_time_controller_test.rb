require 'test_helper'

class CycleTimeControllerTest < ActionController::TestCase
  test "shows all stories where cycle time is known in reverse order finished" do
    Story.delete_all # TODO Having to do this seems like a sign that fixtures suck. Which they do.
    Story.new(:title => "should appear", :started => '2011-1-1', :finished => '2011-1-11').save
    Story.new(:title => "unknown start date", :finished => '2011-1-12').save
    Story.new(:title => "unknown end date", :started => '2011-1-13').save
    Story.new(:title => "should appear first", :started => '2010-12-25', :finished => '2011-1-14').save

    get :index

    assert_equal ["should appear first", "should appear"], assigns(:stories).map {|s| s.title }
  end
end

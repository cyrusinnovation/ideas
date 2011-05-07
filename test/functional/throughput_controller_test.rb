require 'test_helper'

class ThroughputControllerTest < ActionController::TestCase
  test "show from today back to three weeks after the first story finished" do
    Story.delete_all
    Story.new(:title => 'newest', :started => '2011-4-1', :finished => '2011-4-11').save
    Story.new(:title => 'oldest', :started => '2011-1-20', :finished => '2011-2-1').save
    Story.new(:title => 'middle', :started => '2011-3-10', :finished => '2011-3-12').save

    get :index

    history = assigns(:throughput_history)

    assert_equal Date.today, history[0].date, "first"
    assert_equal Date.new(2011, 2, 21), history[-1].date, "last"
  end
end

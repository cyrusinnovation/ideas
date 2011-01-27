require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  fixtures :stories

  test "add a story" do
    post :create, :story => {
        :title => "147 - Improve flying UI",
        :team => "Turtle",
        :estimate => 5,
        :started => "2011-2-12",
        :finished => "2011-2-21"
    }

    assert_not_nil Story.find_by_title("147 - Improve flying UI")
    assert_redirected_to :action => "index"
  end

  test "delete a story" do
    id = stories(:fly).id
    delete :destroy, :id => id
    assert "should have been deleted", !Story.exists?(id)
    assert_redirected_to :action => "index"
  end
end

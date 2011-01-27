require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  test "add a story" do
    post :create, :story => {
        :title => "147 - Improve flying UI",
        :team => "Turtle",
        :estimate => 5,
        :started => "2011-2-12",
        :finished => "2011-2-21"
    }

    assert_redirected_to :action => "index"
    assert_not_nil Story.find_by_title("147 - Improve flying UI")
  end
end

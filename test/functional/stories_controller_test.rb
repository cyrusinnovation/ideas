require 'test_helper'
require 'import'

class StoriesControllerTest < ActionController::TestCase
  fixtures :stories

  test "add a story" do
    post :create, :story => {
        :title => "147 - Improve flying UI",
        :estimate => 5,
        :finished => "2011-2-21",
        :hours_worked => 102.25
    }

    assert_not_nil @current_user.stories.find_by_title("147 - Improve flying UI")
    assert_redirected_to :action => "index"
  end

  test "delete a story" do
    id = stories(:fly).id
    delete :destroy, :id => id
    assert !@current_user.stories.exists?(id), "should have been deleted"
    assert_redirected_to :action => "index"
  end
end

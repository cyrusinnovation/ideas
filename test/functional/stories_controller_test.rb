require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  test "add a story" do
    post :create, :story => {
        :title => "147 - Improve flying UI"
    }, :project_id => Project.first

    project = Project.first
    assert_not_nil project.stories.find_by_title("147 - Improve flying UI")
    assert_redirected_to :action => "index"
  end
end

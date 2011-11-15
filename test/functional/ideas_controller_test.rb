require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  test "add a idea" do
    post :create, :idea => {
        :title => "147 - Improve flying UI"
    }, :project_id => Project.first

    project = Project.first
    assert_not_nil project.ideas.find_by_title("147 - Improve flying UI")
    assert_redirected_to :action => "index"
  end
end

require 'test_helper'
require 'import'

class StoriesControllerTest < ActionController::TestCase
  test "add a story" do
    post :create, :story => {
        :title => "147 - Improve flying UI",
        :estimate => 5,
        :finished => "2011-2-21",
        :hours_worked => 102.25
    }, :project_id => Project.first

    project = Project.first
    assert_not_nil project.stories.find_by_title("147 - Improve flying UI")
    assert_redirected_to :action => "index"
  end

  test "delete a story" do
    project = Project.first
    id = stories(:fly).id

    delete :destroy, :id => id, :project_id => project.id
    assert !project.stories.exists?(id), "should have been deleted"
    assert_redirected_to :action => "index"
  end
end

require 'test_helper'

class TrendsControllerTest < ActionController::TestCase
  test "shows all stories where burn rate is known in reverse order finished" do
    project = Project.first
    project.stories.create(:title => "should appear", :estimate => 1, :hours_worked => 4, :finished => '2011-1-11')
    project.stories.create(:title => "no estimate", :hours_worked => 4, :finished => '2011-1-12')
    project.stories.create(:title => "no hours", :estimate => 1, :finished => '2011-1-13')
    project.stories.create(:title => "should appear first", :estimate => 3, :hours_worked => 17, :finished => '2011-1-14')

    get :index, :project_id => project.id

    assert_response :success
  end
end

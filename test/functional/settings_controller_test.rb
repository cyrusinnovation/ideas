require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  test "should get edit" do
    get(:edit, {:project_id => Project.first })
    assert_response :success
  end

end

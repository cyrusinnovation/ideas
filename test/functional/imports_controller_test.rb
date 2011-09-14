require 'test_helper'
require 'import'

class ImportsControllerTest < ActionController::TestCase
  test "import stories from a CSV file" do
    file = fixture_file_upload 'files/import_csv.txt', 'text/plain'

    post :create, :file => file

    assert_equal 5, Story.count, "Should clear stories from DB and import the 5 new ones"
  end
end

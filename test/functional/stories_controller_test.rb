require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  fixtures :stories

  test "orders the stories by date started with unstarted at the top" do
    Story.new(:title => 'newest', :started => "2015-1-1").save
    Story.new(:title => 'oldest', :started => "2009-1-1").save
    Story.new(:title => 'blank', :started => nil).save

    get :index

    stories = assigns(:stories)
    assert_equal 'blank', stories[0].title
    assert_equal 'newest', stories[1].title
    assert_equal 'oldest', stories.last.title
  end

  test "add a story" do
    post :create, :story => {
        :title => "147 - Improve flying UI",
        :team_name => "Turtle",
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

  test "import stories from a CSV file" do
    file = fixture_file_upload 'files/import.csv', 'text/plain'

    post :import, :file => file

    assert_equal 5, Story.count, "Should clear stories from DB and import the 5 new ones"
  end
end

require 'test_helper'
require 'import'

class StoriesControllerTest < ActionController::TestCase
  fixtures :stories

  test "orders the stories by date started with unstarted at the top" do
    @current_user.stories.build(:title => 'newest', :started => "2015-1-1").save
    @current_user.stories.build(:title => 'oldest', :started => "2009-1-1").save
    @current_user.stories.build(:title => 'blank', :started => nil).save

    get :index

    stories = assigns(:stories)
    assert_equal 'blank', stories[0].title
    assert_equal 'newest', stories[1].title
    assert_equal 'oldest', stories.last.title
  end

  test "add a story" do
    post :create, :story => {
        :title => "147 - Improve flying UI",
        :estimate => 5,
        :started => "2011-2-12",
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

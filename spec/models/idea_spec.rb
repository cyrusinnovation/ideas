require 'spec_helper'

describe Idea do

  before(:each) do 
    @project = Project.create :name => 'Test'
    @user = User.create :email => 'mama@dada.com', :password => 'password'

  end

  it "can be created" do
    idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
  end

  it "does not die when trying to get a rating for a user with no ratings" do
    idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    idea.get_rating_for_user(@user).should == 0
  end

  it "can get a rating for a user" do
    idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    Rating.create :user => @user, :idea => idea, :rating => 3

    idea.get_rating_for_user(@user).should == 3
  end

end

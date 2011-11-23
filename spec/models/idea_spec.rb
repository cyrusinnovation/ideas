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

  it "can get an average rating" do
    idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    user2 = User.create :email => 'mama2@dada.com', :password => 'password'
    Rating.create :user => @user, :idea => idea, :rating => 3
    Rating.create :user => user2, :idea => idea, :rating => 1

    idea.average_rating.should == 2
  end

  it "can get an average rating with zero ratings" do
    idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'

    idea.average_rating.should == 0
  end

  it "can get an average rating round up" do
    idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    user2 = User.create :email => 'mama2@dada.com', :password => 'password'
    user3 = User.create :email => 'mama3@dada.com', :password => 'password'
    Rating.create :user => @user, :idea => idea, :rating => 3
    Rating.create :user => user2, :idea => idea, :rating => 1
    Rating.create :user => user3, :idea => idea, :rating => 1

    idea.average_rating.should == 2
  end

  it "can get an average rating round down" do
    idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    user2 = User.create :email => 'mama2@dada.com', :password => 'password'
    user3 = User.create :email => 'mama3@dada.com', :password => 'password'
    Rating.create :user => @user, :idea => idea, :rating => 2
    Rating.create :user => user2, :idea => idea, :rating => 1
    Rating.create :user => user3, :idea => idea, :rating => 1

    idea.average_rating.should == 1
  end

end

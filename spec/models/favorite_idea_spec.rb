require 'spec_helper'

describe FavoriteIdea do

  before(:each) do 
    @project = Project.create :name => 'Test'
    @user = User.create :email => 'mama@dada.com', :password => 'password'
    @idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
  end

  it "has many works" do
    FavoriteIdea.create :user => @user, :idea => @idea
    @user.favorites.size.should == 1
  end

end

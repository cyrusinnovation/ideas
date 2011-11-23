require 'spec_helper'

describe Rating do

  before(:each) do 
    @project = Project.create :name => 'Test'
    @user = User.create :email => 'mama@dada.com', :password => 'password'
    @idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
  end

  it "has many works" do
    Rating.create :user => @user, :idea => @idea, :rating => 3
    @idea.ratings.size.should == 1
  end

end

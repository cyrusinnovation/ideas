require 'spec_helper'

describe Idea do

  before(:each) do 
    @project = Project.create :name => 'Test'
    @user = User.create :email => 'mama@dada.com', :password => 'password'

  end

  it "can be created" do
    @idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
  end

end

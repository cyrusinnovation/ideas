require 'spec_helper'

describe Category do
  it "can be created" do
    Category.create :name => 'Problem'
  end

  it "has many ideas" do
    category = Category.create :name => 'Problem'
    @idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title', :category => category
    @idea = Idea.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title', :category => category
    category.ideas.size.should == 2
  end

end

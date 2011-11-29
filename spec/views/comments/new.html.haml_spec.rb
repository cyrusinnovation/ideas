require 'spec_helper'

describe "comments/new.html.haml" do
  before(:each) do
    @project = Project.create :name => 'Test'
    @idea = @project.ideas.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    @user = User.create :email => 'mama@dada.com', :password => 'password'

    assign(:comment, stub_model(Comment,
      :text => "MyText",
      :user => @user,
      :idea => @idea
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    assert_select "form", :action => project_idea_comments_path(@project, @idea), :method => "post" do
      assert_select "textarea#comment_text", :name => "comment[text]"
    end
  end
end

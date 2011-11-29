require 'spec_helper'

describe "comments/index.html.haml" do
  before(:each) do
    @project = Project.create :name => 'Test'
    @idea = @project.ideas.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    @user = User.create :email => 'mama@dada.com', :password => 'password'

    assign(:comments, [
      stub_model(Comment,
        :text => "MyText",
        :user => @user,
        :idea => @idea,
        :created_at => Time.now - 1.hour
      ),
      stub_model(Comment,
        :text => "MyText",
        :user => @user,
        :idea => @idea,
        :created_at => Time.now - 1.hour
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "blockquote .text", :text => "MyText".to_s, :count => 2
    assert_select "blockquote>small", :text => /#{@user.email}/, :count => 2
  end
end

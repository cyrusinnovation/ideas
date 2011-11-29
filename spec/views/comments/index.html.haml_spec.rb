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
        :idea => @idea
      ),
      stub_model(Comment,
        :text => "MyText",
        :user => @user,
        :idea => @idea
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => @user.email, :count => 2
  end
end

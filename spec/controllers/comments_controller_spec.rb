require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CommentsController do
  login_user
  
  def valid_attributes
    {:text => 'My comment!!!', :user => @user, :idea => @idea}
  end

  describe "GET index" do
    it "assigns all comments as @comments" do
      comment = Comment.create! valid_attributes
      get :index, :project_id => @project, :idea_id => @idea
      assigns(:comments).should eq([comment])
    end
  end

  describe "GET new" do
    it "assigns a new comment as @comment" do
      get :new, :project_id => @project, :idea_id => @idea
      assigns(:comment).should be_a_new(Comment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, :comment => valid_attributes, :project_id => @project, :idea_id => @idea
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, :comment => valid_attributes, :project_id => @project, :idea_id => @idea
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it "redirects to the created comment" do
        post :create, :comment => valid_attributes, :project_id => @project, :idea_id => @idea
        response.should redirect_to(project_idea_comments_path(@project, @idea))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {}, :project_id => @project, :idea_id => @idea
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {}, :project_id => @project, :idea_id => @idea
        response.should render_template("new")
      end
    end
  end

end

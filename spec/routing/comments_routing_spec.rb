require "spec_helper"

describe CommentsController do
  describe "routing" do
    it "routes to #index" do
      get("/projects/1/ideas/1/comments").should route_to(:controller => 'comments', :action => 'index', :project_id => "1", :idea_id => "1")
    end

    it "routes to #new" do
      get("/projects/1/ideas/1/comments/new").should route_to(:controller => 'comments', :action => 'new', :project_id => "1", :idea_id => "1")
    end

    it "routes to #create" do
      post("/projects/1/ideas/1/comments").should route_to(:controller => 'comments', :action => 'create', :project_id => "1", :idea_id => "1")
    end
  end
end

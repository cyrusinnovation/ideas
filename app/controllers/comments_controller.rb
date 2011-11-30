class CommentsController < ApplicationController
  def index
    @project = current_project
    @idea = @project.ideas.find(params[:idea_id])
    @comments = @idea.comments.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  def new
    @project = current_project
    @idea = @project.ideas.find(params[:idea_id])
    @comment = @idea.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  def create
    @project = current_project
    @idea = @project.ideas.find(params[:idea_id])
    @comment = @idea.comments.build(:text => params[:comment][:text], :user => current_user)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_idea_comments_path(@project, @idea), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

end

class MembershipsController < SecureController
  def index
    @memberships = current_project.memberships
    @membership = current_project.memberships.build
  end

  def create
    email = params[:membership][:user]
    user = User.find_by_email email
    @membership = Membership.new(:user=> user, :project=> current_project, :collapsed => false)
    
    if @membership.save
      redirect_to :back, :notice => 'Membership was successfully created.'
    else
      redirect_to :back, :alert => "Sorry, couldn't find a user with #{email} as their email address"
    end
  end
  
  def destroy
    membership = Membership.find(params[:id])
    if current_user == membership.user
      redirect_to projects_path
    else
      redirect_to :back, :notice => "User with #{membership.user.email} successfully removed"
    end

    membership.destroy
  end

  def update
    membership = Membership.where(:project_id => params[:project_id], :user_id => current_user).first
    puts membership
    membership.collapsed = params[:collapsed]
    membership.save
    respond_to do |format|
      format.json { render :json => {} }
      format.html { redirect_to :controller => :projects, :action => :index }
    end
  end
end

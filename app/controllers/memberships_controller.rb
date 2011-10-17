class MembershipsController < SecureController
  def index
    @memberships = current_project.memberships
    @membership = current_project.memberships.build
  end

  def create
    email = params[:membership][:user]
    user = User.find_by_email email
    @membership = Membership.new(user: user, project: current_project)
    
    if @membership.save
      redirect_to project_memberships_path(current_project), notice: 'Membership was successfully created.'
    else
      redirect_to project_memberships_path(current_project), alert: "Sorry, couldn't find a user with #{email} as their email address"
    end
  end
  
  def destroy
    membership = Membership.find(params[:id])
    if current_user == membership.user
      redirect_to projects_path
    else
      redirect_to project_memberships_path(current_project)
    end

    membership.destroy
 end
end

class MembershipsController < SecureController
  def index
    @memberships = current_project.memberships
  end

  def new
    @membership = Membership.new
  end

  
  def create
    user = User.find_by_email params[:membership][:user]
    @membership = current_project.memberships.create(:user => user)

    if @membership.persisted?
      redirect_to project_memberships_path(current_project), notice: 'Membership was successfully created.'
    else
      render action: "new"
    end
  end
  
  def destroy
    membership = Membership.find(params[:id])
    if current_user == membership.user
      redirect_to projects_path
    else
      redirect_to project_memberships_url(current_project)
    end

    membership.destroy
 end
end

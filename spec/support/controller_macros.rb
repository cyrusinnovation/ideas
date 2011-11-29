module ControllerMacros
  def login_user
    before(:each) do
      @project = Project.create :name => 'Test'
      @user = User.create :email => 'mama@dada.com', :password => 'password'
      Membership.create :user => @user, :project => @project

      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user

      @idea = @project.ideas.create :created_by => 'mama@dada.com', :description => 'description', :title => 'title'
    end
  end
end

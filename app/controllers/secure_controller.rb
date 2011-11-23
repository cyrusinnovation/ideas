require_dependency 'current_project'

class SecureController < ActionController::Base
  include CurrentProject
  before_filter do
    authenticate_user! rescue redirect_to root_path
  end
  
  layout "application"

  helper_method :current_project
end

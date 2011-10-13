require_dependency 'current_project'

class SecureController < ActionController::Base
  include CurrentProject
  before_filter :authenticate_user!
  
  layout "application"

  helper_method :current_project
end

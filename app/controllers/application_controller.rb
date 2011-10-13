require_dependency 'current_project'

class ApplicationController < ActionController::Base
  include CurrentProject
  protect_from_forgery

  layout "application"
end

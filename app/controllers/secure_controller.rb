class SecureController < ActionController::Base
  before_filter :authenticate_user!
end

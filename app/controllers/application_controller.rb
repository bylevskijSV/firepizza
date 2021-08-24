class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include ApplicationHelper
  before_action :create_session_cart

  
end

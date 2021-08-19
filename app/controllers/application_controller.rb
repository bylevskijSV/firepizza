class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :create_session_cart

  def create_session_cart
    session[:cart] ||= []
  end
end

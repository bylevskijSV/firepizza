class ApplicationController < ActionController::Base
  include ErrorHandling
  include ApplicationHelper
  before_action :create_session_cart

  private

  def create_session_cart
    session[:cart] ||= []
  end
end

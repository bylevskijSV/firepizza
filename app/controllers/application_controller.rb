class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include ApplicationHelper
  before_action :create_session_cart

  private

  def create_session_cart
    session[:cart] ||= []
  end
end

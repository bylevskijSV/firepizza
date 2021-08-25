# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include ApplicationHelper
  before_action :create_session_cart

  def create_session_cart
    session[:cart] ||= []
  end
end

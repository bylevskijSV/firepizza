class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[destroy]
  def new
  end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sing_in user
      remember(user) if params[:remebmer_me] == '1'
      redirect_to menu_index_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to menu_index_path
  end
end
class RegistrationsController < ApplicationController
  skip_before_action :authenticated?
  before_action :redirect_when_authenticated, except: :destroy

  def new; end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def redirect_when_authenticated
    if current_user
      redirect_to root_path
    end
  end
end

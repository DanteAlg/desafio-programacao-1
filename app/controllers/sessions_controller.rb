class SessionsController < ApplicationController
  skip_before_action :authenticated?
  before_action :redirect_when_authenticated, except: :destroy

  def new
  end

  def create
    user = User.find_by(email: user_params[:email])

    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
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

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Invalid credentials. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session.destroy
    flash[:success] = "You have logged out."
    redirect_to root_path
  end
end
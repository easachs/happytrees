# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # user_params[:username] = user_params[:username].downcase
    # user_params[:email] = user_params[:email].downcase
    user = User.new(user_params)
    if user.save
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to user_path(user)
    else
      flash[:error] = 'Invalid. Please try again.'
      redirect_to '/register'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

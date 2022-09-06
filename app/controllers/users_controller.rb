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
      flash[:error] = user.errors.full_messages.uniq * ', '
      redirect_to register_path
    end
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      # session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to user_path(user)
    else
      flash[:error] = 'Invalid credentials. Please try again.'
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

require 'pry'
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if !session[:user_id]
      redirect_to "/"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:admin] == 1
      @user.admin = true
    end
    if @user.save
      redirect_to user_path(@user)
      session[:user_id] = @user.id
    else
      redirect_to users_path
    end
  end

  def signin

  end

  def new_session
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to "/signin"
    end
  end

  def logout
    session.clear
    redirect_to "/"
  end



  private

  def user_params
    params.require(:user).permit(:name, :password, :height, :tickets, :happiness, :nausea, :admin)
  end
end
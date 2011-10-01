class UsersController < ApplicationController

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up and logged in!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

end

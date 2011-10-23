class UsersController < ApplicationController
  before_filter :authenticate,  :only => [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user,  :only => [:edit, :update]
  before_filter :admin_user,    :only => [:destroy]

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Signed up and logged in!"
      redirect_to root_url
    else
      render "new"
    end
  end

  def index
    @title = "All users"
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def edit
    @title = "Edit user"
  end

  def update
    params[:user][:password] = params[:user][:new_password]

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render "edit"
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

private

  def authenticate
    deny_access unless current_user
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end

module SessionsHelper

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

  def current_user?(user)
    user == current_user
  end

  def deny_access
    store_location
    redirect_to login_path, :notice => "Please sign in to access this page"
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

private

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end

end

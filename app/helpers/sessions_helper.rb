module SessionsHelper

  def current_user?(user)
    user == current_user
  end

  def deny_access
    redirect_to login_path, :notice => "Please sign in to access this page"
  end

end

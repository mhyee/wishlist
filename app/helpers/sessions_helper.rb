module SessionsHelper

  def deny_access
    redirect_to login_path, :notice => "Please sign in to access this page"
  end

end

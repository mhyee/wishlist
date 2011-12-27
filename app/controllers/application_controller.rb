class ApplicationController < ActionController::Base
  before_filter :authenticate! if Rails.env.production?

  protect_from_forgery
  include SessionsHelper

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate!
    authenticate_or_request_with_http_basic do |username, password|
      username == ConfigSecrets[:username] && password == ConfigSecrets[:password]
    end
  end

  helper_method :current_user
end

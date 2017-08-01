class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    if session[:user]
      @current_user ||= User.find_by_id(session[:user])
    end
  end
end

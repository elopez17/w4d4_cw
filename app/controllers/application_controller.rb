class ApplicationController < ActionController::Base
  helper_method :login!, :current_user, :logged_in?

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    return nil unless session[:session_token]
    @current_user = User.find_by(session_token: session[:session_token])
  end

  def logout!
    user = current_user
    if user
      user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end

  def logged_in?
    !!current_user
  end
end

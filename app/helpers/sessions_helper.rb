module SessionsHelper
  def current_user
    return nil unless session_token
    @current_user ||= User.find_by_session_token(session_token)
  end

  def login!(user)
    self.session_token = user.reset_session_token!
  end

  def logged_in?
    current_user.present?
  end

  def log_out!
    current_user.reset_session_token!
    self.session_token = nil
  end

  def session_token
    session[:session_token]
  end

  def session_token=(token)
    session[:session_token] = token
  end
end
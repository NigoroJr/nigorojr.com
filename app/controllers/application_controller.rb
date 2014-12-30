class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Captcha
  include SimpleCaptcha::ControllerHelpers

  before_filter :authorize

  class Forbidden < StandardError
  end

  private
  def authorize
    if session[:user_id]
      @logged_in_as = User.find_by_id(session[:user_id])
      # Cancel if can't find ID
      session.delete(session[:user_id]) unless @logged_in_as
    end
  end

  def login_required
    raise Forbidden unless @logged_in_as
  end
end

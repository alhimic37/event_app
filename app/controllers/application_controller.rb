class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
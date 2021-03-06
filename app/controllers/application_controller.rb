class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # got these tips from
  # http://lyconic.com/blog/2010/08/03/dry-up-your-ajax-code-with-the-jquery-rest-plugin
  before_action :correct_safari_and_ie_accept_headers
  after_action :set_xhr_flash

def set_xhr_flash
  flash.discard if request.xhr?
end

def correct_safari_and_ie_accept_headers
  ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
  request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
end
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end

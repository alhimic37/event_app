class CalendarController < ApplicationController
  include SessionsHelper
  
  def index
    @event = current_user.events.build if signed_in?
    
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Event.event_strips_for_month(@shown_month)
  end
  
end

class CalendarController < ApplicationController

  def index
    js eventsSource: events_path 
  end
end
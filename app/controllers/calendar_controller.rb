class CalendarController < ApplicationController
  include SessionsHelper 
  def index
    respond_to do |format|
      format.html
      format.js {render json: current_user}
    end
    
  end
end
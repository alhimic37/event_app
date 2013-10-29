class CalendarController < ApplicationController

  def index
    respond_to do |format|
      format.html
      #format.js {render json: current_user}
    end
    
  end
end
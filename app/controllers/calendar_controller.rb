class CalendarController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.js {render color: 'violet'}
    end
    
  end
end
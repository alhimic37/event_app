class EventsController < ApplicationController
  include SessionsHelper
  before_filter :signed_in_user
  
  def new
    @event = current_user.events.build
  end
  
  def show
      @event = current_user.events.find(params[:id]);
  end
  
  def create
    @event = current_user.events.build(event_params)
       
       if @event.save
           flash.now[:notice] = "Event created."
       else
           render :new
       end
  end
  
  def edit
    @event = current_user.events.find(params[:id])
  end
  
  def update
    @event = current_user.events.find(params[:id]);
    if @event.update_attributes(event_params)
        flash.now[:notice] = "Event updated."
    else
        render :edit 
    end
  end

  def destroy
    @event = current_user.events.find(params[:id]);
    @event.destroy
    flash.now[:notice] = "Event destroyed."
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end
  
end

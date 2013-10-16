class EventsController < ApplicationController
  def new
  end
  
  def new
      @event = Event.new
  end
  
  def show
      @event = Event.find(params[:id]);
  end
  
  def edit
      @event = Event.find(params[:id]);
  end
  
  def create
       @event = Event.new(event_params)
       
       if @event.save
           flash.now[:notice] = "Event created."
       else
           render :new
       end
  end
  

  def update
    @event = Event.find(params[:id]);
    if @event.update_attributes(event_params)
        flash.now[:notice] = "Event updated."
    else
        render :edit 
    end
  end

  def destroy
    @event = Event.find(params[:id]);
    @event.destroy
    flash.now[:notice] = "Event destroyed."
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end
  
end

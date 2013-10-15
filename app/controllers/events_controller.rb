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
       render :new unless @event.save
  end
  

  def update
    @event = Event.find(params[:id]);
    render :edit unless @event.update_attributes(event_params)
  end

  def destroy
    @event = Event.find(params[:id]);
    @event.destroy
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end
  
end

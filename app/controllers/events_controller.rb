class EventsController < ApplicationController

  before_action :signed_in_user, :except=>[:index]
  before_action :set_timezone
  def set_timezone
    Time.zone = 'UTC'
    if signed_in?
      Time.zone = current_user.time_zone
    end
  end
  
  def index
     # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day
    #TODO: refactoring
    if signed_in?
      @non_user_events = Event.where.not('user_id = ?', current_user.id)
      @non_user_events = @non_user_events.after(params['start']) if (params['start'])
      @non_user_events = @non_user_events.before(params['end']) if (params['end'])
     
      @user_events = current_user.events
      @user_events = @user_events.after(params['start']) if (params['start'])
      @user_events = @user_events.before(params['end']) if (params['end'])
    
      @user_events.map!{|x|
        hash = JSON.parse(x.to_json)
        #color of user's events
        hash['color'] = 'red'
        x = hash.as_json
      }

      @events = @non_user_events + @user_events
    else
      @events = Event.all
      @events = @events.after(params['start']) if (params['start'])
      @events = @events.before(params['end']) if (params['end'])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events }
      format.js { render :json => @events }
    end
  end
  
  def new
    @event = current_user.events.build
   
    @event.start_at = Time.zone.parse(params[:date]).utc
    @event.end_at =  Time.zone.parse(params[:date]).utc
  end
  
  def show
    @event = current_user.events.find_by(id: params[:id]) || Event.find(params[:id])
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
    params.require(:event).permit(:title, :desctiption, :start_at, :end_at)
  end
  
end

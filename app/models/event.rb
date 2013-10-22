class Event < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  default_scope {order('created_at DESC')}
  scope :before, -> (end_time) {where("end_at < ?", Event.format_date(end_time))}
  scope :after, -> (start_time) {where("start_at > ?", Event.format_date(start_time))}
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => self.start_at.rfc822,
      :end => self.end_at.rfc822,
      :allDay => self.all_day,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
    
  end
  

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
  private
  def event_params
    params.require(:event).permit(:title, :description, :start_at, :end_at)
  end
end

class Event < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  before_save :set_time_if_all_day
  
  default_scope {order('created_at DESC')}
  scope :before, -> (end_time) {where("end_at < ?", Event.format_date(end_time))}
  scope :after, -> (start_time) {where("start_at > ?", Event.format_date(start_time))}
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :start_at, presence: true
  validates :end_at, presence: false
  
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => self.start_at.rfc822,
      :end => self.end_at.rfc822,
      :allDay => self.all_day,
      :url => Rails.application.routes.url_helpers.event_path(id),
      :editable => false #by default
    }  
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
  private
  def event_params
    params.require(:event).permit(:title, :description, :start_at, :end_at, :all_day)
  end
  
  def set_time_if_all_day
    if self.all_day
      self.start_at = self.start_at.change({:hour => 0 , :min => 0 , :sec => 0 })
      self.end_at = self.end_at.change({:hour => 0 , :min => 0 , :sec => 0 })
    end
  end
end

class Event < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  belongs_to :user
  
  has_event_calendar
  
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  
  #default_scope order: 'events.start_at DESC'
  
  private
  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end
end

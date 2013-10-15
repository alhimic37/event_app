class Event < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_event_calendar
  
  validates :name, presence: true, length: { maximum: 50 }
  
  private
  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end
end

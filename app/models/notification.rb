class Notification < ActiveRecord::Base
  # Model Relationships
  # ===================
  belongs_to :event
  belongs_to :user, foreign_key: :target
  validate :check_event_id, on: [:create]
  validate :check_duplicate, on: [:create]
  
  def check_event_id
    logger.info "event: " + event.inspect
    logger.info "event_id: " + event_id.inspect
    if !Event.exists?(event.try(:id))
      errors.add(:event_id, "event not found")
    end
  end
  
  def check_duplicate
    if !Notification.where(event_id: event, target: target).empty?
      errors.add(:event_id, "invitation already created")
    end
  end
end

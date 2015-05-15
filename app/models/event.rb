class Event < ActiveRecord::Base
  validates :activity, presence: true
  validates :location, presence: true
  validates :host, presence: true
  validate :is_valid_datetime
  
  private
    def is_valid_datetime
      if datetime.present? && datetime < DateTime.now
        errors.add(:datetime, "cannot be in the past")
      end
    end
end

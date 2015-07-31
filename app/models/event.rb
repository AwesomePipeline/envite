class Event < ActiveRecord::Base
  before_save :set_uuid
  
  # Non-integer primary key
  self.primary_key = :id
  
  # Model Relationships
  # ===================
  belongs_to :user, :foreign_key => :host
  
  # Validation Rules
  # ================
  validates :activity, presence: true
  validates :datetime, presence: true
  validates :location, presence: true
  validate :is_valid_datetime
  
  def invited
    invited = Notification.where(event: self)
    User.find(invited.pluck(:id))
  end
  
  def accepted
    accepted = Notification.where(event: self, has_accepted: true)
    User.find(accepted.pluck(:id))
  end
  
  private
  
  def set_uuid
    self.id ||= SecureRandom.hex(24)
  end
  
  # Custom Validation
  # =================
  def is_valid_datetime
    if datetime.present? && datetime < DateTime.now
      errors.add(:datetime, "cannot be in the past")
    end
  end
end

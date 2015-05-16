class Event < ActiveRecord::Base
  # Model Relationships
  # ===================
  belongs_to :user, :foreign_key => :host, required: true
  
  # Validation Rules
  # ================
  validates :activity, presence: true
  validates :location, presence: true
  validates :host, presence: true
  validate :is_valid_datetime
  
  private
    # Custom Validation
    # =================
    def is_valid_datetime
      if datetime.present? && datetime < DateTime.now
        errors.add(:datetime, "cannot be in the past")
      end
    end
end

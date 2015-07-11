class Event < ActiveRecord::Base
  # Model Relationships
  # ===================
  belongs_to :user, :foreign_key => :host
  
  # Validation Rules
  # ================
  validates :activity, presence: true
  validates :datetime, presence: true
  validates :location, presence: true
  validates :host, presence: true
  validate :is_valid_datetime
  validate :is_valid_host
  
  def invited
    invited = Notification.where(event: self)
    User.find(invited.pluck(:id))
  end
  
  def accepted
    accepted = Notification.where(event: self, has_accepted: true)
    User.find(accepted.pluck(:id))
  end
  
  private
    # Custom Validation
    # =================
    def is_valid_datetime
      if datetime.present? && datetime < DateTime.now
        errors.add(:datetime, "cannot be in the past")
      end
    end
    
    def is_valid_host
      begin
        User.find(host)
      rescue ActiveRecord::RecordNotFound
        errors.add(:host, "does not exist")
      end
    end
end

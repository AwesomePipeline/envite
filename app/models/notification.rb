class Notification < ActiveRecord::Base
  # Model Relationships
  # ===================
  belongs_to :event
  belongs_to :user, foreign_key: :target
end

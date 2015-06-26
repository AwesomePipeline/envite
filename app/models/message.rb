class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  validates :message, presence: true
end

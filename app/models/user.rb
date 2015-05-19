# User model containing the following columns:
# fullname (string)
# handle (string, unique, 6-12 length)
# email (string, unique, valid_email)

class User < ActiveRecord::Base
  # Model Relationships
  # ===================
  has_many :events, :foreign_key => :host
    
  # Validation Rules
  # ================
  validates :fullname, presence: true
  validates :handle, presence: true,  uniqueness: true,
   length: {within: 6..12}
  
  # Validating the email address with a regex
  # TODO: More robust email validator?
  validates :email, presence: true, uniqueness: true,
    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
end

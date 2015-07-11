class User < ActiveRecord::Base
  # Ensure User has auth token
  before_save :ensure_auth_token
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Model Relationships
  # ===================
  has_many :events, foreign_key: :host
  has_many :notifications, foreign_key: :target
    
  # Validation Rules
  # ================
  validates :fullname, presence: true
  validates :handle, presence: true,  uniqueness: true,
   length: {within: 5..12}
  
  # Validating the email address with a regex
  # TODO: More robust email validator?
  validates :email, presence: true, uniqueness: true,
    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  
  def ensure_auth_token
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end
  
  def new_token
    self.auth_token = generate_auth_token
    self.save!
    logger.info "New token: " + self.auth_token
  end
  
  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end
end

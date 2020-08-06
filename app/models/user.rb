class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :send_otp
  validates :mobile_number, uniqueness: true, allow_nil: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: true,
            allow_blank: true

  def send_otp
    self.otp = rand.to_s[2..7]
  end   
end

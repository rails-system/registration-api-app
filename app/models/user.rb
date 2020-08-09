class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_secure_password
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :send_otp
  validates :mobile_number, uniqueness: true, allow_nil: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true,
            allow_blank: true

  def send_otp
    self.verify_otp = rand.to_s[2..7]
  end

  def self.added_temp_email(user,params)
    binding.pry
  	user.email = Faker::Internet.email rescue nil
  end
end

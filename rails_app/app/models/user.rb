class User < ApplicationRecord
  before_save { email.downcase! }
  has_secure_password
  validates :name,  presence: true, length: { minimum: 5,maximum: 30 }
  validates :user_name, presence: true, length: { minimum: 5,maximum: 30 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: true
  validates :comment,length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end

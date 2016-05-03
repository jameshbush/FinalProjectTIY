class User < ActiveRecord::Base

  has_secure_password
  validates :password_digest, presence: true
  validates :password, presence: true,
                       length: { minimum: 6 }

  EMAIL_REGEX =/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_validation { self.email.downcase! }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_REGEX }
end

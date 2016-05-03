class User < ActiveRecord::Base

  # password
  has_secure_password
  validates :password_digest, presence: true
  validates :password, presence: true,
                       length: { minimum: 6 }
  # email
  EMAIL_REGEX =/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_validation { self.email.downcase! }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_REGEX }
  # phone
  before_validation { self.contact_pref.downcase! }
  before_validation :format_phone

  private

  def format_phone
    self.phone = phone.gsub(/\D/, '')
  end
end

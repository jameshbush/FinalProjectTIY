class User < ActiveRecord::Base
  has_many :journeys
  has_many :quests, through: :journeys

  has_secure_password
  validates :password_digest, presence: true
  validates :password, presence: true,
                       length: { minimum: 6 }

  EMAIL_REGEX =/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_validation { self.email.downcase! }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_REGEX }

  before_save { self.contact_pref.downcase! }
  validates :contact_pref, presence: true

  before_validation :format_phone, :format_name
  validates :name, format: { without: /\s/ }

  def current_journey
    self.journeys.where(current: true).first
  end

  private

  def format_phone
    self.phone = phone.gsub(/\D/, '')
  end

  def format_name
    self.name.downcase!
  end
end

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

  def self.has_current_journey
    joins(:journeys).where("journeys.current = ?", true)
  end

  def self.prefer_phone
    where(contact_pref: "phone")
  end

  def self.prefer_email
    where(contact_pref: "email")
  end

  scope :prefer_phone_scope, -> { where(contact_pref: "phone") }
  scope :prefer_email_scope, -> { where(contact_pref: "email")}

  def current_journey
    possible = self.journeys.where(current: true).first
    if possible.nil? && self.journeys != []
      self.journeys.last.current = true
      self.journeys.last.save
    else
      possible
    end
  end

  def report_due?
    !current_journey.reports.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def has_current_journey?
    journeys.select { |j| j.current == "true" }.count > 0
  end

  private

  def format_phone
    self.phone = phone.gsub(/\D/, '')
  end

  def format_name
    self.name.downcase!
  end
end

class User < ActiveRecord::Base
  has_many :journeys, dependent: :destroy
  has_many :quests, through: :journeys
  before_create :confirmation_token

  # Password
  has_secure_password
  validates :password_digest, presence: true
  validates :password, presence: true,
                       allow_nil: true,
                       length: { minimum: 6 }

  # Email
  EMAIL_REGEX =/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_validation { self.email.downcase! }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_REGEX }
  validates :confirm_token, uniqueness: true, unless: -> { confirm_token.nil? }

  # Phone
  before_validation :format_cellphone
  validates :cellphone, uniqueness: :true, unless: -> { cellphone.blank? }

  # Contact Preference
  validates :contact_pref, presence: true
  before_save do
    self.contact_pref.downcase!
    self.phone_verified = false if(self.cellphone_changed? || self.cellphone.blank?)
    self.email_verified = false if(self.email_changed?)
    true
  end

  # Name
  before_validation :format_name
  validates :name, format: { without: /\s/ }

  # User Methods
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
  scope :prefer_email_scope, -> { where(contact_pref: "email") }

  def find_current_journey
    possible = self.journeys.where(current: true).first
    if possible.nil? && self.journeys.any?
      self.journeys.last.update_attribute(:current, true)
      possible = self.journeys.where(current: true).first
    end
    possible
  end

  def current_journey
    @possible ||= find_current_journey
  end

  def new_journey
    reset_journeys
    set_journey
  end

  def reset_journeys
    journeys.each { |j| j.update_attribute(:current, false) }
  end

  def set_journey
    journeys.last.update_attribute(:current, true)
  end

  def current_report
    @current_report ||= current_journey.reports.find_or_initialize_by(
      created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def grail
    current_journey.quest.grail if current_journey
  end

  def active_report
    current_journey.reports.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def report_due?
    !active_report
  end

  def photo_due?
    current_report.image.nil?
  end

  def has_current_journey?
    journeys.select { |j| j.current == true }.any?
  end

  def unamericanized_cell
    cellphone.gsub("+1", "") if self.cellphone
  end

  def email_activate
    self.email_verified = true
    self.confirm_token = nil
    save! validate: false
  end

  private

  def format_cellphone
    Phoner::Phone.default_country_code = '1'
    self.cellphone = Phoner::Phone.parse self.cellphone
  end

  def format_name
    self.name.downcase!
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end

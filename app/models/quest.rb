class Quest < ActiveRecord::Base
  has_many :journeys
  has_many :users, through: :journeys

  validates :grail, presence: true
  validates :description, presence: true
end

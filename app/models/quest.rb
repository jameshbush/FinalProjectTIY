class Quest < ActiveRecord::Base

  validates :grail, presence: true
  validates :description, presence: true
end

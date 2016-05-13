class Report < ActiveRecord::Base
  belongs_to :journey
  attachment :image
  validates_inclusion_of :survey, in: 1..10, allow_blank: true
end

class Journey < ActiveRecord::Base
  belongs_to :quest
  belongs_to :user
  has_many :reports
end

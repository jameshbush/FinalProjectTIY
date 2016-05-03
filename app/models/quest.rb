class Quest < ActiveRecord::Base
  validates :type, presence: true
  self.inheritance_column = :_type_disabled
  validates :description, presence: true
end

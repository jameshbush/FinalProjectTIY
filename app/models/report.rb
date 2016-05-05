class Report < ActiveRecord::Base
  belongs_to :journey
  attachment :image
end

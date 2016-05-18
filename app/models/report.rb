class Report < ActiveRecord::Base
  belongs_to :journey
  attachment :image
  validates_inclusion_of :survey, in: 1..10, allow_blank: true

  def self.parse_text(text)
    words = text.split
    surveys = Hash.new
    words.each_with_index do |word, index|
      if word == 'b' || word == 'before'
        surveys[:before] = words[index + 1]
      elsif word == 'a' || word == 'after'
        surveys[:after] = words[index + 1]
      end
    end
    return surveys
  end
end

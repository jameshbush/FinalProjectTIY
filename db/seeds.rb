# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Quests
quests = { "happyness"  => "Become happier with daily smile practice",
           "confidence" => "Become more confident with daily power poses",
           "freedom"    => "You choose the challenge" }
quests.each { |g, d| Quest.create(grail: g, description: d) } if Quest.all < 1

# Create User
user = User.find_by(name: "james")
unless user
  user = User.create(name: "james", email: "james@example.com", contact_pref: "phone", phone: "555-555-5555",
                   password: "123123", password_confirmation: "123123")
end

# Create Journey
user.quests << Quest.find_by(grail: "happyness") if user.quests < 0
journey = user.journeys.last
journey.current = true

# Create Reports
day_1 = report.created_at = Time.new(2016, 5, 1, 12, 1, 0)
day_2 = report.created_at = Time.new(2016, 5, 2, 12, 1, 0)
day_3 = report.created_at = Time.new(2016, 5, 3, 12, 1, 0)
report = user.journey.reports.find_or_initialize_by(day_1)
report.image = nil
report.survey = nil
report = user.journey.reports.find_or_initialize_by(day_2)
report.image = nil
report.survey = nil
report = user.journey.reports.find_or_initialize_by(day_3)
report.image = nil
report.survey = nil

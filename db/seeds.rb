# Create Quests
quests = { "happyness"  => "Become happier with daily smile practice",
           "confidence" => "Become more confident with daily power poses",
           "freedom"    => "You choose the challenge" }
quests.each { |g, d| Quest.create(grail: g, description: d) } if Quest.count < 1

# Create User
user = User.find_or_create_by(email: "jamesbvsh@gmail.com")
unless user
  user = User.create(name: ENV["SEED_NAME"], email: ENV["SEED_EMAIL"],
                     contact_pref: "phone", cellphone: ENV["SEED_CELL"],
                     password: ENV["SEED_PW"], password_confirmation: ENV["SEED_PW"])
end

# Create Journey
user.quests << Quest.find_by(grail: "happiness") if user.quests.count < 1
journey = user.journeys.last
journey.current = true
journey.save!


# Create Reports
user.current_journey.reports.each { |report| report.delete }

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 1, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may1.jpeg")
report.survey = 4
report.postsurvey = 7
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 2, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may2.jpeg")
report.survey = 5
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 3, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may3.jpeg")
report.survey = 6
report.postsurvey = 7
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 4, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may4.jpeg")
report.survey = 6
report.postsurvey = 10
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 5, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may5.jpeg")
report.survey = 5
report.postsurvey = 9
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 6, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may6.jpeg")
report.survey = 6
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 7, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may7.jpeg")
report.survey = 8
report.postsurvey = 9
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 8, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may8.jpeg")
report.survey = 4
report.postsurvey = 7
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 9, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may9.jpeg")
report.survey = 8
report.postsurvey = 7
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 10, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may10.jpeg")
report.survey = 6
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 11, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may11.jpeg")
report.survey = 8
report.postsurvey = 9
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 12, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may12.jpeg")
report.survey = 6
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 13, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may13.jpeg")
report.survey = 5
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 14, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may14.jpeg")
report.survey = 4
report.postsurvey = 6
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 15, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may15.jpeg")
report.survey = 7
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 16, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may16.jpeg")
report.survey = 6
report.postsurvey = 9
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 17, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may17.jpeg")
report.survey = 7
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 18, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may18.jpeg")
report.survey = 8
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 19, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may19.jpeg")
report.survey = 6
report.postsurvey = 8
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 20, 12, 1, 0))
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 21, 12, 1, 0))
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 22, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may22.jpeg")
report.survey = 8
report.postsurvey = 9
report.save!

report = journey.reports.find_or_initialize_by(created_at: Time.new(2016, 5, 23, 12, 1, 0))
report.image = File.open("lib/seed_imgs/may23.jpeg")
report.survey = 9
report.postsurvey = 10
report.save!

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Quest.all.each{ |q| q.destroy! }

quests = { "happyness"  => "Become happier with daily smile practice",
           "confidence" => "Become more confident with daily power poses",
           "freedom"    => "You choose the challenge" }
quests.each { |g, d| Quest.create(grail: g, description: d) }

task remind_users: :environment do
  @users_to_contact = User.has_current_journey.prefer_phone_scope

  @users_to_contact.each{ |user| puts "#{user}" }
end

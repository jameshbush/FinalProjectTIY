class AddDefaultsToUsers < ActiveRecord::Migration
  def change
    change_column_default(:users, :phone_verified, false)
    change_column_default(:users, :email_verified, false)
    change_column_default(:users, :country_code, "+1")
  end
end

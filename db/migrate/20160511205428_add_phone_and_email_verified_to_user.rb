class AddPhoneAndEmailVerifiedToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_verified, :boolean
    add_column :users, :email_verified, :boolean
  end
end

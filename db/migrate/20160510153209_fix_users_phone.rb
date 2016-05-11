class FixUsersPhone < ActiveRecord::Migration
  def change
    rename_column :users, :phone, :cellphone
    add_column :users, :authy_id, :string
    add_column :users, :country_code, :string
  end
end

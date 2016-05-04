class CreateQuests < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.references :quest, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :current

      t.timestamps null: false
    end
  end
end

class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :type
      t.text :description

      t.timestamps null: false
    end
  end
end

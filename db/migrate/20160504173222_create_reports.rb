class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :survey
      t.references :journey, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

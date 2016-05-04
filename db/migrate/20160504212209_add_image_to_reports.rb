class AddImageToReports < ActiveRecord::Migration
  def change
    add_column :reports, :image_id, :string
  end
end

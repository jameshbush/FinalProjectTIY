class AddPostsurveyToReport < ActiveRecord::Migration
  def change
    add_column :reports, :postsurvey, :integer
  end
end

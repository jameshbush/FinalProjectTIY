class ChangeQuestTypeName < ActiveRecord::Migration

  def change
    rename_column :quests, :type, :grail
  end
end

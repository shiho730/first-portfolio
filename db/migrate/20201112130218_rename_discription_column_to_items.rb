class RenameDiscriptionColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :discription, :description
  end
end

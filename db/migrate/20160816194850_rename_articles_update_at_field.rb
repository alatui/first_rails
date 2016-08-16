class RenameArticlesUpdateAtField < ActiveRecord::Migration[5.0]
  def change
    rename_column :articles, :update_at, :updated_at
  end
end

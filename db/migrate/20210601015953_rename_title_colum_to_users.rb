class RenameTitleColumToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :title, :name
  end
end

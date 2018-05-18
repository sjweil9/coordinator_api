class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :last_name_string, :last_name
  end
end

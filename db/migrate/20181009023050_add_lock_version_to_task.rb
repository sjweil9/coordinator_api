class AddLockVersionToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :lock_version, :integer
  end
end

class AddCreatedToTaskUser < ActiveRecord::Migration[5.2]
  def change
    add_column :task_users, :created, :boolean
  end
end

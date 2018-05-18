class CreateTaskUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :task_users do |t|
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end

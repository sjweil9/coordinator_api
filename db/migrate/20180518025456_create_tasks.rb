class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status
      t.datetime :completed_at
      t.datetime :due_at

      t.timestamps
    end
  end
end

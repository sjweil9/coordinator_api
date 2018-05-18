class CreateListUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :list_users do |t|
      t.references :list, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :creator

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :email_confirmed
      t.string :confirm_token
      t.string :unlock_token
      t.boolean :account_locked
      t.integer :login_attempts

      t.timestamps
    end
  end
end

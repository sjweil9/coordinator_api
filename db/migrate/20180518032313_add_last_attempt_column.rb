class AddLastAttemptColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_attempt, :datetime
  end
end

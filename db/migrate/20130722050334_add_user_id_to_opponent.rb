class AddUserIdToOpponent < ActiveRecord::Migration
  def change
    add_column :opponents, :user_id, :integer
    add_index :opponents, [:user_id, :created_at]
  end
end

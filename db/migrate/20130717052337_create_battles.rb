class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :user_id
      t.integer :opponent_id
      t.integer :winner_id
      t.integer :loser_id
      t.integer :money_transferred

      t.timestamps
    end
    add_index :battles, [:user_id, :created_at]
    add_index :battles, [:opponent_id, :created_at]
    add_index :battles, [:winner_id, :created_at]
    add_index :battles, [:loser_id, :created_at]
  end
end

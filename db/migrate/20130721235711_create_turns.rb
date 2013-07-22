class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :battle_id

      t.timestamps
    end
    add_index :turns, [:battle_id, :created_at]
  end
end

class CreateBattleActions < ActiveRecord::Migration
  def change
    create_table :battle_actions do |t|
      t.integer :turn_id
      t.integer :user_id
      t.integer :opponent_id
      t.integer :pet_id
      t.integer :opponent_pet_id

      t.string :type

      # For attacks
      t.integer :attack_id
      t.integer :pet_damage, default: 0
      t.integer :opponent_pet_damage, default: 0
      t.integer :pet_status_id
      t.integer :opponent_pet_status_id

      # For running away
      t.boolean :run_successful, default: false

      # For using items
      t.integer :item_id
      t.integer :item_target_id

      # For switching
      t.integer :switch_to_pet_id

      t.timestamps
    end
    add_index :battle_actions, [:turn_id, :created_at]
  end
end

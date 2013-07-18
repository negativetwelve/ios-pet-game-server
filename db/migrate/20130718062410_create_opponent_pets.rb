class CreateOpponentPets < ActiveRecord::Migration
  def change
    create_table :opponent_pets do |t|
      t.string :name
      t.string :nickname
      t.string :type
      t.integer :level, default: 1
      t.integer :experience, default: 0
      t.integer :experience_rate, default: 0
      t.integer :attack, default: 0
      t.integer :attack_rate, default: 0
      t.integer :special_attack, default: 0
      t.integer :special_attack_rate, default: 0
      t.integer :defense, default: 0
      t.integer :defense_rate, default: 0
      t.integer :special_defense, default: 0
      t.integer :special_defense_rate, default: 0
      t.integer :speed, default: 0
      t.integer :speed_rate, default: 0
      t.integer :catch_rate, default: 0

      t.integer :curr_hp, default: 0
      t.integer :max_hp, default: 0

      t.integer :opponent_id

      t.timestamps
    end
    add_index :opponent_pets, [:opponent_id, :created_at]
  end
end

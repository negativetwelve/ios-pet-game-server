class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
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

      t.integer :user_id

      t.timestamps
    end
    add_index :pets, [:user_id, :created_at]
  end
end

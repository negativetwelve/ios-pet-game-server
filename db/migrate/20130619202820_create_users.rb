class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.boolean :admin, default: false
      t.string :app_id
      t.string :character
      t.integer :skill_level, default: 1
      t.integer :money, default: 0
      t.integer :bank, default: 0
      t.integer :money_rate, default: 0
      t.integer :energy, default: 0
      t.integer :energy_rate, default: 0

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :remember_token
  end
end

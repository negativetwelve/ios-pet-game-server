class CreateOpponents < ActiveRecord::Migration
  def change
    create_table :opponents do |t|
      t.integer :skill_level, default: 1
      t.integer :money, default: 0
      t.integer :bank, default: 0
      t.integer :money_rate, default: 0
      t.integer :energy, default: 0
      t.integer :energy_rate, default: 0

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.integer :price
      t.boolean :in_store
      t.boolean :in_battle
      t.boolean :can_sell

      t.integer :unlock_level

      t.timestamps
    end
  end
end

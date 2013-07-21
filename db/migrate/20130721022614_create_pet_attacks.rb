class CreatePetAttacks < ActiveRecord::Migration
  def change
    create_table :pet_attacks do |t|
      t.integer :pet_id
      t.integer :attack_id
      t.integer :pp

      t.timestamps
    end
    add_index :pet_attacks, [:pet_id, :created_at]
    add_index :pet_attacks, [:attack_id, :created_at]
  end
end

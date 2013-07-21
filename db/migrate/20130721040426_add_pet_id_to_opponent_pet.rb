class AddPetIdToOpponentPet < ActiveRecord::Migration
  def change
    add_column :opponent_pets, :pet_id, :integer
  end
end

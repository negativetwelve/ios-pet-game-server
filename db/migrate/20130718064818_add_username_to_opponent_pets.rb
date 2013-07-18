class AddUsernameToOpponentPets < ActiveRecord::Migration
  def change
    add_column :opponents, :username, :string
    add_column :opponents, :character, :string
  end
end

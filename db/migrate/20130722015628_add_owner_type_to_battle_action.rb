class AddOwnerTypeToBattleAction < ActiveRecord::Migration
  def change
    add_column :battle_actions, :owner_type, :string
  end
end

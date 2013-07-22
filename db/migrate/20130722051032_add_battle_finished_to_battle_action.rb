class AddBattleFinishedToBattleAction < ActiveRecord::Migration
  def change
    add_column :battle_actions, :battle_finished, :boolean
  end
end

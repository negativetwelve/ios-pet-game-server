class BattleAction < ActiveRecord::Base
  attr_accessible :pet_id, :opponent_pet_id, :pet_damage, :opponent_pet_damage, :pet_status_id, :opponent_pet_status_id, :type, :battle_finished

  def to_json
    return {
      owner_type: owner_type,
      type: type,

      attack_id: attack_id,
      pet_damage: pet_damage,
      opponent_pet_damage: opponent_pet_damage,
      pet_status_id: pet_status_id,
      opponent_pet_status_id: opponent_pet_status_id,

      run_successful: run_successful,

      item_id: item_id,
      item_target_id: item_target_id,

      switch_to_pet_id: switch_to_pet_id,

      battle_finished: battle_finished,
    }
  end

end

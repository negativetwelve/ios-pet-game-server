require 'pet_battle_features'

class OpponentPet < ActiveRecord::Base
  include PetBattleFeatures

  attr_accessible :name, :level, :curr_hp, :max_hp, :attack, :special_attack, :defense, :special_defense, :speed, :pet_id

  belongs_to :opponent

  def self.copy(opponent_pet)
    opp_pet = OpponentPet.new(opponent_pet.to_opponent_pet)
    opp_pet.pet_id = opponent_pet.id
    if opp_pet && opp_pet.save
      return opp_pet
    else
      return false
    end
  end

  def to_json
    return {
      encid: id,
      name: name,
      level: level,
      curr_hp: curr_hp,
      max_hp: max_hp,
      attack: attack,
      special_attack: special_attack,
      defense: defense,
      special_defense: special_defense,
      speed: speed,

      attacks: attacks,
    }
  end

  def attacks
    original_pet = Pet.find(self.pet_id)
    original_pet.attacks
  end

  # Battle logic for attacks
  def make_attack(user_pet, attack)
    return {
      type: "attack",
      pet_id: id,
      opponent_pet_id: user_pet.id,
      pet_damage: 0,
      opponent_pet_damage: 1,
      pet_status_id: nil,
      opponent_pet_status_id: nil,
    }
  end


end

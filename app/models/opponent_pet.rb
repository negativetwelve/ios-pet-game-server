require 'pet_battle_features'

class OpponentPet < ActiveRecord::Base
  include PetBattleFeatures

  attr_accessible :name, :level, :curr_hp, :max_hp, :attack, :special_attack, :defense, :special_defense, :speed

  belongs_to :opponent

  def self.copy(opponent_pet)
    opp_pet = OpponentPet.new(opponent_pet.to_opponent_pet)
    if opp_pet
      opp_pet.save
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
    }
  end

end

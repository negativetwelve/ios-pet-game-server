require 'pet_battle_features'

class Pet < ActiveRecord::Base
  include PetBattleFeatures

  attr_accessible :name

  validates :name, presence: true

  belongs_to :user
  has_many :pet_attacks
  has_many :attacks, through: :pet_attacks

  def to_json
    return {
      encid: id,
      name: name,
      level: level,
      experience: experience,
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

  def to_opponent_pet
    return {
      id: id,
      name: name,
      level: level,
      curr_hp: max_hp,  # Opponent always starts with full health.
      max_hp: max_hp,
      attack: attack,
      special_attack: special_attack,
      defense: defense,
      special_defense: special_defense,
      speed: speed,
    }
  end

  def attacks
    pet_attacks.map { |pa| {
        encid: pa.attack.id,
        name: pa.attack.name,
        pp: pa.pp,
      }
    }
  end

  def learn(attack)
    pet_attacks.create(attack_id: attack.id, pp: attack.pp)
  end

  # Battle logic for attacks
  def make_attack(opponent_pet, attack)
    return {
      type: "attack",
      pet_id: id,
      opponent_pet_id: opponent_pet.id,
      pet_damage: 0,
      opponent_pet_damage: 10,
      pet_status_id: nil,
      opponent_pet_status_id: nil,
    }
  end

end

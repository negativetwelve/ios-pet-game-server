require 'pet_battle_features'

class Pet < ActiveRecord::Base
  include PetBattleFeatures

  attr_accessible :name

  validates :name, presence: true

  belongs_to :user

  def to_json
    return {
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
    }
  end
end

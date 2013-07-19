require 'user_battle_features'

class Opponent < ActiveRecord::Base
  include UserBattleFeatures

  attr_accessible :character, :username, :skill_level, :money, :bank, :money_rate, :energy, :energy_rate

  has_many :opponent_pets

  def self.copy(opponent_user)
    opponent = Opponent.new(opponent_user.to_opponent)
    opponent_user.pets.each do |pet|
      opponent.opponent_pets << OpponentPet.new(pet.to_opponent_pet)
    end
    if opponent
      opponent.save
      return opponent
    else
      return false
    end
  end

  def to_json
    return {
      encid: id,
      username: username,
      character: character,

      skill_level: skill_level,
      money: money,
      money_rate: money_rate,
      bank: bank,
      energy: energy,
      energy_rate: energy_rate,

      opponent_pets: opponent_pets_to_json,
    }
  end

  def opponent_pets_to_json
    return opponent_pets.collect {|opponent_pet| opponent_pet.to_json}
  end
end

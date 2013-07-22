require 'user_battle_features'

class Opponent < ActiveRecord::Base
  include UserBattleFeatures

  attr_accessible :character, :username, :skill_level, :money, :bank, :money_rate, :energy, :energy_rate, :user_id

  has_many :opponent_pets
  belongs_to :user

  def self.copy(opponent_user)
    opponent = Opponent.new(opponent_user.to_opponent)
    opponent.user_id = opponent_user.id
    opponent_user.pets.each do |pet|
      opponent.opponent_pets << OpponentPet.copy(pet)
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

      opponent_pets: pets_to_json,
    }
  end

  def pets
    opponent_pets
  end

  def make_action(user, params)
    # Temporary attack action
    user_pet = Pet.find(params[:pet_id])
    opponent_pet = OpponentPet.find(params[:opponent_pet_id])

    # Hard code in tackle for now.
    attack = Attack.find(2)
    opponent_pet.make_attack(user_pet, attack)
  end

  def execute_action(battle_action)
    case battle_action.type
    when 'attack'
      user_pet = OpponentPet.find(battle_action[:pet_id])
      opponent_pet = Pet.find(battle_action[:opponent_pet_id])

      opponent_pet.curr_hp -= battle_action.opponent_pet_damage
      user_pet.curr_hp -= battle_action.pet_damage

      if opponent_pet.curr_hp <= 0
        opponent_pet.curr_hp = 0
      end

      if user_pet.curr_hp <= 0
        user_pet.curr_hp = 0
      end

      if user_pet.save && opponent_pet.save
        return {
          pet_is_alive: user_pet.is_alive?,
          opponent_pet_is_alive: opponent_pet.is_alive?,
          pet_hp: user_pet.curr_hp,
          opponent_pet_hp: opponent_pet.curr_hp,
        }
      else
        puts "Problem saving user and opponent's pets."
      end

    else
      puts "Unable to execute battle action with id: #{battle_action.id}."
    end
  end

end

require 'user_battle_features'

class User < ActiveRecord::Base
  include UserBattleFeatures

  attr_accessible :username, :email, :password, :password_confirmation, :app_id, :character
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?
  validates :password_confirmation, presence: true, if: :password_digest_changed?

  has_many :pets
  has_many :battles

  def self.to_json(users)
    return users.collect {|user| user.to_json}
  end

  def to_json
    return {
      encid: id,
      username: username,
      character: character,
      in_battle: in_battle,

      skill_level: skill_level,
      money: money,
      money_rate: money_rate,
      bank: bank,
      energy: energy,
      energy_rate: energy_rate,

      wins: wins,
      losses: losses,
      run_aways: run_aways,
      passive_wins: passive_wins,
      passive_losses: passive_losses,
      passive_run_aways: passive_run_aways,

      user_pets: pets_to_json,
    }
  end

  def to_opponent
    return {
      username: username,
      character: character,
      skill_level: skill_level,
      money: money,
      bank: bank,
      money_rate: money_rate,
      energy: energy,
      energy_rate: energy_rate,
    }
  end

  def make_action(opponent, type, params)
    case type
    when 'attack'
      pet = Pet.find(params[:pet_id])
      opponent_pet = OpponentPet.find(params[:opponent_pet_id])
      attack = Attack.find(params[:attack_id])
      pet.make_attack(opponent_pet, attack)
    else
      puts "Unrecognized type: #{type}"
    end
  end

  def execute_action(battle_action)
    case battle_action.type
    when 'attack'
      user_pet = Pet.find(battle_action[:pet_id])
      opponent_pet = OpponentPet.find(battle_action[:opponent_pet_id])

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

  def won(battle, opponent)
    opponent_user = opponent.user
    self.wins += 1
    opponent_user.passive_losses += 1
    self.in_battle = false

    self.save && opponent_user.save
  end

  def lost(battle, opponent)
    opponent_user = opponent.user
    self.losses += 1
    opponent_user.passive_wins += 1
    self.in_battle = false

    self.save && opponent_user.save
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

class User < ActiveRecord::Base
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

  def pets_to_json
    return pets.collect {|pet| pet.to_json}
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
